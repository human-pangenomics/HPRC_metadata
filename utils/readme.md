# HPRC_metadata/utils

This is a dumping ground for data wrangling scripts. To run the python scripts, you're going to need Ash's [Ranchero](https://github.com/aofarrel/ranchero) library. The best way to install it is in a venv:
```
python -m venv ./ashvenv
source ashvenv/bin/activate
pip install ranchero
```
One of Ranchero's prereqs, polars, occasionally changes how it handles null values with new releases. Ranchero relies on consistent handling of nulls, so it attempts to force one specific version of polars upon install, which is why you *really* should use a venv like shown here rather than any other installation method.

### utils/2025-Aug-07_index_files and utils/2025-Aug-11_index_files
R2 index files from the R2 Google Sheets workbook, used by tablesmasher (see below). The date of the folder represents the date I pulled the files from Google Sheets. **Please do not update/replace these files without also updating the datestamp.**

### utils/AnVIL_transfer
See that folder's readme for more information

### utils/SRA_transfer
Scripts/Files relating to the SRA transfer -- please be aware that `did_I_already_put_that_on_SRA.py` may not be completely accurate due to SRA sometimes changing filenames in XML outputs

### utils/boneless_tree.sh
Silly little bash one-liner that mimics `tree` on systems that have coreutils but not `tree` 

### utils/all_files__all_gs__some_sra.tsv
File created by tablesmasher.py (see below). This contains most column fields from metadata fields from AnVIL, index tables from Google Sheets, and the SRA accessions. Due to wrangled metadata fields in this repo being known to have errors that we didn't get around to correcting (due to an urgent need to get SRA accessions merged with the main index data tables; see ../submissions/readme for more info) this doesn't include non-SRA-accession metadata from the wrangled so-called `__final.csv` sheets, although tablesmasher.py has an easy to use option to include those too if you'd like.

### utils/all_files__all_gs__some_sra__less_columns.tsv
File created by tablesmasher.py (see below). This contains only these columns:
* the filename (`__index__filename`)
* SRA accession
* S3 path
* AWS checksum
* AnVIL gs path (as of 2025-08-29, be aware they may be moved to another bucket later)\
* which R2 index google sheet the file is from
* if the file is in working (as of when the R2 index sheets were pulled, which are included in this repo with datestamps)

Note that tablesmasher thinks some of these `__final.csv` files aren't in any of the R2 index sheets!
```
Processing ../submissions/HPRC-OmniC-100124Pools/HPRC-OmniC-100124Pools_data_table__final.csv...
WARNING:merge_polars_dataframes:No values in __index__filename are shared across the dataframes -- merge can continue, but no rows in HPRC-OmniC-100124Pools_data_table__final.csv will merge with existing rows in main
[...]
Processing ../submissions/UCSC_HPRC_nanopore_Year2_R10/UCSC_HPRC_nanopore_Year2_R10_data_table__final.csv...
WARNING:merge_polars_dataframes:No values in __index__filename are shared across the dataframes -- merge can continue, but no rows in UCSC_HPRC_nanopore_Year2_R10_data_table__final.csv will merge with existing rows in main
```

### utils/not-in-index.tsv
Files that tablesmasher found were not in any of the R2 index sheets (see tablesmasher-warnings.md)

### utils/tablesmasher.py
Python script for combining various data tables. Has detailed instructions for running it in the script itself. If you run it as-is without any edits, it will combine the R2 index tables with the `__final.csv` tables (which have SRA accessions) and a manifest file with information from the AnVIL transfers. However, I tried to write the script so it could be useful for future releases too.

### utils/tablesmasher-warnings.md
Relevant output warnings from the last run of tablesmasher (does not update automatically).

### utils/validate_and_combine_per_submission.py (formerly validate_data_tables.py)
This script has eleven lines at the beginning that you'll need to fill in per submission folder you want to validate. Inline comments just below this block explain what each of the eleven lines do. This sounds annoying, but it's worth it, since you usually only need to fill in three of them. In fact, for submissions Ash wrangled, you don't even need to do that -- every submission Ash wrangled has a readme.md file with the first ten lines filled in (the 11th is the path to Ranchero, which will vary per machine) so you can just copy-paste them into the script directly.

This script does two things:
1. Validates that your submission metadata file, your wrangled CSV/TSV, and what ended up on SRA are all correct
2. Combines your wrangled CSV/TSV with SRA accessions to output a `__final.csv` file
The reason why you'll want to use this script instead of adding SRA accessions by hand, besides the data validation, is that it can handle multi-file SRA accessions (Illumina paired reads, those multi-BAMs accessions we did before NCBI told us to stop doing that, etc) when you set `tsv_is_multi_file = True`.

Note that **submissions that contain conflicting metadata will fail this script -- this is intentional!** If you don't care about the conflicts, you'll need to manually handle them using via `allowed_submission_wrangled_conflicts` and/or `allowed_wrangled_NCBI_conflicts`. Note that most submissions already have a few values in those columns -- those are conflicts that Ash thinks are truly inconsequential, most commonly stuff like `PacBio Revio` in the submission CSV turning into just `Revio` in the wrangled CSV.
