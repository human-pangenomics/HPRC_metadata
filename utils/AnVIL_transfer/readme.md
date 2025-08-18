This contains all the stuff relating to moving these files into AnVIL.

NOTE: My understanding is that AnVIL files will be moved to another workspace once they are in the AnVIL datastore, and the current bucket they are in is temporary. As such, DO NOT consider their current gs:// URIs as permament!

## Files that did NOT get transferred
* Anything that wasn't in working as of mid-July 2025
* Everything in `HPRC_metadata/utils/AnVIL_transfer/input_tsvs/ONT_data_to_input (attempt 3, files corrupt?).tsv`
	* HG005_Circulomics_PromethION_R941.part02.UL_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam
	* HG005_Circulomics_GridION_R941.part02.UL_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam
	* 03_08_22_R941_HG002_5.bam
	* 03_08_22_R941_HG002_4.bam
	* HG005_Circulomics_GridION_R941.part01.UL_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam
	* 41.part01.UL_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam

## Files that MIGHT need to be retransferred
* HG00738.m64043_210530_003337.dc.q20.fastq.gz: This one probably made it okay, but it looks like slurm got mad at me at the very end, see `s3_transfer_10006226_198.log`

## Process:
0. LOCAL: `pip install polars tqdm` for python scripts 
1. LOCAL: Download a sheet from the master index file workbook Google Sheet as a CSV file
2. LOCAL: `python3 create_inputs_from_sheet.py [sheet_filename.csv]` (requires aws CLI, but it doesn't need to be authenticated)
3. LOCAL: rm first line of resulting TSV (resulting TSVs saved here in "input_tsvs")
4. PHOENIX: Ensure you're authenticated on gcloud on Phoenix and parallel composite uploads are TURNED OFF in config
	* If you're not sure, run: `gcloud config set storage/parallel_composite_upload_enabled False`
5. PHOENIX: `s3_to_gcs_transfer.slurm` (see instructions in that file for args)
	* This has a hardcoded outpath: `/private/groups/migalab/ash/DO_NOT_DELETE/transfer_manifests`
6. PHOENIX: `summarize_logs.sh [output_summary_filename]` in the dir where all the logs got dumped
	* This grabs all files in the workdir that end in `*.log` so if there are logs you already parsed in there... move 'em
	* Please be aware that this is script is EXTREMELY slow and could take over an hour to run
--> If anything bugs out:
	* `python3 create_inputs_from_logged_failures.py [input tsv (from step 2, should have no header)] [summarized log (from step 6)]`
	* `mv_bad_logs.sh` (output of create_inputs_from_logged_failures.py)
	* `s3_to_gcs_transfer.slurm` on data_to_redo.tsv (another output of create_inputs_from_logged_failures.py)
7. PHEONIX: Once you have everything transferred, cat all your manifest files that are in `/private/groups/migalab/ash/DO_NOT_DELETE/transfer_manifests` -- be aware the first 30ish have a different pattern and the others will repeat the header, so you'll want to make some quick edits with awk (or a proper text editor)


Todo:
* the logs (not the summaries!) are comically oversized and should be deleted from /private/groups/migalab/ash/logs_* to save space, once we have confirmed all is well

Archive notes:
* KINNEX_straggler exists due to goofing up an ARRAY_SIZE






There may be some files that on the DC sheet and the HIFI sheet with the same filename, but are in different S3 paths? check this isn't a column mixup on my end
* s3://human-pangenomics/working/HPRC/HG01361/raw_data/PacBio_HiFi/deepconsensus/v1pt2/HG01361.m54329U_200311_082605.dc.q20.fastq.gz
* s3://human-pangenomics/submissions/3A25CF8A-1F36-42EE-BC9F-D29CECAA2A99--HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/HG01361/raw_data/PacBio_HiFi/deepconsensus/v1pt2/HG01361.m54329U_200311_082605.dc.q20.fastq.gz
