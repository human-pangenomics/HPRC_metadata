## HPRC_PLUS_NANOPORE_MISC_R2

Metadata changes:
* University of California, Santa Cruz --> UC Santa Cruz Genomics Institute
* Added title field
* Fixed incorrect BioSample (rather, less correct) for HG00733
* Fixed missing BioSamples for HG005 and HG002
* Changed two descriptions to clarify GridION vs PromethION

Some older uploads ended up with "University of California, Santa Cruz" instead of "UC Santa Cruz Genomics Institute" as generator_facility but I think we can live with that.

Validation:
```
submission_csv_path = '../submissions/HPRC_PLUS_nanopore_misc_R2/HPRC_PLUS_nanopore_misc_R2_submission_metadata.csv'
wrangled_csv_path = '../submissions/HPRC_PLUS_nanopore_misc_R2/HPRC_PLUS_nanopore_misc_R2_data_table.csv'
NCBI_tsv_path = '../submissions/HPRC_PLUS_nanopore_misc_R2/metadata-processed-ok-concat.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = []
allowed_wrangled_NCBI_conflicts = ['biosample_accession', 'design_description', 'generator_facility']
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```