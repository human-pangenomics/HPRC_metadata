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