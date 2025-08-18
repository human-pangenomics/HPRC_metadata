## WUSTL_HPRC_Y5_Kinnex

This doesn't appear to have been uploaded to SRA yet. Ash prepared it for upload but is still missing some metadata and therefore couldn't submit it.

Process:
1. Confirmed `m84081_240723_010018_s4` is not in /utils/SRA_transfer/PRJNA731524-2025-06-03.xml nor /utils/SRA_transfer/PRJNA701308-2025-06-03.xml  
2. Convert `WUSTL_HPRC_Y5_Kinnex_metadata.csv` into TSV ([this is what I use](https://github.com/aofarrel/tsvutils/blob/main/csv2tsv.sh))
3. `python3 fill_in_HPRC_ids.py ../submissions/WUSTL_HPRC_Y5_Kinnex/WUSTL_HPRC_Y5_Kinnex_metadata.tsv` and rename the resulting file `WUSTL_HPRC_Y5_Kinnex_SRA_upload.tsv`
4. rename some columns: `__index__new_filename` --> `filename`, `file` --> `aws_path`, `Sample` --> `biosample_accession`, `Run_ID` --> `internal_runID`, `Library` --> `library_ID`, `Platform` --> `platform`, `Instrument_Model` --> `instrument_model`

The following metadata fields still need to be added to `WUSTL_HPRC_Y5_Kinnex_SRA_upload.tsv` for it to be uploaded: 
* title
* library_strategy
* library_source
* library_selection
* library_layout
* design_description
* filetype

No validation due to it not being submitted.