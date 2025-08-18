HG04187 no methylation or kinetics
Check reads.bam and subread.bam in RU_Y2_sequel submission

```python
['s3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/PacBio_HiFi/m64055_210509_163848.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/PacBio_HiFi/m64055_210511_013535.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/PacBio_HiFi/m64055_210512_103416.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/PacBio_HiFi/m64055_210514_141159.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/PacBio_HiFi/m64055_210609_194302.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/PacBio_HiFi/m64055_210611_031318.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/m64055_210509_163848.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/m64055_210511_013535.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/m64055_210512_103416.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/m64055_210514_141159.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/m64055_210609_194302.hifi_reads.bam', 's3://human-pangenomics/submissions/746FF75B-3C32-42AF-92BB-290BA92CF89A--RU_Y2_HIFI/HG04187/m64055_210611_031318.hifi_reads.bam']
```









ash zone:

Submission CSV has 36 filenames
Wrangled CSV has 24 filenames (loss: 12)
TSV has 24 filenames (loss: 0)

```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y2_HIFI/HPRC_RU_Y2_Sequel_Metadata_PacBio_HiFi_Submission.csv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y2_HIFI/RU_Y2_HIFI_data_table.csv'
NCBI_tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/RU_Y2_HIFI/metadata-14647736-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = ['instrument_model', 'library_ID']
allowed_wrangled_NCBI_conflicts = []
submission_csv_is_actually_tsv = False
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = False
```