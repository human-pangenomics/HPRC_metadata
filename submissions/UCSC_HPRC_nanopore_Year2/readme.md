## UCSC_HPRC_nanopore_Year2

* Removed trailing six tabs from UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.tsv




submission vs wrangled
```
┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (2, 3)
┌────────────────────┬──────────────────────────┬──────────────────────────────────────────────────────────────────────────────┐
│ basecaller_version ┆ basecaller_version_right ┆ __index__filename                                                            │
│ ---                ┆ ---                      ┆ ---                                                                          │
│ str                ┆ str                      ┆ str                                                                          │
╞════════════════════╪══════════════════════════╪══════════════════════════════════════════════════════════════════════════════╡
│ 6.5.7              ┆ 6.4.6                    ┆ 08_10_21_R941_HG00642_2_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam │
│ 6.5.7              ┆ 6.4.6                    ┆ 08_10_21_R941_HG00642_3_Guppy_6.5.7_450bps_modbases_5mc_cg_sup_prom_pass.bam │
└────────────────────┴──────────────────────────┴──────────────────────────────────────────────────────────────────────────────┘
```

validator
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year2/UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.tsv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year2/UCSC_HPRC_nanopore_Year2_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UCSC_HPRC_nanopore_Year2/metadata-processed-ok-concat.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = ['generator_facility']
overide_csv_with_tsv_in_these_columns = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```