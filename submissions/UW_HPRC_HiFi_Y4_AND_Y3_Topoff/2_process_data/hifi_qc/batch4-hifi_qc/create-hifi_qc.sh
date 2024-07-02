python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hifi_sample_files.csv \
     --field_mapping ../hifi_qc_input_mapping.csv \
     --workflow_name hifi_qc_workflow_UW_HPRC_HiFi_Y4_AND_Y3_Topoff

sbatch --job-name=UW-hifi-qc --array=[1-4]%4 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/UW_HPRC_HiFi_Y4_AND_Y3_Topoff/3_data_processing/batch4-hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow_UW_HPRC_HiFi_Y4_AND_Y3_Topoff.json'

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/dev-update_table_with_outputs.py      --input_data_table hifi_sample_files.csv      --output_data_table hifi_samples_output_table.csv      --json_location '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/UW_HPRC_HiFi_Y4_AND_Y3_Topoff/3_data_processing/batch4-hifi_qc/{sample_id}/{sample_id}_hifi_qc_workflow_outputs.json'
