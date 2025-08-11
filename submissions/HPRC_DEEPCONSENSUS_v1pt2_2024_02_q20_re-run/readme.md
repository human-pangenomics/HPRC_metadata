## HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run

Submission CSV has 196 filenames
Wrangled CSV has 151 filenames (loss: 45)
TSV has 151 filenames (loss: 0)

* ~~UWash/WashU inconsistency~~
* Metadata submission file has more samples than data table (but data table sample number is same as what's on SRA so this is probably fine)
* Some sample IDs seem weird (MGISTL-PAN027)


Validation script:
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_submitter_metadata.csv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/metadata-14737692-processed-ok.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = ['instrument_model']
overide_csv_with_tsv_in_these_columns = []
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```