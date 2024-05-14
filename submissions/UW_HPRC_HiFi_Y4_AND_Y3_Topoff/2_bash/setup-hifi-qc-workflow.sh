BUCKET_PATH="s3://human-pangenomics/submissions/4f8c8e63-dfd3-4f90-965f-8a8cf3ee4de9--UW_HPRC_HiFi_Y4_AND_Y3_Topoff/"

# Get the list of all .bam files from the specified S3 bucket
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.hifi_reads\..*\.bam$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > UW_HPRC_HiFi_Y4_AND_Y3_Topoff.csv
