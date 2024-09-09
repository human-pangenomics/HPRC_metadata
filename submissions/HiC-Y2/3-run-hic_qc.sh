mkdir -p hic_qc
mkdir -p input_jsons/
python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hic_sample_files.csv \
     --field_mapping ../hic_qc_input_mapping.csv \
     --workflow_name hic_qc_workflow_HiC_Y2

cd ..
sbatch --job-name=HiC_Y2 --array=[1-704]%102 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/HiC-Y2/hic_qc/input_jsons/${SAMPLE_ID}_hic_qc_workflow_HiC_Y2.json'

# HG02071-10a-1_S9_L002_R2_001.fastq.gz
sbatch --job-name=HiC_Y2 --array=[244]%1 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/HiC-Y2/hic_qc/input_jsons/${SAMPLE_ID}_hic_qc_workflow_HiC_Y2.json'

# NOTE: These samples were run after pulling CRAMs from Terra and converting to BAM

# RUN sample HG01443
sbatch --job-name=HiC_Y2 --array=[145-160]%15 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/HiC-Y2/hic_qc/input_jsons/${SAMPLE_ID}_hic_qc_workflow_HiC_Y2.json'

# RUN sample HG02688
sbatch --job-name=HiC_Y2 --array=[433-448]%15 --partition=high_priority /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hic_qc_workflow.wdl --sample_csv hic_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/HiC-Y2/hic_qc/input_jsons/${SAMPLE_ID}_hic_qc_workflow_HiC_Y2.json'