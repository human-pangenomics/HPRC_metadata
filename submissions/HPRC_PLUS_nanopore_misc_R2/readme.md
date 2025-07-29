### HPRC_PLUS_NANOPORE_MISC_R2

Metadata changes:
* University of California, Santa Cruz --> UC Santa Cruz Genomics Institute
* Added title field
* Fixed incorrect biosample for HG00733
* Fixed missing biosamples for HG005 and HG002
* Changed two descriptions to clarify GridION vs PromethION

Some older uploads ended up with "University of California, Santa Cruz" instead of "UC Santa Cruz Genomics Institute" as generator_facility but I think we can live with that.

Final CSV setup (see /utils/):
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_PLUS_nanopore_misc_R2/HPRC_PLUS_nanopore_misc_R2_submission_metadata.csv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_PLUS_nanopore_misc_R2/HPRC_PLUS_nanopore_misc_R2_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_PLUS_nanopore_misc_R2/metadata-processed-ok-concat.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = []
overide_csv_with_tsv_in_these_columns = ['biosample_accession', 'design_description', 'generator_facility']
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
```