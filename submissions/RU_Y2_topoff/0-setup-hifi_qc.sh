### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/4D90DDB8-2EAC-4DCA-9CCF-2A85C7CC96AD--RU_Y2_topoff/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y2_topoff.csv 