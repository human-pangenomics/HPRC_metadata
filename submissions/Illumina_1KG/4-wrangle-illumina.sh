### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/325b4b1c-9f20-49be-b03a-596da89c466e--1000G_CHILDREN/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > CHILDREN_1000G_DATA.csv # NOTE: rerunning this with 5mc and primrose will cause this to fail


BUCKET_PATH="s3://human-pangenomics/submissions/59C50DDF-5FAF-4841-AC3E-6C02D636C57F--Y4_1000G_DATA/"
# aws s3 ls s3://human-pangenomics/submissions/59C50DDF-5FAF-4841-AC3E-6C02D636C57F--Y4_1000G_DATA/ > Y4_1000G_DATA

FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')
echo "$FILES" > Y4_1000G_DATA.csv


### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/AD30A684-C7A8-4D24-89B2-040DFF021B0C--Y2_1000G_DATA/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > Y2_1000G_DATA.csv # NOTE: rerunning this with 5mc and primrose will cause this to fail


### Pull S3 Paths ###
BUCKET_PATH="s3://human-pangenomics/submissions/54D542ED-6650-4A12-8B40-0F92CC320486--1000G_parents/"

# Get the list of all .bam files from the specified S3 bucket, excluding .bam.pbi files
FILES=$(aws s3 ls $BUCKET_PATH --recursive --no-sign-request --human-readable --summarize | awk '{print "s3://human-pangenomics/" $5}')

# Extract only the first identifier from each file path
echo "$FILES" > PARENTS_1000G_DATA.csv # NOTE: rerunning this with 5mc and primrose will cause this to fail
