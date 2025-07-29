 

✅ = all files uploaded -- done and dusted -- everything should be fine
	* check what I wrote in the PR description (there may be minor changes you should be aware of)
	* pull in the PR 
	* merge the new `*_updated.csv` file with your master data table
🅰️ = all files in data table are uploaded, but there are more files in the AWS tables
	* if you're certain nothing is missing from the data table CSV, consider this equivalent to ✅ (unless another emoji is also present)
⚠️ = conflicting/corrupt data exists -- **requires input before merging**
🟡 = partially uploaded, full upload may or may not be blocked (the TODO emoji)  
🟠 = ready for a upload (partial or full) but not doing that yet due to R3/lack of BioSamples
❓ = inconsistencies make confirming status difficult  
❌ = issues with data fully block an upload


| collection | release | SRA | AnVIL | project | updated_csv
| --- | --- | --- | --- | --- |
| HIC_Y3_Y4_part2 | R2 | ❌ |  | - | Not uploaded due to corrupt files (SUB15335177) |
| HPRC-OmniC-100124Pools | R3? | 🟠 |  |  | n/a |
| HPRC-OmniC-100129Pools | R3? | 🟠 |  |  | n/a |
| HPRC-OmniC-241217Pools | R3? | 🟠 |  |  | n/a |
| HPRC_DEEPCONSENSUS_v1pt2 | R2 | ⚠️ |  |  | Blocked by metadata conflict |
| HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20 | R2 | ⚠️ |  |  | Blocked by file count mismatch (not merely AWS, see PR) |
| HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20 | R2 | ⚠️ |  |  | Blocked by metadata conflict |
| HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run | R2 | ⚠️ |  |  | Blocked by metadata inconsistency |
| HPRC_PLUS_nanopore_misc_R2 | R2 | ✅ |  | PLUS | HPRC_PLUS_nanopore_misc_R2_data_table__final.csv |
| RU_Y2_HIFI | R2 | ⚠️ |  |  | RU_Y2_HIFI_data_table__final.csv |
| RU_Y2_topoff | R2 | ✅ |  |  | RU_Y2_topoff__final.csv |
| RU_Y3_HIFI (RU_Y3?) | R2? | ⚠️ |  |  | Blocked by file count mismtach (see PR) |
| RU_Y3_topoff_redo | R2 | ⚠️ |  |  | Blocked by metadata conflict |
| RU_Y4 | R2 | ✅ |  |  | Assuming Fiberseq note doesn't matter, RU_Y4_data_table__final.csv |
| RU_Y5_Kinnex | R2 | 🟠 |  |  | n/a |
| UCSC_HPRC_AMED_collaboration | R2 | ✅ |  | PLUS | UCSC_HPRC_AMED_collaboration_data_table__final.csv |




# need further double-checking, previous status stands at
| collection | release | SRA | AnVIL | project | updated_csv
| --- | --- | --- | --- | --- |

| UCSC_HPRC_nanopore_Year2 | R2 | ✅ |  |  | ✅ |
| UCSC_HPRC_nanopore_Year2_R10 | R3? | ⚠️ |  |  | ✅ |
| UCSC_HPRC_nanopore_Year3 | R2 | ❓ |  |  |  |
| UCSC_HPRC_nanopore_Year4 | R2 | ❓ |  |  | ✅ |

| UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6 | R3? | ❓ |  |  |  |
| UCSC_HPRC_PLUS_nanopore | R2 | ⚠️ |  | PLUS | ✅ |
| UCSC_HPRC_PLUS_nanopore_WashU | R2 | ❓ |  | PLUS |  |

| UW_HPRC_HiFi_Y1 | R2 | ❓ |  |  |  |
| UW_HPRC_HiFi_Y2 | R2 | ⚠️ |  |  | ✅ |
| UW_HPRC_HiFi_Y3 | R2 | ⚠️🅰️ |  |  | Blocked by metadata conflict & AWS mismatch |
| UW_HPRC_HiFi_Y4_AND_Y3_Topoff | R2 | ❓ |  |  |  |
| UW_HPRC_Y5_Kinnex | R2 | ❌ |  |  |  |
| WUSTL_HPRC_HiFi_Year1 | R2 | ❓ |  |  |  |
| WUSTL_HPRC_HiFi_Year1_TopUp | R2 | ❓ |  |  |  |
| WUSTL_HPRC_HiFi_Year2 | R2 | ⚠️🅰️ |  |  | Blocked by metadata conflict & AWS mismatch |
| WUSTL_HPRC_HiFi_Year2_TopUp | R2 | ❓|  |  |  |
| WUSTL_HPRC_HiFi_Year3 | R2 | ❓ |  |  |  |
| WUSTL_HPRC_HiFi_Year3_TopUp | R2 | ❓ |  |  |  |
| WUSTL_HPRC_HiFi_Year4 | R2 | ❓ |  |  |  |
| WUSTL_HPRC_Y5_Kinnex (WUSTL_HPRC_Y5_Per_Pool_Kinnex?) | R2? | ❓ |  |  |  |


Known R2 projects not in repo (not exhaustive):
* HiC (all of these ones seem to already be on SRA)
* add_to_index
* HG00733_T2T_UW_HiFi_ONT
* HPRC_REVIO_EA_2023
* NISC_HiFi_TopUp_2022_with_5mC


Inconsistenies we truly do not care about:
* Basically equivalent instrument models like "PacBio Revio" becoming "Revio"
