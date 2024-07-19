#!/bin/bash

# Check if exactly one file path argument is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <bam_files.tsv>"
  exit 1
fi

# File containing S3 paths
BAM_FILES_TSV="$1"

# Check if the file exists
if [ ! -f "${BAM_FILES_TSV}" ]; then
  echo "File not found: ${BAM_FILES_TSV}"
  exit 1
fi

# Path to samtools, adjust to the absolute path
SAMTOOLS="/private/home/iviolich/tools/samtools-1.18/samtools"

# Output summary file
SUMMARY_FILE="methylation_summary.tsv"

# Write header to summary file
echo -e "file_name\tMM_tag\tML_tag\tall_kinetics_flag\tkeep_kinetics_flag\thifi_kinetics_tag\tPP_PRIMROSE\tfi_tag\tri_tag\tfp_tag\trp_tag" > "$SUMMARY_FILE"

# Function to process each BAM file
process_bam_file() {
  local S3_PATH=$1
  local SAMTOOLS=$2

  # Extract the last part of the path after the last '/'
  FILE_NAME=$(basename "$S3_PATH")

  # Initialize tag variables
  MM="False"
  ML="False"
  ALL_KINETICS_RESULT="False"
  KEEP_KINETICS_RESULT="False"
  HIFI_KINETICS_RESULT="False"
  PP_PRIMROSE="False"
  FI="False"
  RI="False"
  FP="False"
  RP="False"


  # Check for "--all-kinetics" flag in the header
  if $SAMTOOLS view -H "$S3_PATH" 2>/dev/null | grep -q -- "--all-kinetics"; then
    ALL_KINETICS_RESULT="True"
  fi
  
  # Check for "--keep-kinetics" flag in the header
  if $SAMTOOLS view -H "$S3_PATH" 2>/dev/null | grep -q -- "--keep-kinetics"; then
    KEEP_KINETICS_RESULT="True"
  fi

    # Check for "--hifi-kinetics" flag in the header
  if $SAMTOOLS view -H "$S3_PATH" 2>/dev/null | grep -q -- "--hifi-kinetics"; then
    HIFI_KINETICS_RESULT="True"
  fi

 # Check for "PP:primrose" in the header
  if $SAMTOOLS view -H "$S3_PATH" 2>/dev/null | grep -q 'PP:primrose'; then
    PP_PRIMROSE="True"
  fi

  # Check for tags in the first 100 alignments
  ALIGNMENTS=$($SAMTOOLS view "$S3_PATH" 2>/dev/null | head -n 100)

  if echo "$ALIGNMENTS" | grep -o -m 1 '.\{0,10\}MM:Z:C\{0,10\}' > /dev/null; then
    MM="True"
  fi
  if echo "$ALIGNMENTS" | grep -o -m 1 '.\{0,10\}ML:B:C\{0,10\}' > /dev/null; then
    ML="True"
  fi
  if echo "$ALIGNMENTS" | grep -o -m 1 '.\{0,10\}fi:B:C\{0,10\}' > /dev/null; then
    FI="True"
  fi
  if echo "$ALIGNMENTS" | grep -o -m 1 '.\{0,10\}ri:B:C\{0,10\}' > /dev/null; then
    RI="True"
  fi
  if echo "$ALIGNMENTS" | grep -o -m 1 '.\{0,10\}fp:B:C\{0,10\}' > /dev/null; then
    FP="True"
  fi
  if echo "$ALIGNMENTS" | grep -o -m 1 '.\{0,10\}rp:B:C\{0,10\}' > /dev/null; then
    RP="True"
  fi

  # Append results to the summary file
  echo -e "$FILE_NAME\t$MM\t$ML\t$ALL_KINETICS_RESULT\t$KEEP_KINETICS_RESULT\t$HIFI_KINETICS_RESULT\t$PP_PRIMROSE\t$FI\t$RI\t$FP\t$RP" >> "$SUMMARY_FILE"
}

# Export the function so that parallel can use it
export -f process_bam_file

# Read the file and process each BAM file path
cat "${BAM_FILES_TSV}" | while IFS= read -r S3_PATH || [ -n "$S3_PATH" ]; do
  # Skip empty lines and lines starting with a comment symbol (#)
  if [[ -z "${S3_PATH}" || "${S3_PATH}" =~ ^# ]]; then
    continue
  fi
  process_bam_file "$S3_PATH" "$SAMTOOLS"
done

echo "Summary written to $SUMMARY_FILE"
