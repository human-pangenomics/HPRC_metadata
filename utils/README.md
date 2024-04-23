
## HiFi Example: merge_metadata.py output piped to aggregate_sample_metadata.py

```python
python merge_metadata.py --flist data-tables/s3.files --type HiFi
```

```python
python3 aggregate_sample_metadata.py \
--hprc_metadata_sample_files_modality data-tables/sample-files/hprc_metadata_sample_files_ONT.tsv \
--columns_1_submitter data-tables/aggregate-sample-inputs/hprc_1_submitter_columns_ONT.tsv \
--columns_5_readstat data-tables/aggregate-sample-inputs/hprc_5_readstats_columns_ONT.tsv \
--aggregate_rule_5_readstat_sample data-tables/aggregate-sample-inputs/hprc_5_readstat_sample_aggregate_rules_ONT.tsv
```