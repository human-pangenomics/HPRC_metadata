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
NCBI_tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year2_R10/metadata-15307182-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = []
allowed_wrangled_NCBI_conflicts = ['basecaller_model']
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```
