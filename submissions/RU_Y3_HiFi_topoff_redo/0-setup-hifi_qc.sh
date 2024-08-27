### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/B8BD83FD-2608-4494-AFD4-E63DC2376381--RU_Y3_topoff_redo/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y3_topoff_redo.csv 