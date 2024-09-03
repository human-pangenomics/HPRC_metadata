### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/67b71022-da25-40ef-b56f-52297e946b32--WUSTL_HPRC_HiFi_Year2_TopUp/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > WUSTL_HiFi_Year2_TopUp.csv 