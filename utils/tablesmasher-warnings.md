## Warnings and summaries from tablesmasher (2025-08-20)
These outputs were pulled from the command line and then slightly cleaned up.

```
Processing ../submissions/HPRC-OmniC-100124Pools/HPRC-OmniC-100124Pools_data_table__final.csv...
WARNING:merge_polars_dataframes:No values in __index__filename are shared across the dataframes -- merge can continue, but no rows in HPRC-OmniC-100124Pools_data_table__final.csv will merge with existing rows in main
[...]
Processing ../submissions/UCSC_HPRC_nanopore_Year2_R10/UCSC_HPRC_nanopore_Year2_R10_data_table__final.csv...
WARNING:merge_polars_dataframes:No values in __index__filename are shared across the dataframes -- merge can continue, but no rows in UCSC_HPRC_nanopore_Year2_R10_data_table__final.csv will merge with existing rows in main
```

```
WARNING: Found 1106 files not referenced in any member of index_sheets -- these files may represent renames, files for future releases, etc...
They will be saved as not_in_index_sheets.tsv
Here's where they came from:
┌───────────────────────────────────────────────────────────────────────────┐
│ collection                                                                │
│ ---                                                                       │
│ struct[2]                                                                 │
╞═══════════════════════════════════════════════════════════════════════════╡
│ {["HPRC-OmniC-100124Pools_data_table__final.csv"],192}                    │
│ {["UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_data_table__final.csv"],187}            │
│ {["UCSC_HPRC_nanopore_Year2_data_table__final.csv"],178}                  │
│ {["UCSC_HPRC_nanopore_Year4_data_table__final.csv"],165}                  │
│ {["UCSC_HPRC_nanopore_Year2_R10_data_table__final.csv"],103}              │
│ {["UW_HPRC_HiFi_Y4_AND_Y3_Topoff_data_table__final.csv"],53}              │
│ {["RU_Y4_data_table__final.csv"],51}                                      │
│ {["WUSTL_HPRC_HiFi_Year4_data_table__final.csv"],48}                      │
│ {["HIC_Y3_Y4_part2_data_table__final.csv"],48}                            │
│ {["HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_data_table__final.csv"],19}       │
│ {["manifest"],18}                                                         │
│ {["HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20_data_table__final.csv"],9}        │
│ {["HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_data_table__final.csv"],9} │
│ {["WUSTL_HPRC_HiFi_Year3_data_table__final.csv"],7}                       │
│ {["HPRC_PLUS_nanopore_misc_R2_data_table__final.csv", "manifest"],5}      │
│ {["manifest", "HPRC_PLUS_nanopore_misc_R2_data_table__final.csv"],4}      │
│ {["RU_Y3_HIFI_data_table__final.csv"],3}                                  │
│ {["HPRC_DEEPCONSENSUS_v1pt2_data_table__final.csv"],3}                    │
│ {["WUSTL_HPRC_HiFi_Year3_TopUp_data_table__final.csv"],2}                 │
│ {["UW_HPRC_HiFi_Y1_data_table__final.csv"],2}                             │
└───────────────────────────────────────────────────────────────────────────┘
All other stats below EXCLUDE these not-in-any-member-of-index_sheets oddities.

For all 6048 files (fqs, bams, etc) within any member of index_sheets:
* 5363 are in working (as of when the index sheets were pulled down from Google Sheets)
  * Of which 5335 made it onto AnVIL
* 4736 have an NCBI SRA accession

The 1312 ones that are in an index_sheet, but do not have an NCBI accession, have these values for production (this might help you find 'collections' that aren't in the HPRC metadata repo or are problematic)
┌───────────────────────────────────────┐
│ production                            │
│ ---                                   │
│ struct[2]                             │
╞═══════════════════════════════════════╡
│ {"add_to_index",706}                  │
│ {null,200}                            │
│ {"WUSTL_HPRC_Y5_Per_Pool_Kinnex",151} │
│ {"UCSC_HPRC_nanopore_Year3",72}       │
│ {"UW_HPRC_Y5_Kinnex",46}              │
│ {"HPRC_AMED",40}                      │
│ {"RU_Y5_Kinnex",28}                   │
│ {"HPRC_REVIO_EA_2023",20}             │
│ {"UCSC_HPRC_PLUS_nanopore_WashU",18}  │
│ {"HPRC_PLUS_nanopore_misc_R2",11}     │
│ {"HPRC_PLUS_GIAB",7}                  │
│ {"HG00733_T2T_UW_HiFi_ONT",5}         │
│ {"TECHNOPOLE_DEEPCONS",4}             │
│ {"HIC_Y3_Y4_part2",2}                 │
│ {"NISC_HiFi_TopUp_2022_with_5mC",2}   │
└───────────────────────────────────────┘
```
