## RU_Y3_topoff_redo

* Submissions CSV is way larger than data table CSV
* Data table CSV has different values for sample_ID compared to submissions table
```
┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (19, 3)
┌───────────┬─────────────────┬───────────────────────────────────────────────┐
│ sample_ID ┆ sample_ID_right ┆ __index__filename                             │
│ ---       ┆ ---             ┆ ---                                           │
│ str       ┆ str             ┆ str                                           │
╞═══════════╪═════════════════╪═══════════════════════════════════════════════╡
│ HG03470   ┆ NA19338         ┆ m84091_230705_174256_s2.hifi_reads.bc1002.bam │
│ HG03470   ┆ NA19338         ┆ m84091_230705_184508_s4.hifi_reads.bc1002.bam │
│ HG01960   ┆ NA19159         ┆ m84091_230817_150246_s3.hifi_reads.bc1015.bam │
│ HG00658   ┆ HG02841         ┆ m84091_230905_192642_s1.hifi_reads.bc1015.bam │
│ HG00658   ┆ HG01150         ┆ m84091_230905_192642_s1.hifi_reads.bc1019.bam │
│ HG00658   ┆ HG02841         ┆ m84091_230905_195701_s2.hifi_reads.bc1015.bam │
│ HG00658   ┆ HG01150         ┆ m84091_230905_195701_s2.hifi_reads.bc1019.bam │
│ HG00658   ┆ HG02841         ┆ m84091_230905_202807_s3.hifi_reads.bc1015.bam │
│ HG00658   ┆ HG01150         ┆ m84091_230905_202807_s3.hifi_reads.bc1019.bam │
│ HG01252   ┆ HG03050         ┆ m84091_230905_205913_s4.hifi_reads.bc1017.bam │
│ HG01150   ┆ HG02984         ┆ m84091_231004_192043_s3.hifi_reads.bc1016.bam │
│ NA19338   ┆ NA19391         ┆ m84091_231120_175800_s4.hifi_reads.bc1015.bam │
│ HG01784   ┆ NA19185         ┆ m84091_231120_182829_s1.hifi_reads.bc1017.bam │
│ HG02391   ┆ NA19087         ┆ m84091_231120_185935_s2.hifi_reads.bc1016.bam │
│ HG03742   ┆ NA18570         ┆ m84091_231120_193041_s3.hifi_reads.bc1012.bam │
│ HG01530   ┆ NA19468         ┆ m84091_231208_194716_s4.hifi_reads.bc1008.bam │
│ HG01530   ┆ HG03458         ┆ m84091_231208_201822_s1.hifi_reads.bc1011.bam │
│ HG01530   ┆ NA20799         ┆ m84091_231208_204928_s2.hifi_reads.bc1018.bam │
│ NA19468   ┆ NA20799         ┆ m84091_231211_215746_s3.hifi_reads.bc1018.bam │
└───────────┴─────────────────┴───────────────────────────────────────────────┘
```

Validator:
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y3_topoff_redo/HPRC_RU_Y3_topoff_Metadata_Submission.tsv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y3_topoff_redo/RU_Y3_topoff_redo_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y3_topoff_redo/metadata-14678794-processed-ok.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = ['instrument_model']
overide_csv_with_tsv_in_these_columns = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
```