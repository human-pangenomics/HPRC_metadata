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
wrangled_sheets = [
"../submissions/HPRC-OmniC-100124Pools/HPRC-OmniC-100124Pools_data_table__final.csv",
"../submissions/HPRC_DEEPCONSENSUS_v1pt2/HPRC_DEEPCONSENSUS_v1pt2_data_table__final.csv",
"../submissions/RU_Y3_HIFI/RU_Y3_HIFI_data_table__final.csv",
"../submissions/RU_Y2_topoff/RU_Y2_topoff_data_table__final.csv",
"../submissions/UCSC_HPRC_PLUS_nanopore/UCSC_HPRC_PLUS_nanopore_data_table__final.csv",
"../submissions/UW_HPRC_HiFi_Y1/UW_HPRC_HiFi_Y1_data_table__final.csv",
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
# One last thing: You'll need my library Ranchero. Because I'm still playing with its details, Ranchero is
# currently not pip-installable. You will need to `git clone` the entire repo from my (aofarrel) GitHub,
# `pip install -r requirements.txt`, then add Ranchero's path here:
ranchero_path = '/Users/aofarrel/github/Ranchero'
import sys
sys.path.insert(0, ranchero_path) 
import src as Ranchero
Ranchero.Configuration.set_config({"loglevel": 30})

# TODO: allow user to select if they want left or right for conflicts
# NOTE: You can use polars expressions to validate `manifest_s3_source` against `path` but you need to handle nulls properly

import os
import polars as pl
import polars.selectors as cs

Ranchero.Configuration.set_config({"dupe_index_handling": 'verbose_error'})
zeroth_index_sheet = next(iter(index_sheets.items()))
main_index = Ranchero.from_tsv(zeroth_index_sheet[1], index='filename', auto_standardize=False, auto_rancheroize=False)
main_index = main_index.with_columns(pl.lit(zeroth_index_sheet[0]).alias("index_sheet"))
main_index = main_index.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
print(f"Processed {os.path.basename(zeroth_index_sheet[0])} into a {main_index.shape} dataframe")
if len(index_sheets) > 1:
	for sheet_name, sheet_path in list(index_sheets.items())[1:]:
		another_index = Ranchero.from_tsv(sheet_path, index='filename', auto_standardize=False, auto_rancheroize=False)
		another_index = another_index.with_columns(pl.lit(sheet_name).alias("index_sheet"))
		print(f"Processed {sheet_name} into a {another_index.shape} dataframe")
		another_index = another_index.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
		main_index = pl.concat([main_index, another_index], how='align_full')
		main_index = Ranchero.NeighLib.check_index(main_index, df_name='main')
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
	Ranchero.Configuration.set_config({"dupe_index_handling": 'keep_most_data'})
	manifest = Ranchero.from_tsv(manifest_file, delimiter=",", index='filename', auto_standardize=False, auto_rancheroize=False)
	print(f"Processed manifest file into a {manifest.shape} dataframe")
	manifest = Ranchero.NeighLib.check_index(manifest, df_name='manifest')
	main_index = Ranchero.merge_dataframes(main_index, manifest, merge_upon='__index__filename',
		left_name='main', right_name='manifest', 
		fallback_on_left=True) # any disrepencies (which should not happen) will fall back to the main_index
	print(f"Merged main_index with manifest to create an index of shape {main_index.shape}")
	Ranchero.dfprint(main_index.select(['__index__filename', 'accession', 'path', 'manifest_checksum', 'manifest_gs_path']))
	print("Rows without values for manifest_checksum:")
	Ranchero.dfprint(
		main_index.filter(pl.col('manifest_gs_path').is_null())
		.select(Ranchero.NeighLib.valid_cols(main_index, ['__index__filename', 'path', 'index_sheet', 'in_working'])), str_len=200
	)

Ranchero.Configuration.set_config({"dupe_index_handling": 'verbose_error'})
for wrangled_path in wrangled_sheets:
	print(f"Processing {wrangled_path}...")
	this_wrangled_name = os.path.basename(wrangled_path)
	this_wrangled = Ranchero.from_tsv(wrangled_path, delimiter=",", index='filename', auto_standardize=False, auto_rancheroize=False)
	if len(wrangled_vital_columns) != 0:
		this_wrangled = this_wrangled.select(wrangled_vital_columns)
	this_wrangled = this_wrangled.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
	Ranchero.kolumns.list_fallback_or_null = overrides
	Ranchero.kolumns.list_throw_error = [x for x in this_wrangled.columns if x not in overrides]
	main_index = Ranchero.merge_dataframes(main_index, this_wrangled, merge_upon='__index__filename',
		left_name='main', right_name=this_wrangled_name, 
		fallback_on_left=False) # fallbacks (if allowed per kolumns) will fallback on right
	print(f"Merged with {this_wrangled_name}")

print("Finished.")
Ranchero.dfprint(
	main_index.select(Ranchero.NeighLib.valid_cols(main_index, 
		['__index__filename', 'accession', 'path', 'manifest_checksum', 'manifest_gs_path', "index_sheet", "in_working"])))
Ranchero.to_tsv(main_index, "./all_files__all_gs__some_sra.tsv")
Ranchero.to_tsv(main_index.select(Ranchero.NeighLib.valid_cols(main_index, 
		['__index__filename', 'accession', 'path', 'manifest_checksum', 'manifest_gs_path', "index_sheet", "in_working"])),
"./all_files__all_gs__some_sra__less_columns.tsv")

