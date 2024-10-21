
mkdir primrose
cd primrose
mkdir -p slurm_logs
mkdir -p input_jsons

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../primrose_sample_data.csv \
     --field_mapping ../primrose_input_mappings.csv \
     --workflow_name primrose_workflow

cd ..

sbatch --job-name=primrose --array=[1-171]%10  --partition=high_priority  /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh  --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/tasks/primrose.wdl  --sample_csv primrose_sample_data.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/HPRC_Primrose_Y1-Y3-redo/primrose/input_jsons/${SAMPLE_ID}_primrose_workflow.json'


sbatch --job-name=primrose --array=[21]%1  --partition=high_priority  /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh  --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/tasks/primrose.wdl  --sample_csv primrose_sample_data.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/HPRC_Primrose_Y1-Y3-redo/primrose/input_jsons/HG01099-m64043_210704_052805.hifi_reads.bam_primrose_workflow.json'


