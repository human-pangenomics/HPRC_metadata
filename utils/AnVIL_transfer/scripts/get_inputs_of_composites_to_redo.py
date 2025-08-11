# This script was used to redo the 30ish HIFI files needing a redo thanks to being uploaded
# with parallel-composite enabled, which is not compatiable with AnVIL's needs

import subprocess
import polars as pl 
composite = pl.read_csv("/Users/aofarrel/github/HPRC_metadata/utils/AnVIL_transfer/logs_and_manifests/SUMMARY_HIFI_composite_logs.tsv", separator='\t')
all_hifi = pl.read_csv("/Users/aofarrel/github/HPRC_metadata/utils/AnVIL_transfer/input_tsvs/WORKING R2 Sequencing Data Index - hifi.tsv", separator='\t')
df = pl.DataFrame.join(composite, all_hifi, how='inner', on="filename")
prefix = "HIFI_COMPOSITE_REDO"


df_before = df.shape[0]
df = df.filter(df["path"].str.contains("working"))
if df_before != df.shape[0]:
    print(f"WARNING: Ignoring {df_before - df.shape[0]} samples not in working.")
    print("Writing to skipped.tsv")
    df_skipped = df.filter(~df["path"].str.contains("working")).select(['path']).with_columns(why=pl.lit("not in working"))
    df_skipped.write_csv("skipped.tsv", separator="\t")
df = df.with_columns([
    pl.col("path").map_elements(lambda p: p.rsplit("/", 1)[0], return_dtype=pl.Utf8).alias("sliced_path"),
    pl.col("path").map_elements(lambda p: p.rsplit("/", 1)[-1], return_dtype=pl.Utf8).alias("filename")
]).select(["filename", "path", "sliced_path"])

grouped_df = df.group_by("sliced_path").agg([
    pl.len().alias("n_files")
])

all_dfs, bytesums = [], []

# ping AWS for the size of every file, which we will use later to estimate if a disk is big enough for a given file
for sliced_path in grouped_df["sliced_path"]:
    try:
        result = subprocess.run(
            ["aws", "s3", "ls", "--no-sign-request", sliced_path+"/"],
            check=True,
            capture_output=True,
            text=True
        )
    except subprocess.CalledProcessError as e:
        print(f"Warning: Could not list {sliced_path}")
        bytesums.append(0)
        continue

    rows = []
    for line in result.stdout.strip().splitlines():
        parts = line.strip().split(maxsplit=3)
        if len(parts) == 4:
            _, _, size, filename = parts
            rows.append([filename, int(size)])
    new_df = pl.DataFrame(rows, schema=["filename", "bytes"], orient="row")

    # join with original df (non-grouped) on filename
    merged = df.filter(pl.col("sliced_path") == sliced_path).join(
        new_df, on="filename", how="left"
    ).select(["filename", "path", "sliced_path", "bytes"])
    #merged.write_csv(f"{sliced_path.replace('/', '_')}.tsv", separator="\t")

    bytesum = merged["bytes"].sum()
    bytesums.append(bytesum)
    all_dfs.append(merged)

# not needed for slurm input, but could be useful for WDL input
#grouped_df = grouped_df.with_columns([
#    pl.Series("bytesum", bytesums)
#])
#grouped_df.write_csv("grouped.tsv", separator="\t")
#print("\nGrouped Summary:")
#print(grouped_df)

merged_df = pl.concat(all_dfs, how='vertical', rechunk=True)
merged_df.write_csv(f"{prefix}_data_to_input.tsv", separator="\t")
print("\nInput used for SLURM:")
print(merged_df)
print(f"\nWe expect to need a total of {int(merged_df['bytes'].sum()) / 1073741824} GB to store all this!")
