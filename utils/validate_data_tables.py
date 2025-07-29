submission_csv_path = ''
wrangled_csv_path = ''
tsv_path = ''
index = 'filename'
overide_csv_with_tsv_in_these_columns = []
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
# submission_csv_path: CSV directly from submitter
# wrangled_csv_path: wrangled CSV "data table"
# tsv_path: ideally the "metadata-XXXXXXXX-processed-ok" TSV from NCBI, if not available, ash's TSV
# index: column of *completely unique* values to serve as the index, should usually be 'filename'
# overide_csv_with_tsv_in_these_columns: if wrangled_csv and tsv have different values in same column, assume TSV is source of truth, else throw error
# wrangled_csv_is_actually_tsv: exactly what it says on the tin
###############################
import os
import sys
import polars as pl

# ranchero isn't pip-installable yet so this is a goofy workaround for importing it
ranchero_path = '/Users/aofarrel/github/Ranchero'
sys.path.insert(0, ranchero_path) 
import src as Ranchero

# read metadata files
submission = pl.read_csv(submission_csv_path)
submission = Ranchero.NeighLib.mark_index(submission, index)
if wrangled_csv_is_actually_tsv:
	wrangled = Ranchero.from_tsv(wrangled_csv_path, index=index, auto_standardize=False)
else:
	wrangled = pl.read_csv(wrangled_csv_path)
	wrangled = Ranchero.NeighLib.mark_index(wrangled, index)
tsv = Ranchero.from_tsv(tsv_path, index=index, auto_standardize=False)

# ensure no funny business
merge_upon = "__index__" + index
assert merge_upon in submission.columns
assert merge_upon in wrangled.columns
assert merge_upon in tsv.columns

# sometimes we need to play with library_id/library_name for NCBI to be happy
if 'library_name' != index and 'library_id' != index and 'library_ID' != index:
	if 'library_name' in tsv.columns and 'library_name' not in wrangled.columns and 'library_ID' in wrangled.columns:
		tsv = tsv.rename({'library_name': 'library_ID'})
		print("Renamed TSV's library_name (SRA standard) to library_ID (our standard)")
	elif 'library_name' in tsv.columns and 'library_name' not in wrangled.columns and 'library_id' in wrangled.columns:
		tsv = tsv.rename({'library_name': 'library_id'})
		print("Renamed TSV's library_name (SRA standard) to library_id (our standard)")
	elif 'library_name' in tsv.columns and 'library_name' not in wrangled.columns:
		if wrangled_csv_can_lack_library_id:
			print("Warning: library_id/library_ID not in wrangled CSV, but that's probably okay")
		else:
			raise ValueError("library_id/library_ID not in wrangled CSV")

print(f"Submission CSV has {submission.shape[0]} {index}s")
print(f"Wrangled CSV has {wrangled.shape[0]} {index}s (loss: {submission.shape[0] - wrangled.shape[0]})")
print(f"TSV has {tsv.shape[0]} {index}s (loss: {wrangled.shape[0] - tsv.shape[0]})")

# check for stuff being added when they shouldn't be
# we should expect there to be some indeces exclusive to submission, so don't report those... but everything else is sus
in_wrangled_not_submission = set(wrangled[merge_upon].to_list()) - set(submission[merge_upon].to_list())
if len(in_wrangled_not_submission) != 0:
	raise ValueError(f"Found {index}s in wrangled CSV but not submitted CSV: {in_wrangled_not_submission}")
in_wrangled_not_tsv = set(wrangled[merge_upon].to_list()) - set(tsv[merge_upon].to_list())
if len(in_wrangled_not_tsv) != 0:
	raise ValueError(f"Found indexes exclusive to wrangled CSV not in : {in_wrangled_not_tsv}")
in_tsv_not_wrangled = set(tsv[merge_upon].to_list()) - set(wrangled[merge_upon].to_list())
if len(in_tsv_not_wrangled) != 0:
	raise ValueError(f"Found indexes exclusive to CSV: {in_tsv_not_wrangled}")

print("Double check these, just in case:")
print(f"\tColumns in wrangled CSV but not TSV: {set(wrangled.columns) - set(tsv.columns)}")
print(f"\tColumns in TSV but not wrangled CSV: {set(tsv.columns) - set(wrangled.columns)}")

# We want to check for inconsistent values across dataframes. The easiest way to do this is to leverage Ranchero.merge_dataframes(),
# since it has has predefined behavior for handling dataframes with inconsistent values in its columns. All we care about here is
# "list_throw_error" (for catching inconsistencies) and "list_fallback_or_null" (for allowing overrides/updates).
# -> For column in Ranchero.kolumns.list_throw_error, if all(left_df[column]) != all(right_df[column]), throw error
# -> For column in Ranchero.kolumns.list_fallback_or_null, wherever left_df[column]) !=  right_df[column], use value of right_df
# First, however, we need to know which columns are shared between the dataframes.
shared_kolumns_submission_wrangled = Ranchero.NeighLib.get_dupe_columns_of_two_polars(submission, wrangled, assert_shared_cols_equal=False)
shared_kolumns_wrangled_tsv = Ranchero.NeighLib.get_dupe_columns_of_two_polars(wrangled, tsv, assert_shared_cols_equal=False)

# submission-vs-wrangled: this is just a test merge, we will not be writing this dataframe to the disk
Ranchero.kolumns.list_fallback_or_null = None
Ranchero.kolumns.list_throw_error = x for x in shared_kolumns_submission_wrangled
merged = Ranchero.merge_dataframes(submission, wrangled, merge_upon=merge_upon, fallback_on_left=False)
Ranchero.NeighLib.assert_no_list_columns(merged)

# wrangled-vs-tsv: this merge will be written to the disk (if it's valid)
Ranchero.kolumns.list_fallback_or_null = overide_csv_with_tsv_in_these_columns
Ranchero.kolumns.list_throw_error = [x for x in shared_kolumns_wrangled_tsv if x not in overide_csv_with_tsv_in_these_columns]

merged = Ranchero.merge_dataframes(wrangled, tsv, merge_upon=merge_upon, fallback_on_left=False)
Ranchero.NeighLib.assert_no_list_columns(merged)

assert 'accession' in merged.columns, "No run accession column!"

if 'sample_ID' in merged.columns and 'sample_id' not in merged.columns:
	sampleid = 'sample_ID'
elif 'sample_id' in merged.columns and 'sample_ID' not in merged.columns:
	sampleid = 'sample_id'
else:
	raise ValueError

Ranchero.NeighLib.super_print_pl(
	merged.select([merge_upon, sampleid, 'biosample_accession', 'accession', 'generator_facility'])
, "coolest columns in merged dataframe")

# if we made it this far, write a final CSV
if merge_upon == '__index__filename':
	merged = merged.rename({'__index__filename': 'filename'}).drop('collection')
outpath = wrangled_csv_path[:-4]+"__final.csv"
merged.write_csv(outpath)
