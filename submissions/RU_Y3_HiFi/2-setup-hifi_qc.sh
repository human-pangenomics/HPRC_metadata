### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/A3D02676-D52B-4717-9312-73F78255BBB3--RU_Y3_HIFI/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y3_HIFI.csv

### Wrangle Samples ###

python3 3-wrangle-hifi_qc.py

### Setup HiFi QC ### 
mkdir hific_qc
mkdir -p slurm_logs
mkdir -p input_jsons
cd input_jsons
python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hifi_qc_sample_files.csv  \
     --field_mapping ../hifi_qc_input_mapping.csv \
     --workflow_name hifi_qc_workflow

cd ..

sbatch --job-name=hifi-qc --array=[1-94]%32 --partition=high_priority- /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/test-setup/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_qc_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/test-setup/HPRC_metadata/submissions/RU_Y3_HiFi/hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow.json'

### Post HiFi QC completion ###

python3 /private/groups/hprc/hprc_intermediate_assembly/hpc/update_table_with_outputs.py \
      --input_data_table hifi_qc_sample_files.csv  \
      --output_data_table hifi_qc_sample_output.csv  \
      --json_location '{sample_id}_hifi_qc_workflow_outputs.json'

### Evaluate HiFi qc ### 
cd ..
python3 4-evaluate-hifi_qc.py

