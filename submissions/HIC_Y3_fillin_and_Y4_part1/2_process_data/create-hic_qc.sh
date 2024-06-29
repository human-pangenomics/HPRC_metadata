BUCKET_PATH="s3://human-pangenomics/submissions/F346B183-CEE4-41BF-BBEE-E4335B20B8B2--HIC_Y3_fillin_and_Y4_part1/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > HIC_Y3_fillin_and_Y4_part1.csv


python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hic_sample_files.csv \
     --field_mapping ../hic_qc_input_mapping.csv \
     --workflow_name hic_qc_workflow_Y3_fillin_and_Y4_part1


sbatch --job-name=HiC_Y3_fillin_and_Y4_part1 --array=[1-972]%16 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/Y4_HIC_part1/3_data_processing/input_jsons/${SAMPLE_ID}_hic_qc_workflow_Y3_fillin_and_Y4_part1.json'


python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hic_sample_NA20503_files.csv \
     --field_mapping ../hic_qc_input_mapping.csv \
     --workflow_name hic_qc_workflow_Y3_fillin_and_Y4_part1

sbatch --job-name=HiC_Y3_fillin_and_Y4_part1 --array=[1-9]%9 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_sample_NA20503_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/Y4_HIC_part1/3_data_processing/input_jsons/${SAMPLE_ID}_hic_qc_workflow_Y3_fillin_and_Y4_part1.json'


# updated the hic sample files csv columns from file_id to sample_id for the dev-update_table_with_outputs.py to work

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/dev-update_table_with_outputs.py      --input_data_table hic_sample_files.csv      --output_data_table hic_samples_output_table.csv      --json_location '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/Y4_HIC_part1/3_data_processing/{sample_id}/{sample_id}_hic_qc_workflow_outputs.json'


python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/dev-update_table_with_outputs.py      --input_data_table hic_sample_NA20503_files.csv      --output_data_table hic_sample_NA20503_output_table.csv      --json_location '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/Y4_HIC_part1/3_data_processing/{sample_id}/{sample_id}_hic_qc_workflow_outputs.json'