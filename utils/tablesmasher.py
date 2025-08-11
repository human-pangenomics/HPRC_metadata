# This !unfinished! script has the rather ambitious goal of merging our HPRC index tables (the ones from Google Sheets)
# with information from this repo, most notably SRR IDs but also any corrections... without just overriding
# every difference we find, since what's in this repo might actually be less correct!
#
# To that end, this script will report differences where it finds them. As such you'll probably need to
# run it multiple times, adding to the following lists that will be used to determine which data
# is correct. Although designed for R2 data, this will work any arbitrary dataset.
#
# First of all: You'll need my library Ranchero. Because I'm still playing with its details, Ranchero is
# currently not pip-installable. You will need to `git clone` the entire repo from my (aofarrel) GitHub,
# `pip install -r requirements.txt`, then add Ranchero's path here:
ranchero_path = '/Users/aofarrel/github/Ranchero'
import sys
sys.path.insert(0, ranchero_path) 
import src as Ranchero
#
# Now, put the path of your sheets from the Google Sheets/Excel. They must be in TSV format. Since there's
# likely several, we're gonna hardcode them rather than have you pass a bunch of args. All of these files must
# have a "filename" column, and there can be no duplicates in the "filename" column across any index_sheets.
# They will be combined into one big index called main_index.
index_sheets = [
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - dc.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - hic.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - hifi.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - kinnex.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - ont.tsv"
]
#
# This file is also keyed by filename. It has columns that are not in index_sheets that should be added to index_sheets.
# Any columns that are in both `manifest` and any `index_sheet` will be ignored -- that is to say, it will not be
# checked, it will not be overwritten, it will just remain whatever it was in `index_sheets`. Also, it's expected
# to be a CSV file, not a TSV file!
manifest_file = "/Users/aofarrel/github/HPRC_metadata/utils/AnVIL_transfer/logs_and_manifests/manifests_2025-07-14.csv"
#
# Here are the sheets we're combining with. These are currently hardcoded with the `__final.csv` files
# from this repo but you can put whatever here. Doesn't matter if they're split by sequencing tech or
# collection or submission ID or whatever; we're smashing everything into one megatable. Even if this
# means some rows aren't relevant to some samples.
wrangled_sheets = [
"/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2/HPRC_DEEPCONSENSUS_v1pt2_data_table__final.csv",
"/Users/aofarrel/github/HPRC_metadata/submissions/HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20/HPRC_DEEPCONSENSUS_v1pt2_2023_08_q20__final.tsv",
"/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y2_topoff/RU_Y2_topoff_data_table__final.csv",
"/Users/aofarrel/github/HPRC_metadata/submissions/UW_HPRC_HiFi_Y1/UW_HPRC_HiFi_Y1_data_table__final.csv",
]

# Columns that you want to always have the main_index override the wrangled sheet
overrides = ['filetype']


import os
import polars as pl
import polars.selectors as cs

main_index = Ranchero.from_tsv(index_sheets[0], index='filename', auto_standardize=False, auto_rancheroize=False)
main_index = main_index.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
print(f"Processed {os.path.basename(index_sheets[0])} into a {main_index.shape} dataframe with columns {main_index.columns}")
if len(index_sheets) > 1:
	for sheet_path in index_sheets[1:]:
		another_index = Ranchero.from_tsv(sheet_path, index='filename', auto_standardize=False, auto_rancheroize=False)
		print(f"Processed {os.path.basename(sheet_path)} into a {another_index.shape} dataframe with columns {another_index.columns}")
		another_index = another_index.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
		main_index = pl.concat([main_index, another_index], how='align_full')
		main_index = Ranchero.NeighLib.check_index(main_index)
print(f"Combined all index_sheets into a {main_index.shape} dataframe:")
print(main_index)

if manifest_file is not None:
	manifest = Ranchero.from_tsv(manifest_file, delimiter=",", index='filename', auto_standardize=False, auto_rancheroize=False)
	print(f"Processed manifest file into a {manifest.shape} dataframe")
	manifest = manifest.select(['__index__filename', list(x for x in manifest.columns if x not in main_index.columns)])
	print(f"After removing shared columns (except filename), manifest dataframe is now {manifest.shape}")
	main_index = Ranchero.merge_dataframes(main_index, manifest, merge_upon='__index__filename',
		left_name='main', right_name='manifest', 
		fallback_on_left=True) # any disrepencies (which should not happen) will fall back to the main_index
	print(f"Merged main_index with manifest to create an index of shape {main_index.shape}")
	print(main_index)


for wrangled_path in wrangled_sheets:
	this_wrangled_name = os.path.basename(wrangled_path)
	this_wrangled = Ranchero.from_tsv(wrangled_path, delimiter=",", index='filename', auto_standardize=False, auto_rancheroize=False)
	this_wrangled = this_wrangled.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
	Ranchero.kolumns.list_fallback_or_null = overrides
	Ranchero.kolumns.list_throw_error = [x for x in this_wrangled.columns if x not in overrides]
	main_index = Ranchero.merge_dataframes(main_index, this_wrangled, merge_upon='__index__filename',
		left_name='main', right_name=this_wrangled_name, 
		fallback_on_left=False) # fallbacks (if allowed per kolumns) will fallback on right
	print(f"Merged with {this_wrangled_name}")
	print(main_index)



