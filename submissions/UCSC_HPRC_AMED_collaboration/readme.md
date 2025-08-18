## UCSC_HPRC_AMED_collaboration

validation
```
# ⚠️You'll need to find-replace GM -> NA in the submission file first⚠️
submission_csv_path = '../submissions/UCSC_HPRC_AMED_collaboration/UCSC_HPRC_AMED_collaboration_submission_metadata.csv'
wrangled_csv_path = '../submissions/UCSC_HPRC_AMED_collaboration/UCSC_HPRC_AMED_collaboration_data_table.csv'
NCBI_tsv_path = '../submissions/UCSC_HPRC_AMED_collaboration/metadata-15405441-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = ['library_ID', 'basecaller_model', 'generator_facility']
allowed_wrangled_NCBI_conflicts = ['generator_facility']
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
```