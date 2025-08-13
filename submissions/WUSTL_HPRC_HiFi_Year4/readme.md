## WUSTL_HPRC_HiFi_Year4

Submission CSV has 97 filenames
Wrangled CSV has 97 filenames (loss: 0)
TSV has 97 filenames (loss: 0)

Be aware that library IDs were changed at some point (this doesn't matter unless you're keying on them)

Validation:
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year4/HPRC_WUSTL_Y4_PacBio_HiFi_Metadata_Submission_v0.1.final.csv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year4/WUSTL_HPRC_HiFi_Year4_data_table.csv'
NCBI_tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year4/metadata-14529157-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = ['library_ID', 'instrument_model', 'generator_facility']
allowed_wrangled_NCBI_conflicts = ['generator_facility']
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```