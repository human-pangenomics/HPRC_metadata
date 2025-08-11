import sys
import polars as pl
ranchero_path = '/Users/aofarrel/github/Ranchero'
sys.path.insert(0, ranchero_path) 
import src as Ranchero

tsv1 = Ranchero.from_tsv("../submissions/UCSC_HPRC_nanopore_Year2/metadata-13886856-processed-ok.tsv", index='accession', auto_standardize=False)
tsv2 = Ranchero.from_tsv("../submissions/UCSC_HPRC_nanopore_Year2/metadata-13886918-processed-ok.tsv", index='accession', auto_standardize=False)

concat = pl.concat([tsv1, tsv2], how='align_full')

# MANUALLY make sure no columns are nonsense, the goofy way
for some_column in concat.columns:
	print(some_column)
	Ranchero.dfprint(concat.select(some_column))

concat = concat.rename({"__index__accession": "accession"})
Ranchero.to_tsv(concat, "../submissions/UCSC_HPRC_nanopore_Year2/metadata-processed-ok-concat-redo.tsv")