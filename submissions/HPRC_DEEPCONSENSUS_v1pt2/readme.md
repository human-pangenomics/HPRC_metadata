## HPRC_DEEPCONSENSUS_v1pt2

Submission CSV has 132 filenames
Wrangled CSV has 132 filenames (loss: 0)
TSV has 132 filenames (loss: 0)

Some inconsistencies in size_selection, design_description, and polymerase_version

For example, for HG00642.m64076_210516_091844.dc.q20.fastq.gz
* BluePippin in DEEPCONSENSUS_v1pt2_submitter_metadata.tsv
* PippinHT in DEEPCONSENSUS_v1pt2_partial_sra_submission.tsv
* PippinHT in HPRC_DEEPCONSENSUS_v1pt2_data_table.csv
* BluePippin in DEEPCONSENSUS_v1pt2__final.tsv
* PippinHT in metadata-13754908-processed-ok.tsv


```
Note: These conflicts are between DEEPCONSENSUS_v1pt2__final.tsv (the "final" file) and HPRC_DEEPCONSENSUS_v1pt2_data_table.csv (the "first" file) -- as noted above there are other conflicts!

┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (49, 3)
┌────────────────┬──────────────────────┬───────────────────────────────────────────┐
│ size_selection ┆ size_selection_right ┆ __index__filename                         │
│ ---            ┆ ---                  ┆ ---                                       │
│ str            ┆ str                  ┆ str                                       │
╞════════════════╪══════════════════════╪═══════════════════════════════════════════╡
│ PippinHT       ┆ BluePippin           ┆ HG00642.m54329U_210524_174516.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG00642.m64076_210516_091844.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG00642.m64076_210520_213355.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG00642.m64076_210522_082905.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG01346.m54329U_210624_221223.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG01346.m54329U_210629_024631.dc.q20.fas… │
│ SageELF        ┆ BluePippin           ┆ HG01346.m64076_210621_234241.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG01884.m54329U_210713_205453.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG01884.m54329U_210716_214728.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG01884.m54329U_210718_084331.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02132.m54329U_210627_170630.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02132.m54329U_210704_040110.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02132.m54329U_210705_145805.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02293.m54329U_210719_222842.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02293.m54329U_210721_092510.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02293.m64076_210716_220011.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02300.m54329U_210702_182525.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02300.m54329U_210710_123004.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02300.m54329U_210711_215946.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02647.m54329U_210604_200442.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02647.m64076_210527_231639.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02647.m64076_210530_192034.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02647.m64076_210601_061523.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02683.m54329U_210707_171722.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02683.m54329U_210709_030038.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG02683.m64076_210703_103644.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02738.m64076_210706_214544.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02738.m64076_210711_102225.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02738.m64076_210714_200553.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG02738.m64076_210718_085619.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG03688.m54329U_210608_221930.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG03688.m54329U_210611_221457.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG03688.m54329U_210618_202343.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG03688.m64076_210610_224207.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG03927.m54329U_210522_083046.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG03927.m64076_210514_222349.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG03927.m64076_210517_210115.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG03927.m64076_210519_075634.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04115.m64076_210623_104349.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04115.m64076_210625_220013.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04115.m64076_210627_085544.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04184.m64076_210701_234028.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04184.m64076_210708_084125.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04184.m64076_210709_232529.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04184.m64076_210712_194121.dc.q20.fast… │
│ PippinHT       ┆ BluePippin           ┆ HG04199.m54329U_210614_155303.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG04199.m54329U_210620_071842.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG04199.m54329U_210621_233920.dc.q20.fas… │
│ PippinHT       ┆ BluePippin           ┆ HG04199.m64076_210613_183806.dc.q20.fast… │
└────────────────┴──────────────────────┴───────────────────────────────────────────┘

┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (120, 3)
┌────────────────────┬──────────────────────────┬───────────────────────────────────────────┐
│ polymerase_version ┆ polymerase_version_right ┆ __index__filename                         │
│ ---                ┆ ---                      ┆ ---                                       │
│ str                ┆ str                      ┆ str                                       │
╞════════════════════╪══════════════════════════╪═══════════════════════════════════════════╡
│ P2.2               ┆ P2                       ┆ HG00642.m54329U_210524_174516.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG00642.m64076_210516_091844.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG00642.m64076_210520_213355.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG00642.m64076_210522_082905.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG00738.m64043_210530_003337.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG00738.m64043_210531_080529.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG00738.m64043_210601_160048.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG00738.m64136_210602_151340.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01099.m64043_210704_052805.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01099.m64043_210705_162656.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01099.m64043_210707_032602.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01255.m64043_210520_180149.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01255.m64136_210516_022225.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01255.m64136_210519_033858.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01346.m54329U_210624_221223.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG01346.m54329U_210629_024631.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG01346.m64076_210526_105450.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01346.m64076_210621_234241.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01433.m64136_210604_175856.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01433.m64136_210606_025622.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01433.m64136_210607_115559.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01433.m64136_210610_203618.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01496.m64043_210625_184443.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01496.m64043_210627_054642.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01496.m64043_210628_151651.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01884.m54329U_210713_205453.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG01884.m54329U_210716_214728.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG01884.m54329U_210718_084331.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG01943.m64043_210716_230222.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01943.m64043_210718_100009.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01943.m64043_210719_210019.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01981.m64136_210625_184731.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01981.m64136_210627_054246.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01981.m64136_210628_163953.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01993.m64043_210620_041711.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01993.m64043_210622_163331.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG01993.m64043_210624_032817.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02004.m64043_210709_205614.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02004.m64136_210702_183526.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02004.m64136_210704_053041.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02004.m64136_210705_162724.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02027.m64136_210205_190622.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02027.m64136_210207_012053.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02027.m64136_210209_184241.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02027.m64136_210211_010151.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02083.m64136_210317_200525.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02083.m64136_210319_191015.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02083.m64136_210321_022417.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02083.m64136_210323_162524.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02132.m54329U_210627_170630.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02132.m54329U_210704_040110.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02132.m54329U_210705_145805.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02132.m64076_210525_000003.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02280.m64136_210716_230343.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02280.m64136_210718_091611.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02280.m64136_210719_201505.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02293.m54329U_210719_222842.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02293.m54329U_210721_092510.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02293.m64076_210716_220011.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02300.m54329U_210702_182525.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02300.m54329U_210710_123004.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02300.m54329U_210711_215946.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02523.m64043_210506_183430.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02523.m64043_210508_033135.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02523.m64043_210509_110105.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02602.m64043_210612_053030.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02602.m64043_210613_133026.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02602.m64043_210614_223013.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02602.m64043_210618_184604.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02615.m64136_210528_171842.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02615.m64136_210530_004827.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02615.m64136_210531_083342.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02647.m54329U_210604_200442.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02647.m64076_210527_231639.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02647.m64076_210530_192034.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02647.m64076_210601_061523.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02683.m54329U_210707_171722.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02683.m54329U_210709_030038.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG02683.m64076_210703_103644.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02698.m64043_210519_013026.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02698.m64136_210514_184433.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02698.m64136_210517_184202.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02738.m64076_210706_214544.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02738.m64076_210711_102225.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02738.m64076_210714_200553.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG02738.m64076_210718_085619.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03654.m64043_210522_023949.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03654.m64043_210523_101851.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03654.m64043_210524_174752.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03654.m64043_210528_171552.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03669.m64043_210604_175624.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03669.m64043_210606_013256.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03669.m64043_210607_090252.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03669.m64043_210610_203329.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03688.m54329U_210608_221930.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG03688.m54329U_210611_221457.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG03688.m54329U_210618_202343.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG03688.m64076_210610_224207.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03710.m64043_210514_184131.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03710.m64043_210516_020821.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03710.m64043_210517_175123.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03831.m64136_210612_053350.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03831.m64136_210613_130744.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03831.m64136_210614_204240.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03831.m64136_210618_184849.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03927.m54329U_210522_083046.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG03927.m64076_210514_222349.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03927.m64076_210517_210115.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG03927.m64076_210519_075634.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04115.m64076_210623_104349.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04115.m64076_210625_220013.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04115.m64076_210627_085544.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04184.m64076_210701_234028.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04184.m64076_210708_084125.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04184.m64076_210709_232529.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04184.m64076_210712_194121.dc.q20.fast… │
│ P2.2               ┆ P2                       ┆ HG04199.m54329U_210614_155303.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG04199.m54329U_210620_071842.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG04199.m54329U_210621_233920.dc.q20.fas… │
│ P2.2               ┆ P2                       ┆ HG04199.m64076_210613_183806.dc.q20.fast… │
└────────────────────┴──────────────────────────┴───────────────────────────────────────────┘
```

```
┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (47, 3)
┌────────────────────────────────────────────────────────────────────────────┬────────────────────────────────────────────────────────────────────────────┬───────────────────────────────────────────────┐
│ design_description                                                         ┆ design_description_right                                                   ┆ __index__filename                             │
│ ---                                                                        ┆ ---                                                                        ┆ ---                                           │
│ str                                                                        ┆ str                                                                        ┆ str                                           │
╞════════════════════════════════════════════════════════════════════════════╪════════════════════════════════════════════════════════════════════════════╪═══════════════════════════════════════════════╡
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG00642.m54329U_210524_174516.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG00642.m64076_210516_091844.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG00642.m64076_210520_213355.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG00642.m64076_210522_082905.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 24kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG01346.m54329U_210624_221223.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 24kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG01346.m54329U_210629_024631.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 19kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG01346.m64076_210526_105450.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 19kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG01346.m64076_210621_234241.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 18kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG01884.m54329U_210713_205453.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 18kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG01884.m54329U_210716_214728.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 18kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG01884.m54329U_210718_084331.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 26kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02132.m54329U_210627_170630.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 26kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02132.m54329U_210704_040110.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 26kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02132.m54329U_210705_145805.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02132.m64076_210525_000003.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 24kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02293.m54329U_210719_222842.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 24kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02293.m54329U_210721_092510.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 24kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02293.m64076_210716_220011.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02300.m54329U_210702_182525.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02300.m54329U_210710_123004.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02300.m54329U_210711_215946.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 19kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02647.m54329U_210604_200442.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 19kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02647.m64076_210527_231639.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 19kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02647.m64076_210530_192034.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 19kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02647.m64076_210601_061523.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02683.m54329U_210707_171722.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02683.m54329U_210709_030038.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 21kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02683.m64076_210703_103644.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02738.m64076_210706_214544.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02738.m64076_210711_102225.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02738.m64076_210714_200553.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG02738.m64076_210718_085619.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 18kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03688.m54329U_210608_221930.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 18kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03688.m54329U_210611_221457.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 18kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03688.m54329U_210618_202343.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 18kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03688.m64076_210610_224207.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 17kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03927.m54329U_210522_083046.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 17kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03927.m64076_210514_222349.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 17kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03927.m64076_210517_210115.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 17kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG03927.m64076_210519_075634.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 23kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG04115.m64076_210623_104349.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 23kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG04115.m64076_210625_220013.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 23kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG04115.m64076_210627_085544.dc.q20.fastq.gz  │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG04199.m54329U_210614_155303.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG04199.m54329U_210620_071842.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG04199.m54329U_210621_233920.dc.q20.fastq.gz │
│ HiFi sequencing of 20kb fractionated gDNA rebasecalled using DeepConsensus ┆ HiFi sequencing of 22kb fractionated gDNA rebasecalled using DeepConsensus ┆ HG04199.m64076_210613_183806.dc.q20.fastq.gz  │
└────────────────────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────────────────────────────┴───────────────────────────────────────────────┘
```

Validation
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2/DEEPCONSENSUS_v1pt2_submitter_metadata.tsv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2/HPRC_DEEPCONSENSUS_v1pt2_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2/metadata-13754908-processed-ok.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = ['filetype']
overide_csv_with_tsv_in_these_columns = ['filetype']
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```