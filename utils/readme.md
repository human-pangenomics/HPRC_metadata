## HPRC_metadata/utils

This is a dumping ground for data wrangling scripts.


#### boneless_tree.sh
Silly little bash one-liner that mimics `tree` on systems that have coreutils but not `tree` 

#### tablesmasher.py
Python script for combining various data tables. Has detailed instructions for running it in the script itself. If you run it as-is without any edits, it will combine the R2 index tables with the `__final.csv` tables (which have SRA accessions) and a manifest file with information from the AnVIL transfers. However, I tried to write the script so it could be useful for future releases too.

#### validate_and_combine_per_submission.py (formerly validate_data_tables.py)
This script has eleven lines at the beginning that you'll need to fill in per submission folder you want to validate. Inline comments just below this block explain what each of the eleven lines do. This sounds annoying, but it's worth it, since you usually only need to fill in three of them. In fact, for submissions Ash wrangled, you don't even need to do that -- every submission Ash wrangled has a readme.md file with the first ten lines filled in (the 11th is the path to Ranchero, which will vary per machine) so you can just copy-paste them into the script directly.

This script does two things:
1. Validates that your submission metadata file, your wrangled CSV/TSV, and what ended up on SRA are all correct
2. Combines your wrangled CSV/TSV with SRA accessions to output a `__final.csv` file
The reason why you'll want to use this script instead of adding SRA accessions by hand, besides the data validation, is that it can handle multi-file SRA accessions (Illumina paired reads, those multi-BAMs accessions we did before NCBI told us to stop doing that, etc) when you set `tsv_is_multi_file = True`.

Note that **submissions that contain conflicting metadata will fail this script -- this is intentional!** If you don't care about the conflicts, you'll need to manually handle them using via `allowed_submission_wrangled_conflicts` and/or `allowed_wrangled_NCBI_conflicts`. Note that most submissions already have a few values in those columns -- those are conflicts that Ash thinks are truly inconsequential, most commonly stuff like `PacBio Revio` in the submission CSV turning into just `Revio` in the wrangled CSV.