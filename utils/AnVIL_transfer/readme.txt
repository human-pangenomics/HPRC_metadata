This contains all the stuff relating to moving these files into AnVIL.

NOTE: My understanding is that AnVIL files will be moved to another workspace once they are in the AnVIL datastore, and the current bucket they are in is temporary.


Process:
0. LOCAL: `pip install polars tqdm` for python scripts
1. LOCAL: Download a sheet from the master index file workbook Google Sheet as a CSV file
2. LOCAL: `python3 create_inputs_from_sheet.py [sheet_filename.csv]` (requires aws CLI, but it doesn't need to be authenticated)
3. LOCAL: rm first line of resulting TSV (resulting TSVs saved here in "input_tsvs")
4. PHOENIX: Ensure you're authenticated on gcloud on Phoenix and parallel composite uploads are TURNED OFF in config
	* If you're not sure, run: `gcloud config set storage/parallel_composite_upload_enabled False`
5. PHOENIX: `s3_to_gcs_transfer.slurm`
6. PHOENIX: `summarize_logs.sh` in the dir where all the logs got dumped [warning: slow as heck]
7. PHOENIX: When the ONT data invitably bugs out:
	* `python3 create_inputs_from_logged_failures.py [input tsv (from step 2, should have no header)] [summarized log (from step 6)]`
	* `mv_bad_logs.sh` (output of create_inputs_from_logged_failures.py)
	* `s3_to_gcs_transfer.slurm` on data_to_redo.tsv (another output of create_inputs_from_logged_failures.py)

Other notes:
* skipped_files.tsv logs files that were intentionally skipped for the time being (but it's incomplete so don't take it as gospel)
* The anvil bucket is temporary before being moved to the final anvil data store

Todo:
* the composite HIFI uploads should be redone --> done, but need to be added to manifests master file
* retry ont_take_3.tsv, they were corrupt in aws
* update skipped with hic skipped
* the logs are comically oversized and should have the line full of `^M` stripped to save space in /private/groups

Archive notes:
* KINNEX_straggler exists due to goofing up an ARRAY_SIZE






There may be some files that on the DC sheet and the HIFI sheet with the same filename, but are in different S3 paths? check this isn't a column mixup on my end
* s3://human-pangenomics/working/HPRC/HG01361/raw_data/PacBio_HiFi/deepconsensus/v1pt2/HG01361.m54329U_200311_082605.dc.q20.fastq.gz
* s3://human-pangenomics/submissions/3A25CF8A-1F36-42EE-BC9F-D29CECAA2A99--HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/HG01361/raw_data/PacBio_HiFi/deepconsensus/v1pt2/HG01361.m54329U_200311_082605.dc.q20.fastq.gz
