## HPRC_WUSTL_Y3_PacBio_HiFi_TopUp

Note: SRA submission table has different library_IDs as they were previously non-unique. **The new library_IDs should be copied elsewhere as needed.**

51 files of which 0 are fail bams. The remaining 51 from AWS seem to be fail bams.
Submission CSV has 51 filenames
Wrangled CSV has 51 filenames (loss: 0)
TSV has 51 filenames (loss: 0)

Validation:
```
submission_csv_path = '../submissions/WUSTL_HPRC_HiFi_Year3_TopUp/HPRC_WUSTL_Y3_PacBio_HiFi_TopUp_Metadata_Submission_v0.1.tsv'
wrangled_csv_path = '../submissions/WUSTL_HPRC_HiFi_Year3_TopUp/WUSTL_HPRC_HiFi_Year3_TopUp_data_table.csv'
NCBI_tsv_path = '../submissions/WUSTL_HPRC_HiFi_Year3_TopUp/metadata-15309657-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = ['instrument_model']
allowed_wrangled_NCBI_conflicts = ['instrument_model']
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```