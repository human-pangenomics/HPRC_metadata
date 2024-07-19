
### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/A3D02676-D52B-4717-9312-73F78255BBB3--RU_Y3_HIFI/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y3_HIFI.csv # NOTE: rerunning this with 5mc and primrose will cause this to fail

### Run modification ### 
bash check-5mc-modifications.sh RU_Y3_HIFI.csv # exports the methylation_summary.tsv

### Wrangle Sample Files ###

python3 1-wrangle-primrose.py

### Run Primrose###

mkdir primrose
cd primrose
mkdir -p slurm_logs
mkdir -p input_jsons
cd input_jsons

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../primrose_sample_data.csv \
     --field_mapping ../primrose_input_mappings.csv \
     --workflow_name primrose_workflow

cd ..

sbatch --job-name=primrose --array=[1-94]%20  --partition=high_priority  /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/tasks/primrose.wdl  --sample_csv primrose_sample_data.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y3_HiFi/primrose/input_jsons/${SAMPLE_ID}_primrose_workflow.json'

python3 /private/groups/hprc/hprc_intermediate_assembly/hpc/update_table_with_outputs.py --input_data_table /private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y3_HiFi/primrose/primrose_sample_data.csv  \
      --output_data_table /private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y3_HiFi/primrose/primrose_sample_data_output.csv  \
      --json_location '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y3_HiFi/primrose/{sample_id}_primrose_outputs.json'

### Upload to AWS ###
ssds staging upload \
--deployment default \
--submission-id A3D02676-D52B-4717-9312-73F78255BBB3  \
primrose