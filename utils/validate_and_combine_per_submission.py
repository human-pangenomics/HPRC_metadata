submission_csv_path = ''
wrangled_csv_path = ''
NCBI_tsv_path = ''
index = 'filename'
allowed_submission_wrangled_conflicts = []
allowed_wrangled_NCBI_conflicts = []
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
skip_index_validation = False
# submission_csv_path: CSV directly from submitter (can be TSV, see below)
# wrangled_csv_path:   Wrangled CSV "data table" (can be TSV, see below)
# NCBI_tsv_path:       The "metadata-XXXXXXXX-processed-ok" TSV from NCBI after a submission is fully processed
# index:               Column of *completely unique* values to serve as the index -- should almost always be 'filename'
# allowed_submission_wrangled_conflicts: If submission_csv and wrangled_csv have different values in this shared column,
#                                        assume submission_csv is source of truth, else throw error
# allowed_wrangled_NCBI_conflicts:       If wrangled_csv and NCBI_tsv have different values in this shared column,
#                                        assume TSV is source of truth, else throw error (this means that the __final.csv
#                                        will fallback on what's in the TSV for these columns)
# submission_csv_is_actually_tsv:    Read `submission_csv_path` as if it were a TSV
# wrangled_csv_is_actually_tsv:      Read `wrangled_csv_path` as if it were a TSV
# wrangled_csv_can_lack_library_id:  Allow wrangled CSV to not have a library_id column
# tsv_is_multi_file:                 Set this if TSV has multiple files per line (like paired illumina reads)
# skip_index_validation: 			 Skip index validation -- ONLY DO THIS IF YOU CAREFULLY VALIDATE YOUR OUTPUTS

import os
import sys
try:
	import ranchero as Ranchero
except ImportError:
	print("Failed to import ranchero. Run `pip install ranchero` (preferably in a Python venv).")
	print("If it still doesn't import, kick Ash until he fixes it.")
try:
	import polars as pl
except ImportError:
	print("Somehow imported ranchero, but not polars? This should never happen.")

# read metadata files
if submission_csv_is_actually_tsv:
	submission = Ranchero.from_tsv(submission_csv_path, index=index, auto_standardize=False)
else:
	submission = pl.read_csv(submission_csv_path)
	submission = Ranchero.NeighLib.mark_index(submission, index)

if wrangled_csv_is_actually_tsv:
	wrangled = Ranchero.from_tsv(wrangled_csv_path, index=index, auto_standardize=False)
else:
	wrangled = pl.read_csv(wrangled_csv_path)
	wrangled = Ranchero.NeighLib.mark_index(wrangled, index)

if tsv_is_multi_file:
	assert index == 'filename'
	temp_index = 'accession'
	tsv = Ranchero.from_tsv(NCBI_tsv_path, index=temp_index, auto_standardize=False)
	filename_columns = [col for col in tsv.columns if col.startswith('filename')]

	# we have to fill_null() to prevent nulls from taking over everything (please just trust me on this one)
	tsv = tsv.with_columns(pl.concat_list(
		pl.col(filename_columns).fill_null('this should be a literal None but that makes polars angry :-(')
	).alias("merged_filenames")).drop(filename_columns)
	#print(Ranchero.NeighLib.col_to_list(tsv, "merged_filenames"))

	tsv = tsv.with_columns(pl.col("merged_filenames").list.eval(
		pl.element().filter(pl.element() != 'this should be a literal None but that makes polars angry :-(')
	).alias("filename")).drop('merged_filenames')
	#print(Ranchero.NeighLib.col_to_list(tsv, "filename"))

	# explode on filename to get a filename-indexed dataframe
	tsv = tsv.explode('filename').rename({'__index__accession': 'accession'})
	tsv = Ranchero.rancheroize(tsv, index=index)
	#print(Ranchero.NeighLib.col_to_list(tsv, "__index__filename"))
else:
	tsv = Ranchero.from_tsv(NCBI_tsv_path, index=index, auto_standardize=False)

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

if not skip_index_validation:
	assert tsv.shape[0] == wrangled.shape[0]
	# check for stuff being added when they shouldn't be
	# we should expect there to be some indeces exclusive to submission, so don't report those... but everything else is sus
	in_wrangled_not_submission = set(wrangled[merge_upon].to_list()) - set(submission[merge_upon].to_list())
	if len(in_wrangled_not_submission) != 0:
		raise ValueError(f"Found {index}s in wrangled CSV but not submitted CSV: {in_wrangled_not_submission}")
	in_wrangled_not_tsv = set(wrangled[merge_upon].to_list()) - set(tsv[merge_upon].to_list())
	if len(in_wrangled_not_tsv) != 0:
		raise ValueError(f"Found indexes exclusive to wrangled CSV not in TSV: {in_wrangled_not_tsv}")
	in_tsv_not_wrangled = set(tsv[merge_upon].to_list()) - set(wrangled[merge_upon].to_list())
	if len(in_tsv_not_wrangled) != 0:
		raise ValueError(f"Found indexes exclusive to TSV: {in_tsv_not_wrangled}")

print("Double check these, just in case:")
print(f"\tColumns in wrangled CSV but not TSV: {set(wrangled.columns) - set(tsv.columns)}")
print(f"\tColumns in TSV but not wrangled CSV: {set(tsv.columns) - set(wrangled.columns)}")

# We want to check for inconsistent values across dataframes. The easiest way to do this is to leverage Ranchero.merge_dataframes(),
# since it has has predefined behavior for handling dataframes with inconsistent values in its columns. All we care about here is
# "list_throw_error" (for catching inconsistencies) and "list_fallback_or_null" (for allowing overrides/updates).
# - For column in Ranchero.kolumns.list_throw_error, if all(left_df[column]) != all(right_df[column]), throw error
# - For column in Ranchero.kolumns.list_fallback_or_null, wherever left_df[column]) !=  right_df[column], use value of right_df
# First, however, we need to know which columns are shared between the dataframes.
shared_kolumns_submission_wrangled = Ranchero.NeighLib.get_dupe_columns_of_two_polars(submission, wrangled, assert_shared_cols_equal=False)
shared_kolumns_wrangled_tsv = Ranchero.NeighLib.get_dupe_columns_of_two_polars(wrangled, tsv, assert_shared_cols_equal=False)

# submission-vs-wrangled: this is just a test merge, we will not be writing this dataframe to the disk...
# well, mostly!
if submission.shape[0] - wrangled.shape[0] > 0:
	# avoid nulls (created by wrangled simply having less rows) triggering false positives in mismatch checks
	submission = submission.filter(pl.col(merge_upon).is_in(wrangled[merge_upon].to_list()))
Ranchero.kolumns.list_fallback_or_null = allowed_submission_wrangled_conflicts
Ranchero.kolumns.list_throw_error = [x for x in shared_kolumns_submission_wrangled if x not in allowed_submission_wrangled_conflicts]
merged = Ranchero.merge_dataframes(submission, wrangled, merge_upon=merge_upon, 
	left_name='submission_csv', right_name='wrangled_csv', 
	fallback_on_left=False) # fallbacks (if allowed per kolumns) will fallback on right
merged = merged.drop('collection')
Ranchero.NeighLib.assert_no_list_columns(merged)

# if the submitter provided an md5sum, use it!!
if 'md5sum' in merged.columns:
	new_columns = list(column for column in merged.columns if column not in shared_kolumns_submission_wrangled)
	new_columns.remove('md5sum')
	merged = merged.drop(new_columns)
	assert list(column for column in merged.columns if column not in wrangled.columns) == ['md5sum']
	wrangled = merged.rename({'md5sum': 'submitter_md5sum'})

# wrangled-vs-tsv: this merge will be written to the disk (if it's valid)
Ranchero.kolumns.list_fallback_or_null = allowed_wrangled_NCBI_conflicts
Ranchero.kolumns.list_throw_error = [x for x in shared_kolumns_wrangled_tsv if x not in allowed_wrangled_NCBI_conflicts]
merged = Ranchero.merge_dataframes(wrangled, tsv, merge_upon=merge_upon,
	left_name='wrangled_csv', right_name='final_tsv', 
	fallback_on_left=False) # fallbacks (if allowed per kolumns) will fallback on right
merged = merged.drop('collection')
Ranchero.NeighLib.assert_no_list_columns(merged)

assert 'accession' in merged.columns, "No run accession column!"

if 'sample_ID' in merged.columns and 'sample_id' not in merged.columns:
	sampleid = 'sample_ID'
elif 'sample_id' in merged.columns and 'sample_ID' not in merged.columns:
	sampleid = 'sample_id'
else:
	raise ValueError(f"Can't figure out what the sample ID column is in merged dataframe. (Or multiple are present!) Columns: {merged.columns}")

Ranchero.NeighLib.super_print_pl(
	merged.select([merge_upon, sampleid, 'accession', 'generator_facility']), 
	"coolest columns in merged dataframe")

# if we made it this far, write a final CSV
if merge_upon == '__index__filename':
	merged = merged.rename({'__index__filename': 'filename'})
outpath = wrangled_csv_path[:-4]+"__final.csv"
merged.write_csv(outpath)
