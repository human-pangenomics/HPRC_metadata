#!/bin/bash

# Path to your TSV file
FILE="qc_result_sample_yr5.tsv"
OUTPUT_FILE="output.tsv"

# Clear the output file at the start of the script
> "$OUTPUT_FILE"

# Write column headers to the output file
echo -e "gs_path\tbytes\tgigabytes\tcost\tprice_tier" >> "$OUTPUT_FILE"

# Find the column index of the 'cram' column
CRAM_COL=$(head -1 "$FILE" | tr '\t' '\n' | grep -n '^cram$' | cut -d: -f1)

# Initialize total cost and total GB variables
total_cost=0
total_gb=0

# Function to calculate cost based on bytes transferred
calculate_cost_from_bytes() {
  bytes=$1  # The byte value extracted from gcloud
  gb=$(echo "scale=6; $bytes / 1024 / 1024 / 1024" | bc -l)  # Convert bytes to GB with high precision

  # Define tier thresholds and prices
  tier1_limit=1024      # Up to 1 TB, which is 1024 GB
  tier2_limit=10240     # Up to 10 TB, which is 10240 GB
  price_tier1=0.12      # Cost per GB for the first 1 TB
  price_tier2=0.11      # Cost per GB for the next 9 TB
  price_tier3=0.08      # Cost per GB for any amount above 10 TB

  # Calculate cost based on tiered pricing and determine the tier used
  if (( $(echo "$gb <= $tier1_limit" | bc -l) )); then
    cost=$(echo "scale=2; $gb * $price_tier1" | bc)
    tier="tier-1"
  elif (( $(echo "$gb <= $tier2_limit" | bc -l) )); then
    cost=$(echo "scale=2; $tier1_limit * $price_tier1 + ($gb - $tier1_limit) * $price_tier2" | bc)
    tier="tier-2"
  else
    cost=$(echo "scale=2; $tier1_limit * $price_tier1 + ($tier2_limit - $tier1_limit) * $price_tier2 + ($gb - $tier2_limit) * $price_tier3" | bc)
    tier="tier-3"
  fi
  echo "$cost $tier"
}

# Read the TSV file, skip the header, and extract the 'cram' column using the found index
while IFS=$'\t' read -r -a array
do
  cram_path="${array[$CRAM_COL-1]}" # Adjusting index for zero-based array
  bytes=$(gcloud storage --billing-project 312334366301 ls --readable-sizes --long "$cram_path" | grep 'bytes' | awk '{print $4}')
  result=$(calculate_cost_from_bytes $bytes)
  cost=$(echo $result | awk '{print $1}')
  tier=$(echo $result | awk '{print $2}')
  gb=$(echo "scale=6; $bytes / 1024 / 1024 / 1024" | bc -l)  # Convert bytes to GB again for total
  printf "%s\t%s\t%s\t\$%.2f\t%s\n" "$cram_path" "$bytes" "$gb" "$cost" "$tier" >> "$OUTPUT_FILE"
  # Add this cost to the total cost and the GB to total GB
  total_cost=$(echo "$total_cost + $cost" | bc)
  total_gb=$(echo "$total_gb + $gb" | bc)
done < <(tail -n +2 "$FILE")

# Print the total cost and total GB to the terminal
echo -e "Total cost for all transfers: \$${total_cost}\nTotal GB transferred: ${total_gb} GB"
