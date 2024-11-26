# List all pass.bam files in the specified S3 bucket and save their S3 paths to a CSV file
aws s3 ls s3://human-pangenomics/submissions/CBC1E2D6-3925-4CD0-9682-555C64F81B02--UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6/ --recursive | grep pass.bam$ | awk '{print "s3://human-pangenomics/" $4}' > UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_passbams.csv

# List all txt.gz files in the specified S3 bucket and save their S3 paths to a CSV file
aws s3 ls s3://human-pangenomics/submissions/CBC1E2D6-3925-4CD0-9682-555C64F81B02--UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6/ --recursive | grep txt.gz$ | awk '{print "s3://human-pangenomics/" $4}' > UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_seqsum.csv

# List all fail.bam files in the specified S3 bucket and save their S3 paths to a CSV file
aws s3 ls s3://human-pangenomics/submissions/CBC1E2D6-3925-4CD0-9682-555C64F81B02--UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6/ --recursive | grep fail.bam$ | awk '{print "s3://human-pangenomics/" $4}' > UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_failbams.csv

# Process each pass.bam file in the passbams CSV file
for i in $(cat UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_passbams.csv); do
  id=$(echo $i | cut -d/ -f6); # Extract the ID from the S3 path
  echo $(basename $i), \
    $i, \
    $(echo $i | sed 's/pass.bam/sequencing_summary.txt.gz/g'), \
    \[\"$(find /private/groups/hprc/1000G_local/child/fastq/ -name *${id}*)\"\] \
  >> UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_sample_table.csv;
done

# List all files in the specified S3 bucket and format their paths for the TRUSEQ sample table
aws s3 ls s3://human-pangenomics/submissions/30E441F3-6820-4BF6-BCF4-E64D56C8D6A4--TRUSEQ/ --recursive | \
awk '{print "s3://human-pangenomics/" $4}' | \
awk -F'/' '
{
  sample=$6;
  if (sample != last_sample && NR > 1) {
  printf "]\n"
  }
  if (sample != last_sample) {
  if (NR > 1) {
    printf "\n"
  }
  printf "%s, [", sample
  }
  printf "\x27%s\x27,", $0;
  last_sample=sample;
}
END {
  print "]"
}' | sed 's/,]/]/g' >> TRUSEQ_sample_table_s3locs.csv

# Create directory structure
mkdir -p batch_processing/slurm_logs
mkdir -p batch_processing/input_jsons

# Create input JSONs
cd batch_processing/input_jsons
python /private/nanopore/hprc_qc/scripts/launch_from_table.py \
  --data_table /private/nanopore/hprc_qc/UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6/UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_sample_table.csv \
  --field_mapping /private/nanopore/hprc_qc/scripts/ont_qc_input_mapping.csv \
  --workflow_name ont_qc_workflow

cd ../

# Submit the job to the SLURM scheduler
sbatch \
  --job-name=ont_qc-slurm-Y1_wTopOff \
  --array=1-187%50 \
  --partition=long \
  /private/nanopore/hprc_qc/scripts/toil_sbatch_slurm.sh \
  --wdl ~/hpp_production_workflows/data_processing/wdl/workflows/ont_qc_workflow.wdl \
  --sample_csv /private/nanopore/hprc_qc/UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6/UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_sample_table.csv \
  --input_json_path '/private/nanopore/hprc_qc/UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6/batch_processing/input_jsons/${SAMPLE_ID}_ont_qc_workflow.json'


# Aggregate the summary files
for i in $(find . -name *summary.tsv);     do tail -n 1 $i ; done | sort -k 22 | column -t > UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_summary_agg.tsv

# Create the release CSV file

# Check the number of rows in the input
wc -l UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_passbams.csv

# Replace the S3 submission paths with working paths in the passbams CSV file
sed 's|submissions/CBC1E2D6-3925-4CD0-9682-555C64F81B02--UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6|working/HPRC|g' UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_passbams.csv | sed 's|/guppy_6/|/raw_data/nanopore/guppy_6/|g' > s3locs_passbams_hprc_working_destination.list

# Replace the S3 submission paths with working paths in the seqsum CSV file
sed 's|submissions/CBC1E2D6-3925-4CD0-9682-555C64F81B02--UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6|working/HPRC|g' UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_seqsum.csv | sed 's|/guppy_6/|/raw_data/nanopore/guppy_6/|g' > s3locs_seqsum_hprc_working_destination.list

# Replace the S3 submission paths with working paths in the failbams CSV file
sed 's|submissions/CBC1E2D6-3925-4CD0-9682-555C64F81B02--UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6|working/HPRC|g' UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_failbams.csv | sed 's|/guppy_6/|/raw_data/nanopore/guppy_6/|g' > s3locs_failbams_hprc_working_destination.list

# Check if the working paths don't exist
for i in $(cat s3locs*list); do
  echo $i;
  aws s3 ls $i;
done

# Paste the submission and working paths together for the passbams CSV file
paste UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_passbams.csv s3locs_passbams_hprc_working_destination.list -d, > passbams_paste.csv

# Paste the submission and working paths together for the seqsum CSV file
paste UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_seqsum.csv s3locs_seqsum_hprc_working_destination.list -d, > seqsum_paste.csv

# Paste the submission and working paths together for the failbams CSV file
paste UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_failbams.csv s3locs_failbams_hprc_working_destination.list -d, > failbams_paste.csv

# Concatenate the passbams, seqsum, and failbams CSV files into the release CSV file
cat passbams_paste.csv seqsum_paste.csv failbams_paste.csv > UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_release.csv

# Confirm that the number of rows in the release CSV file matches the input
wc -l *paste.csv
wc -l UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_release.csv

#list out tars not in working yet
for i in $(cat UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_passbams.csv); do echo $i $(grep $(basename $i | sed 's/_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam//g').*fast5.tar ../recursive_lists/working.recursive.list.20240702) | grep  working >> bamlist_fast5_in_working.list; do
ne

for i in $(cat UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_s3locs_passbams.csv); do echo $i $(grep $(basename $i | sed 's/_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam//g').*fast5.tar ../recursive_lists/working.recursive.list.20240702) | grep -v working >> bamlist_fast5_not_in_working.list; do
ne

#list out tars not in working yet from UCSC (rerun this after HG00673 renaming tars completes)
for i in $(cat bamlist_fast5_not_in_working.list); do echo $i $(grep $(basename $i | sed 's/_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam//g').*fast5.tar ../recursive_lists/submissions.recursive.list.20240627 | awk '{print "s3://human-pangenomics/" $4}') | grep -v .bam$ | cut -d" " -f2 >> ucsc_top_off_tar.list; done

for i in $(cat bamlist_fast5_not_in_working.list); do echo $i $(grep $(basename $i | sed 's/_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam//g' | cut -d_ -f2).*fast5.tar ../recursive_lists/submissions.recursive.list.20240627 | awk '{print "s3://human-pangenomics/" $4}') | grep -v .bam$ | cut -d" " -f2 | grep NISC >> nisc_top_off_tar.list; done


# Replace the S3 submission paths with working paths in the tar CSV file
cat ucsc_top_off_tar.list nisc_top_off_tar.list | sed  's|submissions/CBC1E2D6-3925-4CD0-9682-555C64F81B02--UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6|working/HPRC|g' > tar_working_destination.list
paste submission_tar.list tar_working_destination.list -d, > UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_tar_release.csv