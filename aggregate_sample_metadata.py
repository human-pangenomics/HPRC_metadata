#!/usr/bin/env python3

"""
Author: Andrew Blair
Contact: apblair@ucsc.edu
python3 aggregate_sample_metadata.py --hprc_metadata_sample_files_modality data-tables/sample-files/hprc_metadata_sample_files_ONT.tsv --columns_1_submitter data-tables/aggregate-sample-inputs/hprc_1_submitter_columns_ONT.tsv --columns_5_readstat data-tables/aggregate-sample-inputs/hprc_5_readstats_columns_ONT.tsv --aggregate_rule_5_readstat_sample data-tables/aggregate-sample-inputs/hprc_5_readstat_sample_aggregate_rules_ONT.tsv
"""

import sys
import os
import re
import argparse
import textwrap
import numpy as np
import pandas as pd

# Setup argument parser
parser = argparse.ArgumentParser(
    formatter_class=argparse.RawDescriptionHelpFormatter,
    description=textwrap.dedent('''\
        Aggregate hprc_metadata_sample_files_[ONT, DEEPCONSENSUS, HiFi] based on merge_metadata.py.
    ''')
)

# Required arguments
group = parser.add_argument_group('required arguments')
group.add_argument('--hprc_metadata_sample_files_modality', type=argparse.FileType('r'), help="HPRC metadata sample file single technology modality from list [ONT, DEEPCONSENSUS, HiFi].")
group.add_argument('--columns_1_submitter', type=argparse.FileType('r'), help="HPRC 1_submitter columns expected to be present for all samples in a collaborator's submission directory.")
group.add_argument('--columns_5_readstat', type=argparse.FileType('r'), help="HPRC 5_reastat columns expected to be present for all samples in a collaborator's submission directory.")
group.add_argument('--aggregate_rule_5_readstat_sample', type=argparse.FileType('r'), help="HPRC 5_readstat sample aggregate rules from all samples files in a collaborator's submission directory.")


def check_missing_1_submitter(sample_df, required_1_submitter_columns, sequencing_technology):
    
    require_1_submitter_dict = {sample: {key: None for key in required_1_submitter_columns} for sample in sample_df['sample_ID'].tolist()}
    
    for sample in list(set(sample_df['sample_ID'].tolist())):
        sample_array = sample_df[sample_df['sample_ID'].isin([sample])][required_1_submitter_columns].values

        assert len(required_1_submitter_columns) == sample_array.shape[1]

        for column_index in range(sample_array.shape[1]):

            if np.all(sample_array[:, column_index] == sample_array[0, column_index]):
                require_1_submitter_dict[sample][required_1_submitter_columns[column_index]] = sample_array[0, column_index]
            else:
                require_1_submitter_dict[sample][required_1_submitter_columns[column_index]] = sample_array[:, column_index]
    
    samples_missing_1_submitter = _samples_missing_1_submitter(require_1_submitter_dict)
    
    submitter_df = pd.DataFrame.from_dict(require_1_submitter_dict, orient='index')
    
    if len(samples_missing_1_submitter) > 0:
        submitter_df[submitter_df['sample_ID'].isin(samples_missing_1_submitter)].to_csv('data-tables/aggregate-sample-outputs/hprc_metadata_sample_files_missing_1_submitter_' + sequencing_technology + '.tsv', sep='\t')
        
    return submitter_df, list(set(samples_missing_1_submitter))


def _samples_missing_1_submitter(require_1_submitter_dict):
    
    samples_missing_1_submitter = []
    for sample_id, meta_dict in require_1_submitter_dict.items():
        for key, value in meta_dict.items():
            if isinstance(value, np.ndarray):
                if any(item == 'nan' or pd.isna(item) for item in value):
                    if key == 'notes':
                        pass
                    else:
                        samples_missing_1_submitter.append(sample_id)
    return samples_missing_1_submitter


def sample_aggregate_5_readstats(sample_df, required_readstat_columns, readstat_dict):

    sample_5_readstats_df = sample_df[required_readstat_columns]
    sample_5_readstats_df = sample_5_readstats_df.groupby('sample_ID').agg(readstat_dict).reset_index()
    
    return sample_5_readstats_df

def check_sample_file_notes(sample_files_df):
    # Remove notes if all nan
    if sample_files_df['notes'].isnull().all() == True:
        sample_files_df = sample_files_df.drop('notes', axis=1)
    return sample_files_df


def main():
    
    args = parser.parse_args()
    
    sample_files_df = pd.read_csv(args.hprc_metadata_sample_files_modality, sep='\t')
    sequencing_technology = args.hprc_metadata_sample_files_modality.name.split('_')[-1].split('.tsv')[0]
    
    sample_files_df = check_sample_file_notes(sample_files_df)
    
    required_1_submitter_columns = pd.read_csv(args.columns_1_submitter, sep='\t')
    required_1_submitter_columns = required_1_submitter_columns['1_submitter_columns'].tolist()

    required_5_readstats_columns = pd.read_csv(args.columns_5_readstat, sep='\t')
    required_5_readstats_columns = required_5_readstats_columns['5_readstats_columns'].tolist()
    
    required_5_readstat_sample_aggregate_rules_dict = pd.read_csv(args.aggregate_rule_5_readstat_sample, sep='\t', index_col=[0]).to_dict()['0']
    
    sample_1_submitter_df, samples_missing_1_submmiter = check_missing_1_submitter(sample_files_df, required_1_submitter_columns, sequencing_technology)
    sample_readstats_df = sample_aggregate_5_readstats(sample_files_df, required_5_readstats_columns, required_5_readstat_sample_aggregate_rules_dict)

    sample_df = pd.merge(sample_1_submitter_df, sample_readstats_df, on='sample_ID')
    sample_df.to_csv('data-tables/aggregate-sample-outputs/hprc_metadata_sample_aggregate_' + sequencing_technology + '.tsv', sep='\t')


if __name__ == "__main__":
    main()

