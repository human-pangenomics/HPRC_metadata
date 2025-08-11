#!/bin/bash
#
# S3 to Google Cloud Storage Transfer Array Job
# ==============================================
# 
# This SLURM array job downloads files from AWS S3 and uploads them to Google Cloud Storage.
# Each array task processes one S3 file path from an input text file. This is what we actually
# used for our transfers.
#
# IF YOU ARE UPLOADING TO ANVIL, MAKE SURE YOUR GCLOUD CONFIG IS ALREADY SET UP WITH PARALLEL
# COMPOSITE UPLOADS TURNED OFF. This is a NON-DEFAULT setting. You could also set this own script's
# MANUALLY_DISABLE_PARALLEL_COMPOSITE to "true" in this script, but if this script gets parallelized,
# you might end up corrupting your config file (it happened to me! it can happen to you!)
#
# Usage: 
#   1. First, count your S3 paths to set the array size:
#      ARRAY_SIZE=$(sed '/^[[:space:]]*$/d; /^[[:space:]]*#/d' your_file.txt | wc -l)
#   2. Then submit the job (USE THE FULL PATH FOR your_file.txt)
#      sbatch --array=1-${ARRAY_SIZE}%30 s3_to_gcs_transfer.slurm /the/full/path/your_file.txt
#
# Example:
#   ARRAY_SIZE=$(sed '/^[[:space:]]*$/d; /^[[:space:]]*#/d' no_composite.tsv | wc -l)
#   sbatch --array=1-${ARRAY_SIZE}%10 s3_to_gcs_transfer.slurm /private/groups/migalab/ash/no_composite.tsv
#
# Input file format is a TSV with format ``filename[\t]path[\t]sliced_path[\t]bytes``
# One S3 path (file) per line, comments and empty lines are okay and will be ignored, but NO HEADER!!
#
# Outputs:
#   - Log files: s3_transfer_<JOB_ID>_<TASK_ID>.log (in submission directory)
#   - Manifest files: manifest_<JOB_ID>_<TASK_ID>.csv (in submission directory)
#
# SLURM Configuration
#SBATCH --job-name=s3_to_gcs_transfer       # Job name
#SBATCH --output=s3_transfer_%A_%a.log      # Combined stdout/stderr log (%A=job_id, %a=task_id)
#SBATCH --time=12:00:00                     # Max runtime: 12 hours
#SBATCH --cpus-per-task=2                   # CPUs per task
#SBATCH --mem=8G                            # Memory per task
#SBATCH --partition=long                    # Use long partition for extended runtime
#SBATCH --oversubscribe                     # We can share nodes! Surely nothing will go wrong!
#SBATCH --mail-type=all                     # Email me when anything interesting happens
#SBATCH --mail-user=aofarrel@ucsc.edu
#SBATCH --exclude=phoenix-09,phoenix-11     # Exclude the whacky nodes
# Note: Array parameters are specified at submission time with --array=1-N%10

# Strict error handling - exit on any error, undefined variable, or pipe failure
set -euo pipefail

MANUALLY_DISABLE_PARALLEL_COMPOSITE="false" # READ BELOW! THIS IS IMPORTANT!!

if [[ "$MANUALLY_DISABLE_PARALLEL_COMPOSITE" == "true" ]]; then
        echo "You have elected to manually disable parallel composite uploads."
        echo "Files will upload slower, but will have md5sums in GCS metadata (which is required for AnVIL data store)."
        echo "Unless this script is Dockerized, you should only this sort of manual disabling once;"
        echo "if you keep messing with the same config file again and again in parallel you might cause errors."
        gcloud config set storage/parallel_composite_upload_enabled False
    fi

if [ $# -ne 1 ]; then
    echo "ERROR: Incorrect number of arguments"
    echo "For usage instructions please see comments at top of this file."
    exit 1
fi

# Configuration variables
INPUT_FILE="$1"                                                                  # Input file
DST_BASE_PATH="gs://fc-dcbd33a0-b9cf-475e-97c5-7fcfa3b51c71/"                    # GCS destination base path
SCRATCH_DIR="/data/scratch/$USER"                                                # High-performance scratch space
WORK_DIR="${SCRATCH_DIR}/transfer_work_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"  # Temporary working directory

# Create working directory in scratch space for temporary files
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

echo "$(date +"%Y-%m-%d %H:%M:%S") Starting array task ${SLURM_ARRAY_TASK_ID} of job ${SLURM_ARRAY_JOB_ID}"
echo "$(date +"%Y-%m-%d %H:%M:%S") Working directory: $WORK_DIR"

# Extract the info for this specific array task's file
# - Skip empty lines and comments (lines starting with #)
# - Get the Nth line where N = SLURM_ARRAY_TASK_ID
THIS_TASK_INFO=$(sed -n '/^[[:space:]]*$/d; /^[[:space:]]*#/d; p' "$INPUT_FILE" | sed -n "${SLURM_ARRAY_TASK_ID}p")

# Get S3 path
FULL_S3_PATH=$(echo -e "$THIS_TASK_INFO" | cut -f2)
if [ -z "$FULL_S3_PATH" ]; then
    echo "$(date +"%Y-%m-%d %H:%M:%S") No S3 path found for task ${SLURM_ARRAY_TASK_ID}, exiting disgracefully"
    exit 1
fi

# Check available disk space
AWSFILEBYTES=$(echo -e "$THIS_TASK_INFO" | cut -f4)
AWSFILEGIGAS=$(echo "$AWSFILEBYTES" | awk '{printf "%.2f\n", $1 / (1024*1024*1024)}')
NEEDED_BYTES=$(awk -v b="$AWSFILEBYTES" 'BEGIN { printf "%.0f", b * 1.5 }')
NEEDED_GIGAS=$(echo "$NEEDED_BYTES" | awk '{printf "%.2f\n", $1 / (1024*1024*1024)}')
AVAILA_BYTES=$(df --output=avail -B1 "." | tail -1)
AVAILA_GIGAS=$(echo "$AVAILA_BYTES" | awk '{printf "%.2f\n", $1 / (1024*1024*1024)}')
echo "$(date +"%Y-%m-%d %H:%M:%S") Checking disk size on $(hostname)"
printf "\t* AWSFILEBYTES\t%015d\t(%04.2f GB)\n" $AWSFILEBYTES $AWSFILEGIGAS
printf "\t* NEEDED_BYTES\t%015d\t(%04.2f GB)\n" $NEEDED_BYTES $NEEDED_GIGAS
printf "\t* AVAILA_BYTES\t%015d\t(%04.2f GB)\n" $AVAILA_BYTES $AVAILA_GIGAS
if (( AVAILA_BYTES < NEEDED_BYTES )); then
    echo "Error: Not enough storage space in $WORK_DIR" >&2
    echo "Needed (with 1.5x buffer): $NEEDED_BYTES bytes ($NEEDED_GIGAS)" >&2
    echo "Available: $AVAILA_BYTES bytes ($AVAILA_GIGAS)" >&2
    exit 1
fi

echo "$(date +"%Y-%m-%d %H:%M:%S") Processing S3 path: $FULL_S3_PATH"

# Extract just the filename from the full S3 path
filename=$(basename "$FULL_S3_PATH")
local_file="./downloads/$filename"

echo "$(date +"%Y-%m-%d %H:%M:%S") Local filename: $filename"

# Construct the destination path in Google Cloud Storage
RELATIVE_PATH="${FULL_S3_PATH#s3://}"                     # Remove s3:// prefix
TASK_MANIFEST="./manifest_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.csv" # Manifest file (saved to CWD)
DST_PATH="${DST_BASE_PATH}${RELATIVE_PATH}"          # Prepend GCS base path

echo "$(date +"%Y-%m-%d %H:%M:%S") Task mainfest: $TASK_MANIFEST"
echo "$(date +"%Y-%m-%d %H:%M:%S") Destination path: $DST_PATH"

# Create downloads subdirectory
mkdir -p ./downloads

# Download the file from S3 using AWS CLI
# --no-sign-request: Access public S3 buckets without AWS credentials
echo "$(date +"%Y-%m-%d %H:%M:%S") Downloading $filename from S3..."
aws s3 cp --no-sign-request "$FULL_S3_PATH" "$local_file"

# Calculate file metadata for integrity verification
echo "$(date +"%Y-%m-%d %H:%M:%S") Calculating checksum and file size for $filename..."
size=$(stat -c %s "$local_file")                    # Get file size in bytes
checksum=$(md5sum "$local_file" | awk '{ print $1 }')  # Calculate MD5 checksum

echo "$(date +"%Y-%m-%d %H:%M:%S") File size: $size bytes"
echo "$(date +"%Y-%m-%d %H:%M:%S") MD5 checksum: $checksum"

# Create manifest file for this task with file metadata
# Also echo to stdout because why not sure
echo "$(date +"%Y-%m-%d %H:%M:%S") Manifest:"
echo "file,aws_file_size,download_size,checksum,s3_source,gs_path,slurm_job_id,slurm_task_id" > "$TASK_MANIFEST"
echo "$filename,$AWSFILEBYTES,$size,$checksum,$FULL_S3_PATH,$DST_PATH,$SLURM_ARRAY_JOB_ID,$SLURM_ARRAY_TASK_ID" >> "$TASK_MANIFEST"
echo "file,aws_file_size,download_size,checksum,s3_source,gs_path,slurm_job_id,slurm_task_id"
echo "$filename,$AWSFILEBYTES,$size,$checksum,$FULL_S3_PATH,$DST_PATH,$SLURM_ARRAY_JOB_ID,$SLURM_ARRAY_TASK_ID" 

# Upload the file to Google Cloud Storage
echo "$(date +"%Y-%m-%d %H:%M:%S") Uploading $filename to Google Cloud Storage..."
gcloud storage cp -v --billing-project hpp-ucsc "$local_file" "$DST_PATH"

echo "$(date +"%Y-%m-%d %H:%M:%S") Attempting to copy manifest to migalab..."
cp "$TASK_MANIFEST" /private/groups/migalab/ash/DO_NOT_DELETE/transfer_manifests/

# Clean up: remove temporary working directory to free up scratch space
echo "$(date +"%Y-%m-%d %H:%M:%S") Cleaning up temporary files..."
cd "$SCRATCH_DIR"
rm -rf "$WORK_DIR"

# Task completion summary
echo "$(date +"%Y-%m-%d %H:%M:%S") ✓ Task ${SLURM_ARRAY_TASK_ID} completed successfully"
echo "$(date +"%Y-%m-%d %H:%M:%S") ✓ Processed file: $filename"
echo "$(date +"%Y-%m-%d %H:%M:%S") ✓ Manifest saved to: ${TASK_MANIFEST}"
echo "$(date +"%Y-%m-%d %H:%M:%S") ✓ Transferred: $FULL_S3_PATH -> $DST_PATH"