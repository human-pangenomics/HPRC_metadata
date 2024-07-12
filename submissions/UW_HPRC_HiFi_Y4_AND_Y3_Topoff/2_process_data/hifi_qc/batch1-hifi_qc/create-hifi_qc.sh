python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hifi_sample_files.csv \
     --field_mapping ../hifi_qc_input_mapping.csv \
     --workflow_name hifi_qc_workflow_UW_HPRC_HiFi_Y4_AND_Y3_Topoff




sbatch --job-name=UW-hifi-qc-batch2 --array=[1-84]%12 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/UW_HPRC_HiFi_Y4_AND_Y3_Topoff/3_data_processing/batch2-hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow_UW_HPRC_HiFi_Y4_AND_Y3_Topoff.json'

sbatch --job-name=UW-hifi-qc --array=[1-119]%12 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/UW_HPRC_HiFi_Y4_AND_Y3_Topoff/3_data_processing/batch1-hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow_UW_HPRC_HiFi_Y4_AND_Y3_Topoff.json'