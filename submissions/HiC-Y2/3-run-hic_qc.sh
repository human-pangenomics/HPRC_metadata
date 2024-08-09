mkdir -p hic_qc
mkdir -p input_jsons/
python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hic_sample_files.csv \
     --field_mapping ../hic_qc_input_mapping.csv \
     --workflow_name hic_qc_workflow_HiC_Y2

cd ..
sbatch --job-name=HiC_Y2 --array=[1-704]%102 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/HiC-Y2/hic_qc/input_jsons/${SAMPLE_ID}_hic_qc_workflow_HiC_Y2.json'
