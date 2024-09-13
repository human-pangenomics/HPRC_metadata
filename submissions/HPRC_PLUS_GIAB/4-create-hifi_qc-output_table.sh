
cd hifi_qc
# Change hic_sample_files column from file_id to sample_id
python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/update_table_with_outputs.py      --input_data_table hifi_qc_sample_files.csv      --output_data_table hifi_qc_samples_output_table.csv      --json_location '{sample_id}_hifi_qc_workflow_outputs.json'