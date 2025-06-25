version 1.0

workflow transfer_hprc {
	input {
		Array[File] batch_tsvs
		File mysterious_json
	}

	scatter(batch_tsv in batch_tsvs) {
		call do_everything {
			input:
				input_tsv = batch_tsv,
				mysterious_json = mysterious_json
		}
	}

	output {
		Array[File] manifests = do_everything.manifest
	}
}

task do_everything {
	input {
		File input_tsv
		File mysterious_json
	}
	String input_tsv_basename = basename(input_tsv)

	command <<<
	set -euo pipefail

	echo "$(date +"%Y-%m-%d %H:%M:%S") Touching a bucket to make sure Google doesn't hate me"
	gcloud auth activate-service-account ashs-moving-service@hpp-ucsc.iam.gserviceaccount.com --key-file ~{mysterious_json}
	gcloud storage ls --billing-project hpp-ucsc gs://fc-dcbd33a0-b9cf-475e-97c5-7fcfa3b51c71
	exit 9999

	INPUT_TSV="~{input_tsv}"
	MANIFEST="~{input_tsv_basename}_file_manifest.csv"
	if [[ -z "$INPUT_TSV" || ! -f "$INPUT_TSV" ]]; then
	    echo "Usage: $0 <input.tsv>" >&2
	    exit 1
	fi

	du -sh .
	pwd

	: > "$MANIFEST"  # clear or create the manifest file

	# parse TSV: filename, filepath, sliced_path, bytes
	echo "$(date +"%Y-%m-%d %H:%M:%S") Reading input and verifying sliced_path"

	# extract unique sliced_path values
	mapfile -t SLICED_PATHS < <(cut -f3 "$INPUT_TSV" | tail -n +2 | sort -u)

	if [[ "${#SLICED_PATHS[@]}" -ne 1 ]]; then
	    echo "Error: More than one unique sliced_path found:" >&2
	    printf "%s\n" "${SLICED_PATHS[@]}" >&2
	    exit 1
	fi

	SLICED_PATH=$(echo "${SLICED_PATHS[0]}" | cut -c 23)
	DST_PATH="gs://fc-dcbd33a0-b9cf-475e-97c5-7fcfa3b51c71/${SLICED_PATH}"

	# Sum bytes
	TOTAL_BYTES=$(cut -f4 "$INPUT_TSV" | tail -n +2 | paste -sd+ - | bc)
	NEEDED_BYTES=$(awk -v b="$TOTAL_BYTES" 'BEGIN { printf "%.0f", b * 1.5 }')
	NEEDED_HUMAN=$(numfmt --to=iec --format "%.2f" "$NEEDED_BYTES")

	# Check available disk space
	# If we were not in a docker image this would check /data on the node... not sure if this'll work
	# doesn't work: df --output=avail -B1 $HOME | tail -1
	# doesn't work: du -s
	# doesn't quite work but won't error: AVAILABLE_BYTES=$(stat -f --format="%a*%s" . | bc)
	#AVAILABLE_HUMAN=$(numfmt --to=iec --format "%.2f" "$AVAILABLE_BYTES")

	#if (( AVAILABLE_BYTES < NEEDED_BYTES )); then
	#    echo "Error: Not enough storage space in /data" >&2
	#    echo "Needed (with 1.5x buffer): $NEEDED_BYTES bytes ($NEEDED_HUMAN)" >&2
	#    echo "Available: $AVAILABLE_BYTES bytes ($AVAILABLE_HUMAN)" >&2
	#    exit 1
	#fi
	echo "Expecting to require $NEEDED_BYTES bytes ($NEEDED_HUMAN)"

	echo "$(date +"%Y-%m-%d %H:%M:%S") Starting AWS download"
	mkdir -p ./s3_download
	tail -n +2 "$INPUT_TSV" | while IFS=$'\t' read -r filename filepath sliced_path bytes; do
	    echo "Downloading $filepath"
	    aws s3 cp --no-sign-request "$filepath" ./s3_download
	done

	echo "$(date +"%Y-%m-%d %H:%M:%S") Starting checksums"
	find ./s3_download -type f | while read -r file; do
	    size=$(stat -c %s "$file")
	    checksum=$(md5sum "$file" | awk '{ print $1 }')
	    echo "${file#./s3_download/},$size,$checksum" >> "$MANIFEST"
	done

	echo "$(date +"%Y-%m-%d %H:%M:%S") Starting Google upload"
	gcloud storage cp -r -v --billing-project hpp-ucsc ./s3_download/* "$DST_PATH"

	echo "$(date +"%Y-%m-%d %H:%M:%S") Finished"
	>>>

	runtime {
		disks: "local-disk 500 SSD"
		docker: "ashedpotatoes/sailway:latest"
	}

	output {
		File manifest = input_tsv_basename + "_file_manifest.csv"
	}
}
