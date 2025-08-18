## WUSTL_HPRC_Hifi_Year2

Submission CSV has 89 filenames
Wrangled CSV has 89 filenames (loss: 0)
TSV has 89 filenames (loss: 0)

Oddities:
* **ccs_algorithm, polymerase_version, and notes are inconsistent across data tables**
* AWS table has lots of files not in data table, worth double-checking all excluded files were excluded for a good reason
* WUSTL_HPRC_HiFi_Year2_post_sra_metadata.tsv seems to be based on SRA metadata TSV but didn't split the filenames correctly; moved to "sus" folder
* Each run accession has multiple bam files -- this is technically valid but not recommended nor typical


Validation:
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year2/HPRC_PacBio_HiFi_Metadata_Submission_WUSTL_Year2_v0.2.tsv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year2/WUSTL_HPRC_HiFi_Year2_data_table.csv'
NCBI_tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/WUSTL_HPRC_HiFi_Year2/metadata-11121843-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = ['data_type']
allowed_wrangled_NCBI_conflicts = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```

```
┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (89, 3)
┌───────────────┬─────────────────────┬─────────────────────────────────────┐
│ ccs_algorithm ┆ ccs_algorithm_right ┆ __index__filename                   │
│ ---           ┆ ---                 ┆ ---                                 │
│ str           ┆ str                 ┆ str                                 │
╞═══════════════╪═════════════════════╪═════════════════════════════════════╡
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64043_210205_190424.hifi_reads.bam │
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64043_210207_011920.hifi_reads.bam │
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64043_210209_184051.hifi_reads.bam │
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64043_210211_005516.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210506_183430.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210508_033135.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210509_110105.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210514_184131.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210516_020821.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210517_175123.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210519_013026.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210520_180149.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210522_023949.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210523_101851.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210524_174752.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210528_171552.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210530_003337.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210531_080529.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210601_160048.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210604_175624.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210606_013256.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210607_090252.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210610_203329.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210612_053030.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210613_133026.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210614_223013.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210618_184604.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210620_041711.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210622_163331.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210624_032817.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210625_184443.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210627_054642.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210628_151651.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210702_183246.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210704_052805.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210705_162656.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210707_032602.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210709_205614.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210716_230222.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210718_100009.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210719_210019.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210723_184340.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210725_053930.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210726_163819.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64043_210728_163353.hifi_reads.bam │
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64136_210205_190622.hifi_reads.bam │
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64136_210207_012053.hifi_reads.bam │
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64136_210209_184241.hifi_reads.bam │
│ 6.0.0         ┆ 9.0.0.92188         ┆ m64136_210211_010151.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210317_200525.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210319_191015.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210321_022417.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210323_162524.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210514_184433.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210516_022225.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210517_184202.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210519_033858.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210520_180433.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210522_014758.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210523_100337.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210525_165246.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210528_171842.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210530_004827.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210531_083342.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210602_151340.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210604_175856.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210606_025622.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210607_115559.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210610_203618.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210612_053350.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210613_130744.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210614_204240.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210618_184849.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210620_054327.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210622_163607.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210624_033152.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210625_184731.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210627_054246.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210628_163953.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210702_183526.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210704_053041.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210705_162724.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210716_230343.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210718_091611.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210719_201505.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210723_184622.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210725_054129.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210726_163800.hifi_reads.bam │
│ 6.0.0         ┆ 10.1.0.115913       ┆ m64136_210728_163638.hifi_reads.bam │
└───────────────┴─────────────────────┴─────────────────────────────────────┘
```

* polymerase_version suffers the same issue:
```
┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (77, 3)
┌────────────────────┬──────────────────────────┬─────────────────────────────────────┐
│ polymerase_version ┆ polymerase_version_right ┆ __index__filename                   │
│ ---                ┆ ---                      ┆ ---                                 │
│ str                ┆ str                      ┆ str                                 │
╞════════════════════╪══════════════════════════╪═════════════════════════════════════╡
│ P2.2               ┆ P2                       ┆ m64043_210506_183430.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210508_033135.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210509_110105.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210514_184131.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210516_020821.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210517_175123.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210519_013026.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210520_180149.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210522_023949.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210523_101851.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210524_174752.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210528_171552.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210530_003337.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210531_080529.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210601_160048.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210604_175624.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210606_013256.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210607_090252.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210610_203329.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210612_053030.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210613_133026.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210614_223013.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210618_184604.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210620_041711.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210622_163331.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210624_032817.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210625_184443.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210627_054642.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210628_151651.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210704_052805.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210705_162656.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210707_032602.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210709_205614.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210716_230222.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210718_100009.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210719_210019.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210723_184340.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210725_053930.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210726_163819.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64043_210728_163353.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210205_190622.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210207_012053.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210209_184241.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210211_010151.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210317_200525.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210319_191015.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210321_022417.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210323_162524.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210514_184433.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210516_022225.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210517_184202.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210519_033858.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210528_171842.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210530_004827.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210531_083342.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210602_151340.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210604_175856.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210606_025622.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210607_115559.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210610_203618.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210612_053350.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210613_130744.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210614_204240.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210618_184849.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210625_184731.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210627_054246.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210628_163953.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210702_183526.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210704_053041.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210705_162724.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210716_230343.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210718_091611.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210719_201505.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210723_184622.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210725_054129.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210726_163800.hifi_reads.bam │
│ P2.2               ┆ P2                       ┆ m64136_210728_163638.hifi_reads.bam │
└────────────────────┴──────────────────────────┴─────────────────────────────────────┘
```

