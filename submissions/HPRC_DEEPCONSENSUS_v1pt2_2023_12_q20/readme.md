## HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20
Has some issues:
* WashU / UWash inconsistency -- these are different universities in different states
* Conflict in 'study' field indicate that this is HPRC data that got uploaded to the HPRC PLUS BioProject, or maybe vice versa?
* Minor conflict in 'filetype' field (fastq/fastq.gz -- probably inconsequential)


Study conflicts:
```
┏━━━━━━━━━┓
┃conflicts┃
┗━━━━━━━━━┛
shape: (73, 3)
┌───────────┬─────────────┬──────────────────────────────────────────────┐
│ study     ┆ study_right ┆ __index__filename                            │
│ ---       ┆ ---         ┆ ---                                          │
│ str       ┆ str         ┆ str                                          │
╞═══════════╪═════════════╪══════════════════════════════════════════════╡
│ SRP320775 ┆ SRP305758   ┆ HG01109.m64043_200827_191459.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01109.m64043_200829_012836.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01109.m64043_200830_075523.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01243.m64136_200827_191603.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01243.m64136_200829_012933.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01243.m64136_200830_075556.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01442.m64043_201201_182529.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01442.m64136_201122_020702.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG01442.m64136_201125_200625.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02055.m64136_201014_213617.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02055.m64136_201016_205143.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02055.m64136_201018_030620.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02055.m64136_201107_033114.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02080.m64043_200904_190723.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02080.m64043_200906_012211.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02080.m64043_200907_074948.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02109.m64136_200924_175741.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02109.m64136_200928_195239.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02109.m64136_200930_020708.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02145.m64043_200924_175630.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02145.m64043_200928_195132.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02145.m64043_200930_020605.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02145.m64136_201019_093412.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02723.m64043_191221_024136.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02723.m64043_191223_180311.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02723.m64043_191225_001554.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02723.m64043_191226_064057.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02818.m64043_200206_173947.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02818.m64043_200207_235213.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02818.m64043_200209_061852.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02818.m64043_200314_004623.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02818.m64043_200315_071057.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02818.m64043_200316_214923.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02818.m64043_200318_040100.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02970.m64043_200229_115457.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02970.m64043_200306_190054.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02970.m64043_200310_162218.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG02970.m64043_200312_183358.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03098.m64043_201123_083343.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03098.m64043_201128_031055.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03098.m64043_201203_004011.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03486.m64043_200424_162541.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03486.m64043_200425_223840.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03486.m64043_200428_155222.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03486.m64043_200429_220517.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03492.m64136_200904_190830.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03492.m64136_200906_012331.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ HG03492.m64136_200907_075143.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA18906.m64136_200521_171936.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA18906.m64136_200523_195722.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA18906.m64136_200525_021027.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA18906.m64136_200526_083627.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA19030.m64136_200608_190329.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA19030.m64136_200610_011635.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA19030.m64136_200611_074225.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA19240.m64043_200128_181438.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA19240.m64043_200201_000449.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA19240.m64043_200202_062937.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20129.m64043_191227_185626.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20129.m64043_191229_010753.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20129.m64043_191230_073311.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20129.m64043_200111_140530.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20129.m64043_200114_192155.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20300.m64043_191106_155940.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20300.m64043_191109_234157.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20300.m64043_191111_040652.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20300.m64043_191127_131025.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20300.m64043_191128_193532.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA20300.m64043_191130_020028.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA21309.m64043_191210_201113.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA21309.m64043_191213_191857.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA21309.m64043_191215_014401.dc.q20.fastq.gz │
│ SRP320775 ┆ SRP305758   ┆ NA21309.m64043_191219_192900.dc.q20.fastq.gz │
└───────────┴─────────────┴──────────────────────────────────────────────┘
```
Setup:

allow_dupe_run_accessions = False
index = 'filename'
csv = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_data_table.csv'
tsv = '/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/metadata-14735462-processed-ok.tsv'
overide_csv_with_tsv_in_these_columns = [] # if we don't care: ['study', 'filetype']
csv_is_actually_tsv = False

