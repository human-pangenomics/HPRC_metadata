# UCSC_HPRC_nanopore_Year2_R10
* Changed data table CSV from 'sample_id' to 'sample_ID' for consistency

Submission CSV has 103 filenames
Wrangled CSV has 103 filenames (loss: 0)
TSV has 103 filenames (loss: 0)

Inconsistencies: 'data_type', 'design_description'

## validation
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year2_R10/UCSC_HPRC_nanopore_Year2_R10_submission_metadata.csv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year2_R10/UCSC_HPRC_nanopore_Year2_R10_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year2_R10/metadata-15307182-processed-ok.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = []
overide_csv_with_tsv_in_these_columns = ['basecaller_model']
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```
