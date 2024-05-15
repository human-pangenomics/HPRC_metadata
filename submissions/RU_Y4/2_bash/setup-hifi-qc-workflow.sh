BUCKET_PATH="s3://human-pangenomics/submissions/5A0D539A-4AD5-4FBF-A0FB-2DDCE5B0FA33--RU_Y4/"

# Get the list of all .bam files from the specified S3 bucket
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.hifi_reads\..*\.bam$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y4.csv
