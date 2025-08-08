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
# likely several, we're gonna hardcode them rather than have you pass a bunch of args.
index_sheets = [
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - dc.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - hic.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - hifi.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - kinnex.tsv",
"/Users/aofarrel/github/HPRC_metadata/utils/2025-Aug-07_index_files/WORKING R2 Sequencing Data Index - ont.tsv"
]
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
if len(index_sheets) > 1:
	for sheet in index_sheets[1:]:
		another_index = Ranchero.from_tsv(sheet, index='filename', auto_standardize=False, auto_rancheroize=False)
		another_index = main_index.with_columns((~cs.string()).cast(pl.String)) # forces all columns into type str
		main_index = pl.concat([main_index, another_index], how='align_full')

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



