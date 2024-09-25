
python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../illumina_sample_files.csv  \
     --field_mapping ../illumina_qc_input_mapping.csv \
     --workflow_name illumina_workflow

sbatch --job-name=illumina_qc --array=[171]%10 --partition=long /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/illumina_qc_workflow.wdl --sample_csv illumina_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/Illumina_Y1-Y4/illumina_qc/input_jsons/${SAMPLE_ID}_illumina_workflow.json'