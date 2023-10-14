#! /usr/bin/env python3

import sys, os, re, argparse, textwrap, csv
import pandas as pd

parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description=textwrap.dedent('''\

Expects a submissions directory with subdirectories:
    1_submitter_metadata containing .tsv files
    5_readstats with either the output of mergeSRAMetaReadstats.ipynb or a Readstats table, in .tsv
    8_sra_metadata containing the 'metadata processes ok' files generated by SRA

Input is the result of 
aws s3 ls s3://human-pangenomics/working --recursive --profile <your_profile> > s3.files

        '''))
group = parser.add_argument_group('required arguments')
group.add_argument('--flist', type=str, help='s3 file list')
group.add_argument('--prepend', type=str, default='s3://human-pangenomics/')
group.add_argument('--type', type=str, help='Wildcard for which submissions to include: HiFi, ONT, DEEPCONSENSUS')

if len(sys.argv)==1:
    parser.print_help()
    sys.exit(1)
args = parser.parse_args()
    
def list_submissions(parent_directory='submissions', type_wildcard=''):
    '''First level subdirectories excluding the empty submission'''
    subdirectories = []
    for item in os.listdir(parent_directory):
        item_path = os.path.join(parent_directory, item)
        # First, check if the item matches the type_wildcard
        if type_wildcard in item:
            # Then check if the path is a directory and doesn't end with 'empty_submission'
            if os.path.isdir(item_path) and not item_path.endswith('empty_submission'):
                subdirectories.append(item_path)
    return subdirectories


def find_tsv_files(submission_dirs, subdir):
    '''Expects tsv files in specific subdirectories of the submissions'''
    files = []
    for dirpath in submission_dirs:
        subdirpath = os.path.join(dirpath, subdir)
        for item in os.listdir(subdirpath):
            if item.endswith('.tsv'):
                files.append(os.path.join(subdirpath, item))
    return files
            
def combine_files(tsvfiles):
    '''Keep only the columns that are present in all files'''
    common_columns = None
    df = None
    
    for file_path in tsvfiles:
        temp_df = pd.read_csv(file_path, sep='\t')
        if common_columns is None:
            common_columns = set(temp_df.columns)
            df = temp_df.copy()
        else:
            common_columns = common_columns.intersection(set(temp_df.columns))
            df = pd.concat([df, temp_df[list(common_columns)]], ignore_index=True, sort=False)
    df = df.drop(columns=['file_size', 'md5sum', 'filetype'])
    return df

def combine_readstats(tsvfiles):
    '''Readstats output can have more columns than we need. Keep only the relevant ones'''
    keep = ['filename', 'total_reads', 'total_bp', 'total_Gbp', 'min', 'max', 'mean', 
           'quartile_25', 'quartile_50', 'quartile_75', 'N25', 'N50', 'N75']
    df = pd.DataFrame() 

    for file_path in tsvfiles:
        temp_df = pd.read_csv(file_path, sep='\t', usecols=keep)
        df = pd.concat([df, temp_df], ignore_index=True)
    return df
        
def combine_sra(tsvfiles):
    '''Keep accession IDs only; allow for multiple filename fields in inputs'''

    keep = ['accession', 'study', 'biosample_accession']
    sra_df = None
    
    for file_path in tsvfiles:
        df = pd.read_csv(file_path, delimiter='\t')
        df.rename(columns={'filename': 'filename_original'}, inplace=True)
        fnames = [x for x in df.columns.tolist() if x.startswith('filenam')]
        melted_df = pd.melt(df, id_vars=keep, value_vars=fnames, value_name='filename')
        # remove the column that contains the filenames
        melted_df = melted_df.drop('variable', axis=1)
        if sra_df is None:
            sra_df = melted_df.dropna(subset=['filename'])
        else:
            sra_df = pd.concat([sra_df, melted_df.dropna(subset=['filename'])], ignore_index=True, sort=False)
    return sra_df

def bucket_files(flist, prepend, file_type):
    '''Get all HPRC and HPRC_PLUS bam files in the s3 input file'''
    rows = []

    # Define a mapping between type and corresponding file extensions
    type_to_extension = {
        "HiFi": "bam",
        "ONT": "fastq.gz",
        "DEEPCONSENSUS": "fastq.gz",  # adjust if needed
    }

    # Get the corresponding file extension for the provided file_type
    file_extension = type_to_extension.get(file_type)

    with open(flist, 'r') as bucket:
        for line in bucket:
            line = line.strip()
            if line.endswith(file_extension) and re.search('/HPRC', line):
                # remove the file info
                fpath = line.split()[-1]
                fname = os.path.basename(fpath)
                rows.append({'filename': fname, 'path': prepend + fpath})
    return pd.DataFrame(rows, columns=['filename', 'path'])

def merge_by_filename(dflist):
    merged_df = dflist[0]
    for df in dflist[1:]:
        merged_df = pd.merge(
            merged_df,
            df,
            on='filename')
    return merged_df

## MAIN ##
submissions = list_submissions(type_wildcard=args.type)
submitter_files = find_tsv_files(submissions, '1_submitter_metadata')
submitter_df = combine_files(submitter_files)
readstats_files = find_tsv_files(submissions, '5_readstats')
readstats_df = combine_readstats(readstats_files)
sra_files = find_tsv_files(submissions, '8_sra_metadata')
sra_df = combine_sra(sra_files)
bucket_df = bucket_files(args.flist, args.prepend, args.type)



merged_df = merge_by_filename([bucket_df, sra_df, readstats_df, submitter_df])


# there may be more submitter or readstats info than sra, but not less, so check
if sra_df.shape[0] > merged_df.shape[0]:
    print("ERROR: some SRA submissions are not found in all files, please fix", file=sys.stderr)
    print(sra_df[~sra_df['filename'].isin(merged_df['filename'])], file=sys.stderr)
    sys.exit(1)

# a bit of organization
# drop the filename, rename path to filename
merged_df = merged_df.drop(columns=['filename'])
merged_df = merged_df.rename(columns={'path': 'filename'})
# because we started merging with the bucket, the fullpath filename is now first. If we sort on this, 
# samples will automatically be grouped 
merged_df = merged_df.sort_values(by='filename')
# the sample id should be second, so reorder the columns
columns = merged_df.columns.tolist()
columns.remove('sample_ID')
columns.insert(1, 'sample_ID')
merged_df = merged_df[columns]

output_filename = f"hprc_metadata_{args.type}.tsv"
merged_df.to_csv(output_filename, sep='\t', index=False)
print(f'Success. Output file is {output_filename}')

sys.exit()
