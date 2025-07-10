Process:
0. `pip install polars` on the off chance you aren't already using the best dataframe software ever
1. Download a sheet from the master index file workbook (one sheet per sequencing technology)
2. `python3 create_inputs_from_sheet.py`
3. rm first line of resulting TSV (resulting TSVs saved here in "input_tsvs")
4. Ensure you're authenticated on gcloud on Phoenix and parallel composite uploads are TURNED OFF in config
5. `s3_to_gcs_transfer.slurm`
6. `summarize_logs.sh` in the dir where all the logs got dumped [warning: slow as heck]
7. When the ONT data invitably bugs out:
	* `python3 create_inputs_from_logged_failures.py [input tsv (from step 2)] [summarized log (from step 6)]`
	* `mv_bad_logs.sh` (output of create_inputs_from_logged_failures.py)
	* `s3_to_gcs_transfer.slurm` on data_to_redo.tsv (another output of create_inputs_from_logged_failures.py)


Other notes:
* skipped_files.tsv logs files that were intentionally skipped for the time being
* the composite HIFI uploads should be redone