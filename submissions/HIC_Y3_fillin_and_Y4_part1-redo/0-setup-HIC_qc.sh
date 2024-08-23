BUCKET_PATH="s3://human-pangenomics/submissions/BCB80684-0E0F-487D-9C76-C5D0F8CD333F--HIC_Y3_fillin_and_Y4_part1-redo/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > HIC_Y3_fillin_and_Y4_part1-redo.csv


### wrangle HIC ###

python3 1-wrangle-HIC.py

###


mkdir hic_qc
cd hic_qc
mkdir -p input_jsons
mkdir -p slurm_logs

cd input_jsons

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hic_qc_sample_files.csv \
     --field_mapping ../hic_qc_input_mapping.csv \
     --workflow_name hic_qc_workflow

cd ..

sbatch --job-name=HiC_Y3_fillin_and_Y4_part1 --array=[1-366]%36 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_qc_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/test-setup/HPRC_metadata/submissions/HIC_Y3_fillin_and_Y4_part1-redo/hic_qc/input_jsons/${SAMPLE_ID}_hic_qc_workflow.json'

# NOTE: updated hic_qc_input_mapping.csv
python3 /private/groups/hprc/hprc_intermediate_assembly/hpc/update_table_with_outputs.py \
      --input_data_table hic_qc_sample_files.csv  \
      --output_data_table hic_qc_sample_output.csv  \
      --json_location '{sample_id}_hic_qc_workflow_outputs.json'