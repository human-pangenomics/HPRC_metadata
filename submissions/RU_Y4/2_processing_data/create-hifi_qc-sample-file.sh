#!/bin/bash

###

cat m84091_230721_141900_s2.hifi_reads.bc1008_hifi_qc_workflow.json
{
  "hifi_qc_wf.hifi_reads": 
    "s3://human-pangenomics/submissions/5A0D539A-4AD5-4FBF-A0FB-2DDCE5B0FA33--RU_Y4/HG00235/hifi_reads/m84091_230721_141900_s2.hifi_reads.bc1008.bam"
  ,
  "hifi_qc_wf.sample_id": "m84091_230721_141900_s2.hifi_reads.bc1008",
  "hifi_qc_wf.other_reads": [
    "/private/groups/hprc/human-pangenomics/1000G_local/child/cram_to_bam/HG00235/analysis/ConvertCRAMtoBAM_outputs/a2bd3f1f-62b3-4634-b826-0539eec40878/HG00235.final.bam"
  ],
  "hifi_qc_wf.perform_methylation_check": true
}

toil-wdl-runner \
    --jobStore ./bigstore \
    --batchSystem slurm \
    --batchLogsDir ./logs \
    /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl \
    m84091_230721_141900_s2.hifi_reads.bc1008_hifi_qc_workflow.json \
    --outputDirectory analysis \
    --outputFile m84091_230721_141900_s2.hifi_reads.bc1008_hifi_qc_workflow.json \
    --runLocalJobsOnWorkers \
    --disableProgress \
    --caching=false \
    2>&1 | tee log.txt  


###
sbatch \
     --job-name=hifi-qc-sample-file-summary-test \
     --array=[1] \
     --partition=long \
     /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh \
     --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl \
     --sample_csv hifi_sample_data-test-HG00235-m84091_230721_141900_s2.hifi_reads.bc1008.csv \
     --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y4/4_data_processing/hifi_qc-sample-file-summary/input_jsons/m84091_230721_141900_s2.hifi_reads.bc1008_hifi_qc_workflow.json'

###
pwd 
```
/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y4/4_data_processing
```

mkdir hifi_qc-sample-file
cd hifi_qc-sample-file

# pull workflow make as a Git module
git -C /private/groups/hprc/human-pangenomics/hpp_production_workflows/ pull


java -jar /private/groups/hprc/human-pangenomics/cromwell/womtool-54.jar \
inputs \
/private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl \
| grep -v "optional"
```
{
  "hifi_qc_wf.hifi_reads": "File",
  "hifi_qc_wf.sample_id": "String",
  "hifi_qc_wf.other_reads": "Array[File]"
}
```

## create input json(s)
mkdir input_jsons
cd input_jsons

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hifi_sample_data-test-HG00235-m84091_230721_141900_s2.hifi_reads.bc1008.csv \
     --field_mapping ../hifi_qc_input_mapping.csv \
     --workflow_name hifi_qc_workflow

python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/launch_from_table.py \
     --data_table ../hifi_sample_data-test-HG00235.csv \
     --field_mapping ../hifi_qc_input_mapping.csv \
     --workflow_name hifi_qc_workflow

cd ..


sbatch --job-name=hifi-qc --array=[1-2]%2 /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_sample_data-test-HG00235.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y4/4_data_processing/hifi_qc-sample-file-summary-aggregate/input_jsons/${SAMPLE_ID}_hifi_qc_workflow.json'



sbatch \
     --job-name=hifi-qc-test \
     --array=[1] \
     --partition=long \
     /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh \
     --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl \
     --sample_csv hifi_sample_data-test-HG00235-m84091_230721_141900_s2.hifi_reads.bc1008.csv \
     --input_json_path /private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y4/4_data_processing/hifi_qc-sample-file-summary/input_jsons/m84091_230721_141900_s2.hifi_reads.bc1008_hifi_qc_workflow.json


python3 /private/groups/hprc/human-pangenomics/hprc_intermediate_assembly/hpc/update_table_with_outputs.py \
     --input_data_table hifi_sample_data-test-HG00235-m84091_230721_141900_s2.hifi_reads.bc1008.csv \
     --output_data_table hifi_sample_data-test-HG00235-m84091_230721_141900_s2.hifi_reads.bc1008_updated.csv \
     --json_location input_jsons/m84091_230721_141900_s2.hifi_reads.bc1008_hifi_qc_workflow.json \
     --field_mapping hifi_qc_input_mapping.csv


sbatch --job-name=hifi-qc --array=[1-96]%12 /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_sample_files.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y4/4_data_processing/hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow_RU_Y4.json'

sbatch --job-name=hifi-qc --array=[1-3]%3 /private/groups/hprc/hprc_intermediate_assembly/hpc/toil_sbatch_slurm.sh --wdl /private/groups/hprc/human-pangenomics/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl --sample_csv hifi_sample_files-HG03672.csv --input_json_path '/private/groups/hprc/human-pangenomics/HPRC_metadata/submissions/RU_Y4/3_data_processing/hifi_qc/input_jsons/${SAMPLE_ID}_hifi_qc_workflow_RU_Y4.json'