# Pull submission s3
BUCKET_PATH="s3://human-pangenomics/submissions/62B7A84C-C647-4FD9-92F0-90956198404D--Y3-HIC/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > Y3-HIC.csv