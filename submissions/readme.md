 
✅ = all files uploaded
⚠️ = all files in data table uploaded, but AWS table has more files  
🟡 = partially uploaded, full upload may or may not be blocked (the TODO emoji)  
🟠 = ready for a upload (partial or full) but not doing that yet due to R3/lack of BioSamples
❓ = inconsistencies make confirming status difficult  
❌ = issues with data fully block an upload

filewise_readme has consistent format:
* TSV
* sample_ID, filename, accession

| collection | release | SRA | AnVIL | project | filewise_readme
| --- | --- | --- | --- | --- |
| HIC_Y3_Y4_part2 | R2 | ❓ |  | - |  |
| HPRC-OmniC-100124Pools | R3? | 🟠 |  |  | n/a |
| HPRC-OmniC-100129Pools | R3? | 🟠 |  |  | n/a |
| HPRC-OmniC-241217Pools | R3? | 🟠 |  |  | n/a |
| HPRC_DEEPCONSENSUS_v1pt2 | R2 | ✅ |  |  | ✅ |
| HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20 | R2 | ⚠️ |  |  | ✅ |
| HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20 | R2 | ✅ |  |  | ✅ |
| HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run | R2 | ✅ |  |  | ✅ |
| HPRC_PLUS_nanopore_misc_R2 | R2 | ✅ |  | PLUS | ✅ |
| RU_Y2_HIFI | R2 | ⚠️ |  |  | ✅ |
| RU_Y2_topoff | R2 | ⚠️ |  |  | ✅ |
| RU_Y3_HIFI (RU_Y3?) | R2? | ✅ |  |  | ✅ |
| RU_Y3_topoff_redo | R2 | ✅ |  |  | ✅ |
| RU_Y4 | R2 | ✅ |  |  | ✅ |
| RU_Y5_Kinnex | R2 | 🟠 |  |  | n/a |
| UCSC_HPRC_AMED_collaboration | R2 | ✅ |  | PLUS | ✅ |
| UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6 | R3? | ❓ |  |  |  |
| UCSC_HPRC_PLUS_nanopore | R2 | ⚠️ |  | PLUS | ✅ |
| UCSC_HPRC_PLUS_nanopore_WashU | R2 | ❓ |  | PLUS |  |
| UCSC_HPRC_nanopore_Year2 | R2 | ✅ |  |  | ✅ |
| UCSC_HPRC_nanopore_Year2_R10 | R3? | ⚠️ |  |  | ✅ |
| UCSC_HPRC_nanopore_Year3 | R2 | ❓ |  |  |  |
| UCSC_HPRC_nanopore_Year4 | R2 | ❓ |  |  | ✅ |
| UW_HPRC_HiFi_Y1 | R2 | ❓ |  |  |  |
| UW_HPRC_HiFi_Y2 | R2 | ⚠️ |  |  | ✅ |
| UW_HPRC_HiFi_Y3 | R2 | ⚠️ |  |  | ✅ |
| UW_HPRC_HiFi_Y4_AND_Y3_Topoff | R2 | ❓ |  |  |  |
| UW_HPRC_Y5_Kinnex | R2 | ❌ |  |  |  |
| WUSTL_HPRC_HiFi_Year1 | R2 | ❓ |  |  |  |
| WUSTL_HPRC_HiFi_Year1_TopUp | R2 | ❓ |  |  |  |
| WUSTL_HPRC_HiFi_Year2 | R2 | ❓ |  |  |  |
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
