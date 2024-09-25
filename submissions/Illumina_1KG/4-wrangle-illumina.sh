### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/325b4b1c-9f20-49be-b03a-596da89c466e--1000G_CHILDREN/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > Illumina_Y1-Y4.csv # NOTE: rerunning this with 5mc and primrose will cause this to fail


BUCKET_PATH="s3://human-pangenomics/submissions/59C50DDF-5FAF-4841-AC3E-6C02D636C57F--Y4_1000G_DATA/"
# aws s3 ls s3://human-pangenomics/submissions/59C50DDF-5FAF-4841-AC3E-6C02D636C57F--Y4_1000G_DATA/ > Y4_1000G_DATA

FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')
echo "$FILES" > Y4_1000G_DATA.csv
