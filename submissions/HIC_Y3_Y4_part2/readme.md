# HIC_Y3_Y4_part2

**These files were ID'd as corrupt by SRA and should be considered for removed from the HPRC bucket, as well as their copies in working**
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/HG03458/raw_data/hic/HG03458-2_FC2_S53_L003_R1_001.fastq.gz
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/HG03458/raw_data/hic/HG03458-2_FC2_S53_L003_R2_001.fastq.gz
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/NA19909/raw_data/hic/NA19909-1_FC1_S54_L003_R2_001.fastq.gz
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/NA19909/raw_data/hic/NA19909-1_FC1_S54_L003_R2_001.fastq.gz (Not corrupt, but the R2 is, so may as well trash R1 as well)

Process:
1. /submissions/HIC_Y3_Y4_part2/HIC_Y3_Y4_part2_data_table.csv --> '.tsv
	* Changed "University of California Santa Cruz" --> "UC Santa Cruz Genomics Institute" on data table CSV (and all downstream files)
2. HIC_Y3_Y4_part2_data_table.tsv --> HIC_Y3_Y4_part2_paired.tsv --> HIC_Y3_Y4_part2_sra.tsv
3. Upload to SRA
4. Oops, some files are bad (SUB15335177)
5. Remove bad files from HIC_Y3_Y4_part2_sra.tsv
6. Resubmitted HIC_Y3_Y4_part2_sra.tsv (SUB15533226)
7. Got `metadata-15533226-processed-ok.tsv` from SRA, which references each file's full s3 path
8. Created `metadata-15533226-processed-ok-no_path_in_filenames.tsv` which does NOT reference each file's full s3 path in order to make the validation script happy
9. Change everything's `sample_ID` to `sample_id` (except `metadata-15533226-processed-ok.tsv`) for consistency with other scripts

Conflicts: `library_strategy`

Validation **warning: even after you fix library_strategy this will still result in a __final.csv that has a mix of AWS URIs and non-AWS URIs -- more cleaning is needed before merging back to the index tables**
```
submission_csv_path = '../submissions/HIC_Y3_Y4_part2/HIC_Y3_Y4_part2_submission_metadata.csv'
wrangled_csv_path = '../submissions/HIC_Y3_Y4_part2/HIC_Y3_Y4_part2_data_table.csv'
NCBI_tsv_path = '../submissions/HIC_Y3_Y4_part2/metadata-15533226-processed-ok-no_path_in_filenames.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = ['library_source', 'generator_facility']
allowed_wrangled_NCBI_conflicts = ['library_source']
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
skip_index_validation = True
```