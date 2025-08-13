## RU_Y3_HIFI

Submission CSV has 94 filenames
Wrangled CSV has 95 filenames (loss: -1)
TSV has 95 filenames (loss: 0)

Validation issues: 
* Found filenames in wrangled CSV but not submitted CSV: {'m64330e_220915_165522.5mc.hifi_reads.bam'}
* Submitted metadata specifically says "Sequel IIe" but what's on SRA seems to be "Sequel II" (which is a different machine)

Validation:
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y3_HIFI/HPRC_RU_Y3_HiFi_Metadata_Submission.csv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y3_HIFI/RU_Y3_HIFI_data_table.csv'
NCBI_tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y3_HIFI/metadata-14648156-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = ['library_ID']
allowed_wrangled_NCBI_conflicts = []
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```