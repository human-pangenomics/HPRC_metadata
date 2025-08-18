## UCSC_HPRC_nanopore_Year3

This one is a bit messy.
* Some files were already uploaded to SRA
	* See: `metadata-13898073-processed-ok.tsv`
* Some files I tried to upload to SRA, but have been stuck in "processing" for two months! SRA submission is SUB15329688
	* See: `SRA_upload_2025-05-19.tsv`
	* It turns out the method I was using to detect if something was on SRA or not was not 100% reliable, so there is a chance these would have been double-uploads
* Some files were not uploaded due to being fail bams
	* See: `not_on_sra_FAIL.tsv`
* Some files were not uploaded due to lacking virtually all metadata
	* See: `not_on_SRA_lacks_metadata.tsv`
* Some files were not uploaded as I don't have BioSamples for them
	* See: `not_on_sra_R3.tsv`


Attempted validation (will fail and doesn't account for anything in SRA_upload_2025-05-19.tsv):
```
submission_csv_path = '../submissions/UCSC_HPRC_nanopore_Year3/UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.tsv'
wrangled_csv_path = '../submissions/UCSC_HPRC_nanopore_Year3/UCSC_HPRC_nanopore_Year3_data_table.csv'
NCBI_tsv_path = '../submissions/UCSC_HPRC_nanopore_Year3/metadata-13898073-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = []
allowed_wrangled_NCBI_conflicts = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```


Ash's process
1. Cleaned some stuff up
2. (uselessly) Split existing SRA table into two based on whether or not samples had run accessions
3. p2 of the SRA table (the one that has files not on SRA) was merged with metadata table, greatly increasing the number of samples (yes, this basically re-adds back in the p1 samples) -- we did this because the metadata table and the SRA table have different metadata and combining them gives us the most possible
4. Took p2-metadata merge and compared against BQ to see what's actually on SRA or not in one big table that has as much metadata as possible, which gave us a list of 365 files not on SRA *(note: now we know this may not be very accurate)*
5. Filter on not having fail in filename, in having a library_selection, and in having an NTSM score
6. Changed generator to different format of UCSC's name, and other assorted cleanups
7. Spun off R3 samples

No summary table due to a mixture of fail bams on and not on SRA

