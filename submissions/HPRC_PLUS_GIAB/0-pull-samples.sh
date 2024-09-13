### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/FFC78D9F-296E-41DD-9E50-C4B5806613EE--HPRC_PLUS_GIAB/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.fastq.gz$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > HPRC_PLUS_GIAB.csv 
