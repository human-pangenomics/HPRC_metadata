### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/7acad60d-3d90-4dcf-9291-e2c679724df3--WUSTL_HPRC_HiFi_Year1_TopUp/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > WUSTL_HiFi_Year1_TopUp.csv 