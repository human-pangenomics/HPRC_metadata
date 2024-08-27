for i in $(cat s3_submission_fastq.list | grep -v MGISTL)
do
    id=$(basename $i | cut -d. -f1)
    echo $(basename $i | sed 's/.dc.q20.fastq.gz//g'),\
    $(basename $i | sed 's/.dc.q20.fastq.gz//g'),\
    $i,\
    \[\"$(find /private/groups/hprc/1000G_local/child/fastq/ -name ${id}.final.fq.gz)\"\],\
    false
done

#create illumina arrays for MIGIST samples

for i in $(cut -d/ -f6 MGISTL_illumin_s3locs.csv | sort | uniq); do
    array=$(grep $i MGISTL_illumin_s3locs.csv | tr '\n' ',' | sed "s/,$//")
    formatted_array=$(echo $array | sed "s/[^,]\+/'&'/g")
    echo "$i \"[$formatted_array]\""
done

for i in $(cat s3_submission_fastq.list | grep MGISTL)
do
    id=$(basename $i | cut -d. -f1)
    echo $(basename $i | sed 's/.dc.q20.fastq.gz//g'),\
    $(basename $i | sed 's/.dc.q20.fastq.gz//g'),\
    $i,\
    $(grep $id MGISTL_illumin_s3locs_arrays_singleSet.csv | awk '{print $2}'),\
    false
done

#execute both above commands and append to the same file (UCSC_HPRC_PLUS_nanopore_sample_table.csv)
#add header manually ()

python /private/nanopore/hprc_qc/scripts/launch_from_table.py \
    --data_table ../HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run.csv \
    --field_mapping ../hifi_qc_input_mapping.csv \
    --workflow_name hifi_qc_workflow


sbatch \
    --job-name=qc_dc_2024_02_q20_re-run \
    --array=1-151%20 \
    --partition=long \
    /private/nanopore/hprc_qc/scripts/toil_sbatch_slurm.sh \
    --wdl ~/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl \
    --sample_csv /private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run.csv \
    --input_json_path '/private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/input_jsons/${SAMPLE_ID}_hifi_qc_workflow.json'

python ../scripts/update_table_with_outputs.py \
    --input_data_table /private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run.csv \
    --output_data_table HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_w_results.csv \
    --json_location /private/nanopore/hprc_qc/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/batch_processing/'{sample_id}/{sample_id}_hifi_qc_workflow.json'


#create release csv, keeping in mind this is a mix of HPRC and HPRC_PLUS samples

#list out sample ids in HPRC_PLUS and HPRC
aws s3 ls s3://human-pangenomics/working/HPRC_PLUS/ | sed 's/^.*PRE //g' | sed 's/\/$//g' | sort -u > HPRC_PLUS_id.list
aws s3 ls s3://human-pangenomics/working/HPRC/ | sed 's/^.*PRE //g' | sed 's/\/$//g' | sort -u > HPRC_id.list

#check number of rows in input
wc -l s3_submission_fastq.list

#remove files to be removed
grep -vFf files_not_released.txt s3_submission_fastq.list > s3_submission_fastq.list_after_remove

#all samples are HPRC, no HPRC_PLUS samples except for HG06807 aka PAN027 which is in both.


#replace s3 submission paths with working paths
sed 's/submissions\/B4B0B5DC-5FD5-42D5-8434-10DEF7D99E98--HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/working\/HPRC/g' s3_submission_fastq.list_after_remove > s3_submission_fastq_hprc_working_destination.list

#check if working paths don't exist
for i in $(cat s3_submission_fastq_hprc_working_destination.list); do echo $i; aws s3 ls $i; done

#paste submission and working paths together
paste s3_submission_fastq.list_after_remove s3_submission_fastq_hprc_working_destination.list -d, > HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_release.csv

#confirm number of rows matches input
wc -l HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_release.csv

