


for i in $(cat s3_submission_fastq.list)
do
    id=$(basename $i | cut -d. -f1)
    echo $(basename $i | sed 's/.dc.q20.fastq.gz//g'),\
    $(basename $i | sed 's/.dc.q20.fastq.gz//g'),\
    $i,\
    \[\"$(find /private/groups/hprc/1000G_local/child/fastq/ -name ${id}.final.fq.gz)\"\],\
    false
done

#create illumina arrays for samples without local 1000G data

for i in $(cut -d/ -f6 missingIlluSampleID.s3Locs.list | sort | uniq); do
    array=$(grep $i missingIlluSampleID.s3Locs.list | tr '\n' ',' | sed "s/,$//")
    formatted_array=$(echo $array | sed "s/[^,]\+/'&'/g")
    echo "$i \"[$formatted_array]\""
done

for i in $(cat HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_sample_missingIllumina.csv | awk '{print $3}')
do
    id=$(basename $i | cut -d. -f1)
    echo $(basename $i | sed 's/.dc.q20.fastq.gz//g')\
    $(basename $i | sed 's/.dc.q20.fastq.gz//g')\
    $i,\
    $(grep $id missingIlluSampleID.s3Locs.list.format | awk '{print $2}'),\
    false
done

#execute both above commands and append to the same file (UCSC_HPRC_PLUS_nanopore_sample_table.csv)
#add header manually ()

python /private/nanopore/hprc_qc/scripts/launch_from_table.py \
    --data_table ../HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run.csv \
    --field_mapping ../hifi_qc_input_mapping.csv \
    --workflow_name hifi_qc_workflow


sbatch \
    --job-name=hifi_qc_dc_MGISTL \
    --array=1-197%20 \
    --partition=long \
    /private/nanopore/hprc_qc/scripts/toil_sbatch_slurm.sh \
    --wdl ~/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl \
    --sample_csv /private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_sample.csv \
    --input_json_path '/private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/input_jsons/${SAMPLE_ID}_hifi_qc_workflow.json'

python ../scripts/update_table_with_outputs.py \
    --input_data_table /private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_sample.csv \
    --output_data_table HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_sample_w_results.csv \
    --json_location /private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/batch_processing/'{sample_id}/{sample_id}_hifi_qc_workflow.json'

find . -name *summary.tsv | head -n 1 | xargs -I {} head -n 1 {} >> HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_summary_agg.tsv

for i in $(find . -name *summary.tsv)
    do tail -n 1 $i >> HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_summary_agg.tsv
done