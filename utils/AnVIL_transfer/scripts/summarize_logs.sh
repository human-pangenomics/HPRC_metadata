#!/bin/bash
# This isn't very quick but it's good enough for our purposes
set -euo pipefail

OUT_TSV="ont_logs_summary.tsv" # or whatever
echo -e "log\tfilename\tmanifest\tstatus\tthroughput" > "$OUT_TSV"

for log in *.log; do
	filename=""
	manifest=""
	status="1"
	throughput=""

	# Extract relevant lines
	while IFS= read -r line || [[ -n "$line" ]]; do
		# Local filename line (timestamp prefix tolerated)
		if [[ "$line" =~ Local[[:space:]]filename:[[:space:]]*(.*) ]]; then
			filename="${BASH_REMATCH[1]}"
			# Read next line safely
			read -r next_line || true
			if [[ "$next_line" =~ Task\ mainfest:\ (.+) ]]; then
				manifest="${BASH_REMATCH[1]}"
			fi
		fi

		# Throughput line
		if [[ "$line" =~ Average\ throughput:\ (.+) ]]; then
			throughput="${BASH_REMATCH[1]}"
		fi
	done < "$log"

	# Check last line for status conditions
	last_line=$(tail -n 1 "$log")
	if [[ "$last_line" == *"[Errno 28] No space left on device" ]]; then
		status="28"
	elif [[ "$last_line" == *"to select an already authenticated account to use."* ]]; then
		status="2"
	elif [[ "$last_line" == *"✓ Transferred:"* ]]; then
		status="0"
	fi

	echo -e "${log}\t${filename}\t${manifest}\t${status}\t${throughput}" >> "$OUT_TSV"
done