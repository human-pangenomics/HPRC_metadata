 # HPRC_metadata

 This repo stores metadata for various R2 submissions. Ideally, every folder in submissions/ should have:
 * A submission CSV or TSV, sent to us from the submitter
 * A wrangled data table CSV
 * At least one "processed ok" TSV from SRA
 * A `__final.csv` representing the final please-don't-touch-this metadata
 * A folder-level readme.md file with any relevant notes and a few lines that can be copy-pasted into the validator script for an immediate run (see below)

 There is a script in utils/ designed to validate metadata tables from simple column/sample swaps. It uses Ash's ranchero library, which is essentially a wrapper for python-polars. Currently, ranchero cannot be pip installed; you will need to `git clone https://github.com/aofarrel/ranchero.git` in order to import its src/ directory.


## Progress table

✅ = all files uploaded -- done and dusted -- everything should be fine **(for SRA this means n uploaded = n in data table; if n in data table changes this should be revisited)**  
	* check what I wrote in the PR description (there may be minor changes you should be aware of)  
	* pull in the PR   
	* merge the new `*__final.csv` file with your master data table  
🅰️ = all files in data table are uploaded, but there are more files in the AWS tables or submission tables  
	* if you're certain nothing is missing from the data table CSV, consider this equivalent to ✅ (unless another emoji is also present)  
⚠️ = data has metadata issues (if in SRA column, files were still uploaded)   
🟡 = ASH-TODO   
🟠 = partially uploaded to SRA ergo cannot be fully validated  
❓ = pending...  
❌ = file count mismatch that isn't just an AWS or submissions thing / some other kind of annoying blocker  


| collection | validated | SRA | n AWS | n sub | n SRA | notes | issues | final |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| HIC_Y3_Y4_part2 | ❌ | 🟠🟡 |  |  | Corrupt files were uploaded that should be removed from AWS working and AnVIL (see readme) | | |
| HPRC-OmniC-100124Pools | 🟠 | 🟠 | 191 | 96 | 60 | **BioSample issues; see readme** | Omni-C/Hi-C conflict | HPRC-OmniC-100124Pools_data_table__final.csv |
| HPRC-OmniC-100129Pools | ❓ | 🟠🟡 |  |  |  | Contain samples that require new BioSamples |  | |
| HPRC-OmniC-241217Pools | ❓ | 🟠🟡 |  |  |  | Contain samples that require new BioSamples |  | |
| HPRC_DEEPCONSENSUS_v1pt2 | ⚠️ | ⚠️ | 132 | 132 | 132 | metadata conflicts: size_selection, design_description, polymerase_version | HPRC_DEEPCONSENSUS_v1pt2_data_table__final.csv |
| HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20 | ❌ | ❌ |  |  |  | Some files may have been added incorrectly to SRA and should be rescinded |  | |
| HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20 | ⚠️ | ⚠️ | 197 | 197 | 197 | **May have been uploaded to the wrong BioProject** | conflicts: study, notes, library ID | HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_data_table__final.csv |
| HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run | 🅰️ | ✅ | 151 | 151 | 151 | Submitter metadata was 195 files | - | HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_data_table__final |
| HPRC_PLUS_nanopore_misc_R2 | 🅰️ | ✅ | 105 | 38 | 38 | - | **HG00733 was at one point given the wrong BioSample -- verify it was not sample-swapped** | HPRC_PLUS_nanopore_misc_R2_data_table__final.csv |
| RU_Y2_HIFI | 🅰️ | ✅ | 128 | 36 | 24 | Had an existing README.md with some notes, is that important? | - | RU_Y2_HIFI_data_table__final.csv |
| RU_Y2_topoff | 🅰️ | ✅ | 29 | 56 | 7 | - | - | RU_Y2_topoff__final.csv |
| RU_Y3_HIFI (RU_Y3?) | ❌ | ✅ | 94 | 95?! | - | Found file in wrangled CSV that's not in submitted CSV | | |
| RU_Y3_topoff | - | - | - | - | - | **Superceeded by RU_Y3_topoff_redo** | - | - |
| RU_Y3_topoff_redo | ❌ | ❌ |  |  | Has the wrong data table CSV (same as the one in RU_Y3_topoff). Cannot validate until that's fixed. | | |
| RU_Y4 | ⚠️🅰️ | ⚠️ | 192 | 96 | - |  | 'FIBERSEQ' got dropped from notes column | |
| RU_Y5_Kinnex | - | - | - | - | - | Deprioritized due to being transcriptomic | - | - |
| UCSC_HPRC_AMED_collaboration | ✅ | ✅ | 44 | 44 | Ensure library_ID has `NA` names, not `GM` names | UCSC_HPRC_AMED_collaboration_data_table__final.csv | |
| UCSC_HPRC_nanopore_Year2 | ❌ | ⚠️ |  |  | Blocked by file count mismatch and metadata conflict | | |
| UCSC_HPRC_nanopore_Year2_R10 | ❌ | ⚠️🅰️ |  |  | Blocked by metadata conflict | | |
| UCSC_HPRC_nanopore_Year3 | ❌ | ⚠️ |  |  | Blocked by file count mismatch | | |
| UCSC_HPRC_nanopore_Year4 | ✅ | ✅ | 388 | 388 | AWS transfer seems to be missing some files | UCSC_HPRC_nanopore_Year4_data_table__final.csv | |
| UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6 | 🅰️ | ✅ | 374 | 374 | Data table is missing >100 files, but we have a submission file for them. Ensure that our final data table is not missing these samples! |  | |
| UCSC_HPRC_PLUS_nanopore | ⚠️ | ⚠️ | 129 | 43 | 43 |  design_description | UCSC_HPRC_PLUS_nanopore_data_table__final.csv |
| UCSC_HPRC_PLUS_nanopore_WashU | ❌ | ❓ |  |  |  | |
| UW_HPRC_HiFi_Y1 | ❌ | ⚠️ |  |  | File count mismatch | | |
| UW_HPRC_HiFi_Y2 | ❌ | 🅰️ |  |  | | **might be double-uploaded** | UW_HPRC_HiFi_Y2_data_table__final.csv |
| UW_HPRC_HiFi_Y3 | ❌ | ⚠️🅰️ | 278 | 91 | 91 | possible SRA name change but now I don't think so | | |
| UW_HPRC_HiFi_Y4_AND_Y3_Topoff | 🅰️ | ✅ | 848 | 212 | Massive file count mismatch |  | UW_HPRC_HiFi_Y4_AND_Y3_Topoff_data_table__final.csv |
| UW_HPRC_Y5_Kinnex | - | - | 94 | - | Deprioritized due to being transcriptomic | | |
| WUSTL_HPRC_HiFi_Year1 | ❌ | ✅ | 160 | 80 | 80 | **Subreads were submitted to SRA, see readme** | not checked, see readme | WUSTL_HPRC_HiFi_Year1_post_sra_metadata__NOT_SUBREADS.tsv |
| WUSTL_HPRC_HiFi_Year1_TopUp | ✅ | ✅ | 72 | 36 | 36 |36 | - | - | WUSTL_HPRC_HiFi_Year1_TopUp_data_table__final.csv | 
| WUSTL_HPRC_HiFi_Year2 | 🅰️ | ⚠️ | 178 | 89 | 89 | had a sus post_sra TSV, decided to ignore it | **`ccs_algorithm` goes from 6.0.0 to what looks like a boneless DOI; was a column shifted?** also issues in polymerase_version and notes | WUSTL_HPRC_HiFi_Year2_data_table__final.csv |
| WUSTL_HPRC_HiFi_Year2_TopUp | ✅ | ✅ | 110 | 55 | 55 | - | - | WUSTL_HPRC_HiFi_Year2_TopUp/WUSTL_HPRC_HiFi_Year2_TopUp_data_table__final.csv |
| WUSTL_HPRC_HiFi_Year3 | ❓ | ❓ |  |  |  | Seems to have been a name change when uploaded to SRA? | | |
| WUSTL_HPRC_HiFi_Year3_TopUp | ✅ | ✅ | 102 | 51 | 51 | libray IDs were changed | - | WUSTL_HPRC_HiFi_Year3_TopUp/WUSTL_HPRC_HiFi_Year3_TopUp_data_table__final.csv |
| WUSTL_HPRC_HiFi_Year4 | 🅰️ | ✅ | 195 | 97 | 97 | library IDs were changed | - | WUSTL_HPRC_HiFi_Year4_data_table__final.csv |
| WUSTL_HPRC_Y5_Kinnex (WUSTL_HPRC_Y5_Per_Pool_Kinnex?) | ❓ | ❓ |  |  |  | | |

## Should be removed from SRA/AnVIL
* HIC_Y3_Y4_part2's corrupt files (not on SRA but likely on AnVIL)
* some files from HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20
* WUSTL_HPRC_HiFi_Year1 subreads
	* Alternatively we could just leave them up on SRA? They are correctly marked as subreads in the title field...
* Possible duplicate uploads?

## Missing
Known R2 projects not in repo (not exhaustive):
* HiC (all of these ones seem to already be on SRA)
* add_to_index -- Ivo will add a new folder for this batch
* HG00733_T2T_UW_HiFi_ONT
* HPRC_REVIO_EA_2023
* NISC_HiFi_TopUp_2022_with_5mC

## Metadata conflict handling
Inconsistenies we truly do not care about:
* Basically equivalent instrument models like "PacBio Revio" becoming "Revio"

Overrides:
* polymerase_version

Null-fill:
* notes

