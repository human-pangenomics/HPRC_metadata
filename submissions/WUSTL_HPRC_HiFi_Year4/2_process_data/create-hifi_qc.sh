export SINGULARITY_CACHEDIR=`pwd`/analysis/cache/.singularity/cache 
export MINIWDL__SINGULARITY__IMAGE_CACHE=`pwd`/analysis/cache/.cache/miniwdl 
export TOIL_SLURM_ARGS="--time=12:00:00 --partition=high_priority"
export TOIL_COORDINATION_DIR=/data/tmp

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hifi_sample_files.csv \
     --field_mapping ../hifi_qc_input_mapping.csv \
     --workflow_name hifi_qc_workflow_WUSTL_Y4


sbatch --job-name=hifi-qc --array=[1-97]%12 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year4/3_data_processing/hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow_WUSTL_Y4.json'

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/dev-update_table_with_outputs.py      --input_data_table hic_sample_files.csv      --output_data_table hic_samples_output_table.csv      --json_location '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year4/3_data_processing/hifi_qc/{sample_id}/{sample_id}_hifi_qc_workflow_outputs.json'
