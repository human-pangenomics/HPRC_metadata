import sys
import polars as pl
import subprocess
from tqdm import tqdm
from pathlib import PurePosixPath

def has_gs_path(polars_df):
	return polars_df.filter(pl.col('manifest_gs_path').is_not_null()).shape[0]

manifests = pl.read_csv("./logs_and_manifests/manifests_2025-07-14.csv", infer_schema_length=1000)
manifests = manifests.drop(['slurm_job_id','slurm_task_id'], strict=False)
inputs = {
	'Hi-C':'./input_tsvs/WORKING R2 Sequencing Data Index - hic.tsv',
	'Illumina':'./input_tsvs/WORKING R2 Sequencing Data Index - ill.tsv',
	'hifi':'./input_tsvs/WORKING R2 Sequencing Data Index - hifi.tsv',
	'ONT':'./input_tsvs/WORKING R2 Sequencing Data Index - ont.tsv',
}

for keys, values in inputs.items():
	print() # newline
	df = pl.read_csv(values, separator="\t", infer_schema_length=10000).select(['filename', 'path', 'sample_id'])
	los_dos = manifests.join(df, on="filename", how="right", coalesce=True)
	print(f"Out of all {keys} data, {has_gs_path(los_dos)} ({100 * has_gs_path(los_dos) / los_dos.shape[0]:.2f}%) have been transferred to AnVIL")
	path_contains_working = los_dos.filter(pl.col('path').str.contains("working"))
	print(f"Out of all {keys} data in working, {has_gs_path(path_contains_working)} ({100 * has_gs_path(path_contains_working) / path_contains_working.shape[0]:.2f}%) have been transferred to AnVIL")
	los_dos_sketch = path_contains_working.filter(pl.col('manifest_gs_path').is_null())
