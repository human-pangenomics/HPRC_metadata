### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/E3CE7E0D-EAC0-4918-B200-91D73E9170D6--HPRC_Primrose_Y1-Y3-redo/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > HPRC_Primrose_Y1-Y3-redo.csv 


