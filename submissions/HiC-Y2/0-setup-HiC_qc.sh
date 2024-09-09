# Pull submission s3
BUCKET_PATH="s3://human-pangenomics/submissions/4C696EB9-9AD2-47A2-8011-2F43977CC4E0--Y2-HIC/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > Y2-HIC.csv