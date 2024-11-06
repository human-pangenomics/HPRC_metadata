import pandas as pd

# Load hifi QC data
hifi_df = pd.read_csv('hifi_qc/hifi_qc_samples_output_table.csv')
hifi_qc = pd.concat([pd.read_csv(qc, sep='\t') for qc in hifi_df['hifi_qc_summary'].tolist()])
hifi_qc['sample_id'] = [sample.split('-')[0] for sample in hifi_qc['filename'].tolist()]

# Drop unnecessary columns
hifi_qc.drop(columns=['all_kinetics_flag', 'keep_kinetics_flag', 'hifi_kinetics_tag', 'PP_PRIMROSE', 'fi_tag', 'ri_tag', 'fp_tag', 'rp_tag'], inplace=True)

# Calculate coverage
# coverage_df = hifi_qc.groupby('sample_id')['total_Gbp'].sum().div(3.1).reset_index(name='coverage')

# Save the output QC file with the project name
hifi_qc.to_csv('RU_Y3_HIFI_sample_file_hifi_qc.csv', index=False)  # Placeholder for project-specific filename
