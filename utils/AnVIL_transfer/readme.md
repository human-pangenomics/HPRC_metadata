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
0. LOCAL: `pip install polars tqdm` for python scripts, and install aws CLI too (no need to authenticate it) 
	* if you also use [ranchero](github.com/aofarrel/ranchero), but did not install it in a venv, skip the `pip install` to avoid breaking ranchero's dependencies (you'll still need aws CLI though)
1. LOCAL: Download a sheet from the master index file workbook Google Sheet thingy, or whatever you're using to track all your files, as a CSV file
2. LOCAL: `python3 create_inputs_from_sheet.py [sheet_filename.csv]`
	* this will ping AWS via `--no-sign-request` for file metadata; expect ~1 sec per file
4. LOCAL: rm first line of resulting TSV (resulting TSVs saved here in "input_tsvs")
5. PHOENIX: Ensure you're authenticated on gcloud on Phoenix and parallel composite uploads are TURNED OFF in config
	* parallel composite uploads are the DEFAULT, so make sure it's off or else you'll have to upload everything again
 	* to turn them off: `gcloud config set storage/parallel_composite_upload_enabled False` (you only need to do this once)
6. PHOENIX: `s3_to_gcs_transfer.slurm` (see instructions in that file for args)
	* note the hardcoded outpath you may want to change: `/private/groups/migalab/ash/DO_NOT_DELETE/transfer_manifests`
7. PHOENIX: `summarize_logs.sh [output_summary_filename]` in the dir where all the logs got dumped
	* recklessly grabs all files in the workdir that end in `*.log`
	* may take over an hour to run
    * **found an upload that bugged out? here's your next steps:**   
		* `python3 create_inputs_from_logged_failures.py [input tsv (from step 2, should have no header)] [summarized log (from step 6)]`  
		* `mv_bad_logs.sh` (output of create_inputs_from_logged_failures.py)  
		* `s3_to_gcs_transfer.slurm` on data_to_redo.tsv (another output of create_inputs_from_logged_failures.py)  

8. PHEONIX: Once you have everything transferred, cat all your manifest files that are in `/private/groups/migalab/ash/DO_NOT_DELETE/transfer_manifests`
	* if that folder has not been cleaned out yet, be aware some of the very first ones I did waaaay back had a different pattern, so you may need to use `awk` for cleaning up


## Old notes which may or may not be relevant
Todo:
* the logs (not the summaries!) are comically oversized and should be deleted from /private/groups/migalab/ash/logs_* to save space, once we have confirmed all is well
	* google cloud uses `^M` for its progress bars and all that overwritten stuff gets saved to the log too (this is one reason why parsing takes forever) 

Archive notes:
* KINNEX_straggler exists due to goofing up an ARRAY_SIZE

There may be some files that on the DC sheet and the HIFI sheet with the same filename, but are in different S3 paths? check this isn't a column mixup on my end
* s3://human-pangenomics/working/HPRC/HG01361/raw_data/PacBio_HiFi/deepconsensus/v1pt2/HG01361.m54329U_200311_082605.dc.q20.fastq.gz
* s3://human-pangenomics/submissions/3A25CF8A-1F36-42EE-BC9F-D29CECAA2A99--HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/HG01361/raw_data/PacBio_HiFi/deepconsensus/v1pt2/HG01361.m54329U_200311_082605.dc.q20.fastq.gz
