BUCKET_PATH="s3://human-pangenomics/submissions/A3D02676-D52B-4717-9312-73F78255BBB3--RU_Y3_HIFI/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > RU_Y3_HIFI.csv
