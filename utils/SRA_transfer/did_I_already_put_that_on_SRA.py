# See if stuff in a metadata TSV file have already been upload to SRA by matching on filename.
# Usage: did_I_already_put_that_on_SRA.py <edirect_XML> <metadata_tsv> <verbose>
#       <edirect_XML>: XML from Entrez Direct search of SRA, assuming -db sra
#       <metadata_tsv>: a TSV of stuff you want on SRA that, at a minimum, includes a "filename" column
#       <verbose>: Optional -v flag to print intermediate dataframes

import sys
import polars as pl
import ranchero as Ranchero

if len(sys.argv) == 4:
	if sys.argv[3] not in ['-v', '-verbose', '--verbose']:
		print(f"Can't parse third argument: {sys.argv[3]}")
		exit(1)
	else:
		verbose = True
else:
	verbose = False

# Parse XML file to get what's already on SRA
edirect = Ranchero.from_efetch(sys.argv[1], index_by_file=True) # submitted_files --> __INDEX__file
edirect = edirect.rename({'run_index':'run_accession'}).drop(['notes'])
file_index = Ranchero.get_index(edirect)
assert edirect.height > 0

# We want to merge this with our own TSVs on the filename column, but there's a possibility
# of duplicate filenames on SRA, which causes issues when merging. This approach fixes that.
#edirect_by_filename = edirect.group_by("filename").agg(
#	[pl.col('run_accession'), pl.col('submitted_files_gibytes'), pl.col('alias')]
#)
#edirect_by_filename = Ranchero.hella_flat(edirect_by_filename, force_index="filename")

# Unfortunately, sometimes SRA changes the name of files upon upload. It seems that when this
# happens, it saves the old filename in the "alias" column, which is typically a list at this point.
# "Alias" also includes the other read for Illumina PE.
if edirect.schema['alias'] == pl.List:
#if edirect_by_filename.schema["alias"] == pl.List:
	edirect_by_alias = edirect.explode("alias")
	edirect_alternative_filenames_only = edirect_by_alias.filter(pl.col('alias') != pl.col(file_index))
else:
	edirect_alternative_filenames_only = edirect.filter(pl.col('alias') != pl.col(file_index))

# Like we did with the filenames, handle dupes among the aliases
edirect_alternative_filenames_only = edirect_alternative_filenames_only.group_by("alias").agg(
	[pl.col('run_accession'), pl.col('submitted_files_gibytes'), pl.col(file_index)]
)
edirect_alternative_filenames_only = Ranchero.hella_flat(edirect_alternative_filenames_only, force_index="alias")

# Parse TSV file of metadata
# If it's not indexed by filename, you'll want to add an explode() in here
metadata = Ranchero.from_tsv(sys.argv[2], check_index=False, auto_rancheroize=False).rename(
	{'filename': Ranchero.NeighLib.get_hypothetical_index_fullname('file')})
metadata = Ranchero.NeighLib.check_index(metadata)
assert file_index == Ranchero.NeighLib.get_index(metadata)
assert metadata.height > 0
if verbose:
	print("Metadata dataframe:")
	Ranchero.dfprint(metadata.sort(file_index), cols=5, rows=20, width=190, str_len=100)
else:
	print(f"{metadata.height} files in metadata dataframe")

# To make merging easier, we're going to drop columns from edirect dataframe, since we care less about its contents
edirect_by_filename = edirect.select([file_index, "alias", "run_accession"])
edirect_alternative_filenames_only = edirect_alternative_filenames_only.drop(file_index)

# Merge with SRA table upon the "filename" column
upon_filename = Ranchero.merge_dataframes(
	left=metadata, right=edirect_by_filename, 
	left_name="metadata_table", right_name="SRA_filename",
	merge_upon=file_index, force_index=file_index, drop_exclusive_right=True)

# Unfortunately we also need to merge on the "alias" column because some files get
# their name changed when uploaded to SRA!
upon_filename_and_alias = Ranchero.merge_dataframes(
	left=upon_filename, right=edirect_alternative_filenames_only.rename({"alias": file_index}), 
	left_name="metadata_table", right_name="SRA_alias",
	merge_upon=file_index, force_index=file_index, drop_exclusive_right=True)

# Mark rows of files not on SRA
try:
	merged = upon_filename_and_alias.with_columns(
		pl.when(pl.col('run_accession').is_null())
		.then(False).otherwise(True).alias("on_SRA")
	)
except pl.exceptions.ColumnNotFoundError:
	print("Could not find run_accession column -- usually this means none of your data is on SRA")
	merged = upon_filename_and_alias.with_columns(on_SRA=False)

# Also mark rows with "fail" in filename, which we may or may not want on SRA
merged = merged.with_columns(
	pl.when(pl.col(file_index).str.contains("fail"))
	.then(True).otherwise(False).alias("is_fail")
)

if verbose:
	print("Merged dataframe (metadata + edirect)")
	Ranchero.dfprint(merged.sort("on_SRA"), cols=10, rows=20, width=190, str_len=100)

probably_not_on_sra = Ranchero.hella_flat(merged.filter(pl.col("on_SRA") == False), force_index=file_index)
probably_not_on_sra = Ranchero.NeighLib.drop_null_columns(probably_not_on_sra, and_non_null_type_full_of_nulls=True)
if probably_not_on_sra.height > 0:
	# Generate data table to put on SRA by merging back with input TSV
	slap_that_on_sra = Ranchero.merge_dataframes(
		left=probably_not_on_sra.select(file_index), right=metadata,
		merge_upon=file_index, force_index=file_index, drop_exclusive_right=True).drop('collection')
	assert slap_that_on_sra.height == probably_not_on_sra.height
	Ranchero.to_tsv(slap_that_on_sra, "upload_candidates.tsv")
	if verbose:
		print("Samples that don't seem to be on SRA (wrote a to-upload table to upload_candidates.tsv):")
		Ranchero.dfprint(probably_not_on_sra.sort(file_index), cols=10, rows=-1, width=190, str_len=100)
	else:
		print(f"{probably_not_on_sra.height} files need to be uploaded, wrote to upload_candidates.tsv")
	
else:
	print("Everything seems to be on SRA!")

probably_on_sra = Ranchero.hella_flat(merged.filter(pl.col("on_SRA") == True), force_index=file_index)
probably_on_sra = Ranchero.NeighLib.drop_null_columns(probably_on_sra, and_non_null_type_full_of_nulls=True)
if probably_on_sra.height > 0:
	Ranchero.to_tsv(probably_on_sra, "probably_on_sra.tsv")
	if verbose:
		print("Samples that DO seem to be on SRA (wrote to probably_on_sra.tsv):")
		Ranchero.dfprint(probably_on_sra.sort(file_index), cols=10, rows=-1, width=190, str_len=100)
	else:
		print(f"{probably_on_sra.height} files are already on SRA, wrote to probably_on_sra.tsv")
else:
	print("None of the provided files are on SRA!")

assert probably_on_sra.height + probably_not_on_sra.height == metadata.height

if verbose:
	if "production" in merged.columns:
		print("Not on SRA, grouped by production")
		Ranchero.dfprint(probably_not_on_sra.group_by(pl.col("production"))
			.agg([pl.col('filetype').unique(), pl.col(file_index).len()])
			.rename({file_index: '# of files'})
			.sort("production"))

		print("On SRA, grouped by production")
		probably_on_sra = Ranchero.hella_flat(merged.filter(pl.col("on_SRA") == True), force_index=file_index)
		Ranchero.dfprint(probably_on_sra.group_by(pl.col("production"))
			.agg([pl.col('filetype').unique(), pl.col(file_index).len()])
			.rename({file_index: '# of files'})
			.sort("production"))

