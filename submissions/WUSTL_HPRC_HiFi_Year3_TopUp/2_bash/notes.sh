# List and grep for bam files in the s3 bucket, then prepend the s3 path to the file name
aws s3 ls s3://human-pangenomics/submissions/331018f0-4fa6-46d3-bf49-dc08405598c3--WUSTL_HPRC_HiFi_Year3_TopUp/ --recursive | grep bam$ | awk '{print "s3://human-pangenomics/" $4}' > WUSTL_HPRC_HiFi_Year3_TopUp_s3locs.csv

# Create a header for the samples.csv file
echo "sample_id,hifi_reads,other_reads,perform_methylation_check" > WUSTL_HPRC_HiFi_Year3_TopUp_samples.csv


# Process each pass.bam file in the passbams CSV file
for i in $(cat WUSTL_HPRC_HiFi_Year3_TopUp_s3locs.csv); do
  id=$(echo $i | cut -d/ -f6); # Extract the ID from the S3 path
  echo $id.$(basename $i),$i,\[\"$(find /private/groups/hprc/1000G_local/child/fastq/ -name *${id}*)\"\],true \
  >> WUSTL_HPRC_HiFi_Year3_TopUp_samples.csv;
done

# manually add the missing illumina data for PAN027/HG06807

#remove fail reads
grep -v fail WUSTL_HPRC_HiFi_Year3_TopUp_samples.csv > WUSTL_HPRC_HiFi_Year3_TopUp_samples_passOnly.csv

# Create directories for input files and logs
mkdir -p batch_processing/input_jsons
mkdir -p batch_processing/slurm_logs

# create input jsons
cd batch_processing/input_jsons
python /private/nanopore/hprc_qc/scripts/launch_from_table.py \
    --data_table  /private/nanopore/hprc_qc/WUSTL_HPRC_HiFi_Year3_TopUp/WUSTL_HPRC_HiFi_Year3_TopUp_samples_passOnly.csv \
    --field_mapping /private/nanopore/hprc_qc/scripts/hifi_qc_input_mapping.csv \
    --workflow_name hifi_qc_workflow

#submit jobs
sbatch \
    --job-name=hifi_qc_pacbio_hprc_plus \
    --array=[26,31,32,34,44,46,47,49,50,51]%10 \
    --partition=long \
    /private/nanopore/hprc_qc/scripts/toil_sbatch_slurm.sh \
    --wdl ~/hpp_production_workflows/data_processing/wdl/workflows/hifi_qc_workflow.wdl \
    --sample_csv /private/nanopore/hprc_qc/WUSTL_HPRC_HiFi_Year3_TopUp/WUSTL_HPRC_HiFi_Year3_TopUp_samples_passOnly.csv \
    --input_json_path '/private/nanopore/hprc_qc/WUSTL_HPRC_HiFi_Year3_TopUp/batch_processing/input_jsons/${SAMPLE_ID}_hifi_qc_workflow.json'

echo "filename        total_reads     total_bp        total_Gbp       min     max     mean    quartile_25     quartile_50\
     quartile_75     N25     N50     N75     ntsm_score      ntsm_result     bam_file        MM_tag  ML_tag\
       all_kinetics_flag       keep_kinetics_flag      hifi_kinetics_tag       PP_PRIMROSE     fi_tag  ri_tag  fp_tag  rp_tag" > WUSTL_HPRC_HiFi_Year3_TopUp_summary_agg.tsv

for i in $(find . -name *.summary.tsv)
    do tail -n 1 $i >> WUSTL_HPRC_HiFi_Year3_TopUp_summary_agg.tsv
done


#create release csv
#replace s3 submission paths with working paths
sed 's|submissions/331018f0-4fa6-46d3-bf49-dc08405598c3--WUSTL_HPRC_HiFi_Year3_TopUp|working/HPRC|g' WUSTL_HPRC_HiFi_Year3_TopUp_s3locs.csv | sed 's|/PacBio_HiFi/|/raw_data/PacBio_HiFi/revio/|g' > WUSTL_HPRC_HiFi_Year3_TopUp_working_destination.csv
paste WUSTL_HPRC_HiFi_Year3_TopUp_s3locs.csv WUSTL_HPRC_HiFi_Year3_TopUp_working_destination.csv -d, > WUSTL_HPRC_HiFi_Year3_TopUp_release.csv


