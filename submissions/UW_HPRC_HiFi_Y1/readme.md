## UW_HPRC_HiFi_Y1

No submission-ok file from NCBI as it doesn't show in submission portal.

Submission CSV has 46 filenames
Wrangled CSV has 44 filenames (loss: 2)   <--- I don't love this but if they're on the Index sheet it's okay
TSV has 46 filenames (loss: 0)

Validation:
```
submission_csv_path = '../submissions/UW_HPRC_HiFi_Y1/201112_UW_HPRC_PacBio_HiFi_Metadata_Submission_v0.2_kmmod.tsv'
wrangled_csv_path = '../submissions/UW_HPRC_HiFi_Y1/UW_HPRC_HiFi_Y1_data_table.csv'
tsv_path = '../submissions/UW_HPRC_HiFi_Y1/UW_HPRC_HiFi_Y1_post_sra_metadata.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = []
overide_csv_with_tsv_in_these_columns = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```