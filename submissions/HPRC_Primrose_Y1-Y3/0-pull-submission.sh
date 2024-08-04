### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/E13CA144-27E7-41E9-BCFD-A825B740EB45--HPRC_Primrose_Y1-Y3/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | grep '\.bam$' | grep -v '\.bam\.pbi$' | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > HPRC_Primrose_Y1-Y3.csv 

### Check methylation summary
# bash check-5mc-modifications.sh HPRC_Primrose_Y1-Y3.csv # exports the methylation_summary.tsv
