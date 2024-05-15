BUCKET_PATH="s3://human-pangenomics/submissions/72fad738-62d9-42a9-ba8c-53e355eb442b--WUSTL_HPRC_HiFi_Y4/"

# Get the list of all .bam files from the specified S3 bucket
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.hifi_reads\..*\.bam$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > WUSTL_HPRC_HiFi_Y4.csv
