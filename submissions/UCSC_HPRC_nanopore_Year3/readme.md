## UCSC_HPRC_nanopore_Year3

I tried to wrangle this before I realized BigQuery doesn't store all filenames per run accession -- it turns out ~~everything~~ ~~somethings~~ ~~extra things?~~ AHHHHHHH here was already on SRA. :-/


Submission CSV has 434 filenames
Wrangled CSV has 217 filenames (loss: 217)
TSV has 442 filenames (loss: 0)


validate
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year3/UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.tsv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year3/UCSC_HPRC_nanopore_Year3_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year3/metadata-processed-ok-cat.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = []
overide_csv_with_tsv_in_these_columns = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```