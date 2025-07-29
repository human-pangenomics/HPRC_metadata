Process:
0. `pip install polars tqdm` for python scripts
1. Download a sheet from the master index file workbook (one sheet per sequencing technology)
2. `python3 create_inputs_from_sheet.py` (requires aws CLI, but it doesn't need to be authenticated)
3. rm first line of resulting TSV (resulting TSVs saved here in "input_tsvs")
4. Ensure you're authenticated on gcloud on Phoenix and parallel composite uploads are TURNED OFF in config
5. `s3_to_gcs_transfer.slurm`
6. `summarize_logs.sh` in the dir where all the logs got dumped [warning: slow as heck]
7. When the ONT data invitably bugs out:
	* `python3 create_inputs_from_logged_failures.py [input tsv (from step 2, should have no header)] [summarized log (from step 6)]`
	* `mv_bad_logs.sh` (output of create_inputs_from_logged_failures.py)
	* `s3_to_gcs_transfer.slurm` on data_to_redo.tsv (another output of create_inputs_from_logged_failures.py)

Other notes:
* skipped_files.tsv logs files that were intentionally skipped for the time being

Todo:
* the composite HIFI uploads should be redone
* retry ont_take_3.tsv, they were corrupt in aws
* update skipped with hic skipped
* the logs are comically oversized and should have the line full of `^M` stripped to save space in /private/groups

Archive notes:
* KINNEX_straggler exists due to goofing up an ARRAY_SIZE