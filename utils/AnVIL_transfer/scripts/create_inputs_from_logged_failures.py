# Did some of your samples refuse to upload to GCS? Use this to sort through
# the logs. Why we don't just sort through the log files? Because I stupidly
# made it possible for a task to exit 1 before it ever says what file it's trying
# to operate upon. So, in order to properly know which files we need to rerun,
# we need to concat/merge a log-summary dataframe with an all-inputs dataframe.
import polars as pl
import sys
inputs = pl.read_csv(sys.argv[1], separator="\t", has_header=False)
inputs = inputs.rename({'column_1': 'filename', 'column_2':'path', 'column_3':'sliced_path', 'column_4': 'bytes'})
logs_summary = pl.read_csv(sys.argv[2], separator="\t")
results = pl.concat([inputs, logs_summary], how="align_full")

# prepare to mv failing logs and manifests, just to keep migalab tidy
print("Outputting a shell script to move logs of the failures")
with open("mv_bad_logs.sh", 'w') as file:
    file.write("# /bin/bash\n")
    for row in results.iter_rows(named=True):
        if row["status"] != 0:
            if row["log"] is not None:
                file.write(f'mv /private/groups/migalab/ash/{row["log"]} /private/groups/migalab/ash/oops_all_berries/ont\n')
            if row["manifest"] is not None:
                file.write(f'mv /private/groups/migalab/ash/DO_NOT_DELETE/transfer_manifests/{row["manifest"]} /private/groups/migalab/ash/oops_all_berries/ont\n')

grouped = results.group_by('filename').agg([
    pl.col('status'), pl.col('throughput'), pl.col('manifest'), pl.col('log'), pl.col('path'), pl.col('sliced_path'), pl.col('bytes')
])
grouped = grouped.filter(pl.col('filename').is_not_null()) # handle aforementioned stupidity w/o crashing
for col in ['status', 'throughput', 'manifest', 'log', 'path', 'sliced_path', 'bytes']:
    if grouped.filter(pl.col(col).list.len() > 1).shape[0] == 0:
        grouped = grouped.with_columns(pl.col(col).list.first().alias(col))
    else:
        print(f"Multiple values for {col} which should never happen. Can't continue.")
        with pl.Config(tbl_cols=-1, tbl_rows=100, fmt_str_lengths=200, fmt_table_cell_list_len=3):
            print(grouped.filter(pl.col(col).list.len() > 1))
            exit(1)
with pl.Config(tbl_cols=-1, tbl_rows=100, fmt_str_lengths=200, fmt_table_cell_list_len=3):
    print(grouped.sort('status'))
zero = grouped.filter(pl.col('status') == pl.lit(0))
redo = grouped.filter((pl.col('status') != pl.lit(0)).or_(pl.col('status').is_null()))
print(f"Out of {grouped.height}, {zero.height} returned 0 and {redo.height} need to be redone.")
print("Outputting a new input dataframe of just the stuff we have to redo.")
redo.select(['filename', 'path', 'sliced_path', 'bytes']).write_csv("data_to_redo.tsv", separator="\t")
