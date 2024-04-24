
## Example: Create Aggregated ONT Sample File Metadata
### Meta Flow: merge_metadata.py output piped to aggregate_sample_metadata.py

**Note**: Assumes executing the utils scripts relative to the main HPRC_metadata directory.

```python
python utils/merge_metadata.py --flist data/aws-s3/s3.files --type ONT
```

```python
python3 utils/aggregate_sample_metadata.py \
--hprc_metadata_sample_files_modality data/sample-files/hprc_metadata_sample_files_ONT.tsv \
--columns_1_submitter submissions/aggregate-sample-inputs/hprc_1_submitter_columns_ONT.tsv \
--columns_5_readstat submissions/aggregate-sample-inputs/hprc_5_readstats_columns_ONT.tsv \
--aggregate_rule_5_readstat_sample submissions/aggregate-sample-inputs/hprc_5_readstat_sample_aggregate_rules_ONT.tsv
```