#!/bin/bash
#
# NOTE: THIS WILL USE THE HPP-UCSC BILLING PROJECT BY DEFAULT. CHANGE THIS IF NECESSARY.
#
set -euo pipefail

SRC_PATH="s3://human-pangenomics/working/HPRC_PLUS/HG03492/raw_data/nanopore/guppy_6/"
DST_PATH="gs://fc-dcbd33a0-b9cf-475e-97c5-7fcfa3b51c71/human-pangenomics/working/HPRC_PLUS/HG03492/raw_data/nanopore/guppy_6/"
MANIFEST="./file_manifest.csv"
: > "$MANIFEST"  # clear or create the manifest file

echo $(date +"%Y-%m-%d %H:%M:%S") Starting AWS download
aws s3 sync --no-sign-request "$SRC_PATH" ./s3_download

echo $(date +"%Y-%m-%d %H:%M:%S") Starting checksums
find ./s3_download -type f | while read -r file; do
    size=$(stat -c %s "$file")
    checksum=$(md5sum "$file" | awk '{ print $1 }')
    echo "${file#./s3_download/},$size,$checksum" >> "$MANIFEST"
done

echo $(date +"%Y-%m-%d %H:%M:%S") Starting Google upload
gcloud storage cp -r -v --billing-project hpp-ucsc ./s3_download/* "$DST_PATH"

echo $(date +"%Y-%m-%d %H:%M:%S") Finished