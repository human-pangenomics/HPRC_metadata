### HPRC_PLUS_NANOPORE_MISC_R2

Small changes in 'biosample_accession', 'design_description', and 'generator_facility' for consistency/accuracy. Some older uploads ended up with "University of California, Santa Cruz" instead of "UC Santa Cruz Genomics Institute" as generator_facility but I think we can live with that.

Be aware that library_id *and* library_name both exist.

Final CSV setup (see /utils/):
```
index = 'filename'
csv = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_PLUS_nanopore_misc_R2/HPRC_PLUS_nanopore_misc_R2_data_table.csv'
tsv = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_PLUS_nanopore_misc_R2/metadata-processed-ok-concat.tsv'
overide_csv_with_tsv_in_these_columns = ['biosample_accession', 'design_description', 'generator_facility']
csv_is_actually_tsv = False
```