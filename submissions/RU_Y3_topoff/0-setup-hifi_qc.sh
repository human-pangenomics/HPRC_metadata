### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/573E04D5-CDDE-43B8-94D9-D00DD7B471AB--RU_Y3_topoff/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y3_topoff.csv 