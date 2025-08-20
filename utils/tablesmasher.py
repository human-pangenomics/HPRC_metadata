# TABLESMASHER (ノಠ益ಠ)ノ彡┻━┻

# This script is used to merge the following files:
# 1) index_sheets: Any arbitrary number of TSVs from Google Sheets, each with a `filename` column
#    ---> In our case, that is a bunch of "WORKING R2 Sequencing Data Index" sheets (dc, hic, hifi, kinndex, ont, ill)
#    ---> All values for `filename` must be unique across all `index_sheets` (script will throw err if dupes detected)
# (This is a Python dictionary where the key is a shorthand unique name for a sheet and the value is its path)
index_sheets = {
"dc": "./2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - dc.tsv",
"hic": "./2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - hic.tsv",
"hifi": "./2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - hifi.tsv",
"kinnex": "./2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - kinnex.tsv",
"ont": "./2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - ont.tsv",
"ill": "./2025-Aug-11_index_files/WORKING R2 Sequencing Data Index - ill.tsv"
}
# 2) manifest_file: One concatenated manifest CSV, which also has a `filename` column
#    ---> In our case, that is a concatenation of summary information I gathered from the AnVIL file transfers
manifest_file = "./AnVIL_transfer/logs_and_manifests/manifests_2025-08-12.csv"
# 3) wrangled_sheets: Any arbitrary number of CSVs with other metadata, each with a `filename` column
#    ---> In our case, these are the `__final.csv` files I made with corrected metadata and SRA accessions
#    ---> All values for `filename` must be unique across all `wrangled_sheets` (script will throw err if dupes detected)
# NOTE: THIS CURRENTLY INCLUDES SHEETS WITH METADATA THAT IS NOT VALIDATED, because we decided to deprioritize
# metadata validation in favor of just getting SRA IDs processed.
wrangled_sheets = [
"../submissions/HIC_Y3_Y4_part2/HIC_Y3_Y4_part2_data_table__final.csv",
"../submissions/HPRC-OmniC-100124Pools/HPRC-OmniC-100124Pools_data_table__final.csv",
# Skipped: HPRC-OmniC-100129Pools
# Skipped: HPRC-OmniC-241217Pools
"../submissions/HPRC_DEEPCONSENSUS_v1pt2/HPRC_DEEPCONSENSUS_v1pt2_data_table__final.csv",
"../submissions/HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20/HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20_data_table__final.csv",
"../submissions/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20/HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_data_table__final.csv",
"../submissions/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run/HPRC_DEEPCONSENSUS_v1pt2_2024_02_q20_re-run_data_table__final.csv",
"../submissions/HPRC_PLUS_nanopore_misc_R2/HPRC_PLUS_nanopore_misc_R2_data_table__final.csv",
"../submissions/RU_Y2_HIFI/RU_Y2_HIFI_data_table__final.csv",
"../submissions/RU_Y2_topoff/RU_Y2_topoff_data_table__final.csv",
"../submissions/RU_Y3_HIFI/RU_Y3_HIFI_data_table__final.csv",
# Skipped: RU_Y3_topoff_redo
"../submissions/RU_Y4/RU_Y4_data_table__final.csv",
# Skipped: RU_Y5_Kinnex
"../submissions/UCSC_HPRC_AMED_collaboration/UCSC_HPRC_AMED_collaboration_data_table__final.csv",
"../submissions/UCSC_HPRC_nanopore_Year2/UCSC_HPRC_nanopore_Year2_data_table__final.csv",
"../submissions/UCSC_HPRC_nanopore_Year2_R10/UCSC_HPRC_nanopore_Year2_R10_data_table__final.csv",
# Skipped: UCSC_HPRC_nanopore_Year3
"../submissions/UCSC_HPRC_nanopore_Year4/UCSC_HPRC_nanopore_Year4_data_table__final.csv",
"../submissions/UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6/UCSC_HPRC_ONT_Y1_WTOPUP_GUPPY6_data_table__final.csv",
"../submissions/UCSC_HPRC_PLUS_nanopore/UCSC_HPRC_PLUS_nanopore_data_table__final.csv",
# Skipped: UCSC_HPRC_PLUS_nanopore_WashU
"../submissions/UW_HPRC_HiFi_Y1/UW_HPRC_HiFi_Y1_data_table__final.csv",
#"../submissions/UW_HPRC_HiFi_Y2/UW_HPRC_HiFi_Y2_data_table__final.csv", --> has dupes??
"../submissions/UW_HPRC_HiFi_Y3/UW_HPRC_HiFi_Y3_data_table__final.csv",
"../submissions/UW_HPRC_HiFi_Y4_AND_Y3_Topoff/UW_HPRC_HiFi_Y4_AND_Y3_Topoff_data_table__final.csv",
# Skipped: UW_HPRC_Y5_Kinnex
"../submissions/WUSTL_HPRC_HiFi_Year1/WUSTL_HPRC_HiFi_Year1_post_sra_metadata__NOT_SUBREADS.csv",
"../submissions/WUSTL_HPRC_HiFi_Year1_TopUp/WUSTL_HPRC_HiFi_Year1_TopUp_data_table__final.csv",
"../submissions/WUSTL_HPRC_HiFi_Year2/WUSTL_HPRC_HiFi_Year2_data_table__final.csv",
"../submissions/WUSTL_HPRC_HiFi_Year2_TopUp/WUSTL_HPRC_HiFi_Year2_TopUp_data_table__final.csv",
"../submissions/WUSTL_HPRC_HiFi_Year3/WUSTL_HPRC_HiFi_Year3_data_table__final.csv",
"../submissions/WUSTL_HPRC_HiFi_Year3_TopUp/WUSTL_HPRC_HiFi_Year3_TopUp_data_table__final.csv",
"../submissions/WUSTL_HPRC_HiFi_Year4/WUSTL_HPRC_HiFi_Year4_data_table__final.csv"
# Skipped: WUSTL_HPRC_Y5_Kinnex
]
#
# The output will be a single TSV with merged information from all three of these sources, using these rules:
# a) All files were be merged upon the `filename` column (at runtime, renamed to `__index__filename`)
# b) Any columns that are in both `manifest` and any `index_sheet` will be ignored -- that is to say, it will not be
# checked, it will not be overwritten, it will just remain whatever it was in `index_sheets`. 
# c) Any non-`filename` columns shared between any member of `index_sheets` and any member of `wrangled_sheets` will
# be nullfilled. If there are actual data conflicts, the script will throw an error and tell you what the conflicts are,
# unless the conflict is in `overrides`...
overrides = ['filetype']
# ...or you set `wrangled_vital_columns` to a non-empty value, in which case, only THOSE columns are considered
# for conflicts. This is for people who do not actually want to validate data and just want to merge stuff quickly.
wrangled_vital_columns = ['accession', 'sample_ID'] # don't include `filename` here!
wrangled_vital_columns.append('__index__filename')  # don't touch this line!!
#
# One last thing: You'll need my library ranchero, via `pip install ranchero` (preferably in a venv)
try:
	import ranchero
except ImportError:
	print("Could not import ranchero. Please pip install it!")

ranchero.Configuration.set_config({"loglevel": 30})

# TODO: allow user to select if they want left or right for conflicts
# NOTE: You can use polars expressions to validate `manifest_s3_source` against `path` but you need to handle nulls properly

import os
import polars as pl
import polars.selectors as cs

ranchero.Configuration.set_config({"dupe_index_handling": 'verbose_error'})
zeroth_index_sheet = next(iter(index_sheets.items()))
main_index = ranchero.from_tsv(zeroth_index_sheet[1], index='filename', auto_standardize=False, auto_rancheroize=False)
main_index = main_index.with_columns(pl.lit(zeroth_index_sheet[0]).alias("index_sheet"))
main_index = main_index.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
print(f"Processed {os.path.basename(zeroth_index_sheet[0])} into a {main_index.shape} dataframe")
if len(index_sheets) > 1:
	for sheet_name, sheet_path in list(index_sheets.items())[1:]:
		another_index = ranchero.from_tsv(sheet_path, index='filename', auto_standardize=False, auto_rancheroize=False)
		another_index = another_index.with_columns(pl.lit(sheet_name).alias("index_sheet"))
		print(f"Processed {sheet_name} into a {another_index.shape} dataframe")
		another_index = another_index.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
		main_index = pl.concat([main_index, another_index], how='align_full')
		main_index = ranchero.NeighLib.check_index(main_index, df_name='main')
print(f"Combined all index_sheets into a {main_index.shape} dataframe.")
if 'path' in main_index.columns:
	main_index = main_index.with_columns(
		pl.when(pl.col('path').str.contains("s3://human-pangenomics/working"))
		.then(True)
		.otherwise(False)
		.alias('in_working'))
	in_working = main_index.filter(pl.col('in_working'))
	print(f"Out of {main_index.shape[0]} files, {in_working.shape[0]} are in working")

if manifest_file is not None:
	ranchero.Configuration.set_config({"dupe_index_handling": 'keep_most_data'})
	manifest = ranchero.from_tsv(manifest_file, delimiter=",", index='filename', auto_standardize=False, auto_rancheroize=False)
	print(f"Processed manifest file into a {manifest.shape} dataframe")
	manifest = ranchero.NeighLib.check_index(manifest, df_name='manifest')
	main_index = ranchero.merge_dataframes(main_index, manifest, merge_upon='__index__filename',
		left_name='main', right_name='manifest', 
		fallback_on_left=True) # any disrepencies (which should not happen) will fall back to the main_index
	print(f"Merged main_index with manifest to create an index of shape {main_index.shape}")
	ranchero.dfprint(main_index.select(['__index__filename', 'accession', 'path', 'manifest_checksum', 'manifest_gs_path']))
	print("Rows without values for manifest_checksum:")
	ranchero.dfprint(
		main_index.filter(pl.col('manifest_gs_path').is_null())
		.select(ranchero.NeighLib.valid_cols(main_index, ['__index__filename', 'path', 'index_sheet', 'in_working'])), str_len=200
	)

ranchero.Configuration.set_config({"dupe_index_handling": 'verbose_error'})
for wrangled_path in wrangled_sheets:
	print(f"Processing {wrangled_path}...")
	this_wrangled_name = os.path.basename(wrangled_path)
	this_wrangled = ranchero.from_tsv(wrangled_path, delimiter=",", index='filename', auto_standardize=False, auto_rancheroize=False)
	if len(wrangled_vital_columns) != 0:
		this_wrangled = this_wrangled.select(wrangled_vital_columns)
	this_wrangled = this_wrangled.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
	ranchero.kolumns.list_fallback_or_null = overrides
	ranchero.kolumns.list_throw_error = [x for x in this_wrangled.columns if x not in overrides]
	main_index = ranchero.merge_dataframes(main_index, this_wrangled, merge_upon='__index__filename',
		left_name='main', right_name=this_wrangled_name, 
		fallback_on_left=False) # fallbacks (if allowed per kolumns) will fallback on right
	print(f"Merged with {this_wrangled_name}")

print("Final dataframe (truncated in this view):")
ranchero.dfprint(
	main_index.select(ranchero.NeighLib.valid_cols(main_index, 
		['__index__filename', 'accession', 'path', 'manifest_checksum', 'manifest_gs_path', "index_sheet", "in_working"])))
ranchero.to_tsv(main_index, "./all_files__all_gs__some_sra.tsv")
ranchero.to_tsv(main_index.select(ranchero.NeighLib.valid_cols(main_index, 
		['__index__filename', 'accession', 'path', 'manifest_checksum', 'manifest_gs_path', "index_sheet", "in_working"])),
"./all_files__all_gs__some_sra__less_columns.tsv")
print("\n\nStats:")
pl.Config.set_tbl_hide_dataframe_shape(True)
in_any_index_sheet = main_index.filter(pl.col('index_sheet').is_not_null())
not_in_any_index_sheet = main_index.filter(pl.col('index_sheet').is_null())

if not_in_any_index_sheet.shape[0] > 0:
        print(f"WARNING: Found {not_in_any_index_sheet.shape[0]} files not referenced in any member of index_sheets -- these files may represent renames, files for future releases, etc...")
        print("They will be saved as not_in_index_sheets.tsv")
        print("Here's where they came from:")
        ranchero.dfprint(not_in_any_index_sheet.select(pl.col('collection').value_counts(sort=True)), rows=500, str_len=150, width=160)
        ranchero.to_tsv(not_in_any_index_sheet, "./not_in_any_index_sheet.tsv")
        print("All other stats below EXCLUDE these not-in-any-member-of-index_sheets oddities.")
print(f"For all {in_any_index_sheet.shape[0]} files (fqs, bams, etc) within any member of index_sheets:")
print(f"* {in_any_index_sheet.filter(pl.col('in_working')).shape[0]} are in working (as of when the index sheets were pulled down from Google Sheets)")
print(f"  * Of which {in_any_index_sheet.filter(pl.col('in_working')).filter(pl.col('manifest_gs_path').is_not_null()).shape[0]} made it onto AnVIL")
print(f"* {in_any_index_sheet.filter(pl.col('accession').is_not_null()).shape[0]} have an NCBI SRA accession")
no_ncbi_accession = in_any_index_sheet.filter(pl.col('accession').is_null())
if 'production' in no_ncbi_accession.columns:
        print(f"The {no_ncbi_accession.shape[0]} ones that are in an index_sheet, but do not have an NCBI accession, have these values for production (this might help you find 'collections' that aren't in the HPRC metadata repo or are problematic)")
        ranchero.dfprint(no_ncbi_accession.select(pl.col("production").value_counts(sort=True)), rows=500, str_len=150, width=160)
print("Finished.")

