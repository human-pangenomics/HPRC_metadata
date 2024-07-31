### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y2_HIFI.csv # NOTE: rerunning this with 5mc and primrose will cause this to fail

### Check methylation summary
bash check-5mc-modifications.sh RU_Y2_HIFI.csv # exports the methylation_summary.tsv

### Wrangle Primrose ###
# run 1-wrangle-primrose.ipynb

###
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

sbatch --job-name=primrose --array=[1-45]%9  --partition=high_priority  /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh  --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/tasks/primrose.wdl  --sample_csv primrose_sample_data.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y2_HiFi/primrose/input_jsons/${SAMPLE_ID}_primrose_workflow.json'

# Run 2-evaluate-primrose.ipynb

# Run in terminal
ssds staging upload \
--deployment default \
--submission-id 746FF75B-3C32-42AF-92BB-290BA92CF89A  \
upload-primrose

rm upload-primrose
# rm primrose

# Start new 
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

sbatch --job-name=hifi-qc --array=[1-36]%9 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_qc_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y2_HiFi/hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow.json'

### Post HiFi QC ###

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/update_table_with_outputs.py      --input_data_table hifi_qc_sample_files.csv      --output_data_table hifi_qc_samples_output_table.csv      --json_location '{sample_id}_hifi_qc_workflow_outputs.json'

