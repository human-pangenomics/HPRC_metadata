## UW_HPRC_HiFi_Y2

Submission CSV has 82 filenames
Wrangled CSV has 80 filenames (loss: 2)
TSV has 80 filenames (loss: 0)

Files that are on SRA but with slightly different filenames that what's in the post_sra_metadata TSV:

m54329U_210507_224951-bc1008_BAK8A_OA.hifi_reads.bam > m54329U_210507_224951_bc1008_BAK8A_OA.hifi_reads.bam.1
m54329U_210517_210109-bc1003_BAK8A_OA.hifi_reads.bam > m54329U_210517_210109_bc1003_BAK8A_OA.hifi_reads.bam.1
m54329U_210519_065152-bc1003_BAK8A_OA.hifi_reads.bam > m54329U_210519_065152_bc1003_BAK8A_OA.hifi_reads.bam.1
m54329U_210507_224951-bc1011_BAK8A_OA.hifi_reads.bam > m54329U_210507_224951_bc1011_BAK8A_OA.hifi_reads.bam.1
m54329U_210517_210109-bc1003_BAK8A_OA.hifi_reads.bam > m54329U_210517_210109_bc1003_BAK8A_OA.hifi_reads.bam.1
m54329U_210507_224951-bc1003_BAK8A_OA.hifi_reads.bam > m54329U_210507_224951_bc1003_BAK8A_OA.hifi_reads.bam.1
m54329U_210507_224951-bc1010_BAK8A_OA.hifi_reads.bam > m54329U_210507_224951_bc1010_BAK8A_OA.hifi_reads.bam.1
m54329U_210520_213459-bc1003_BAK8A_OA.hifi_reads.bam > m54329U_210520_213459_bc1003_BAK8A_OA.hifi_reads.bam.1
m54329U_210514_222517-bc1003_BAK8A_OA.hifi_reads.bam > m54329U_210514_222517_bc1003_BAK8A_OA.hifi_reads.bam.1
m54329U_210507_224951-bc1009_BAK8A_OA.hifi_reads.bam > m54329U_210507_224951_bc1009_BAK8A_OA.hifi_reads.bam.1


Validation:
```
submission_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UW_HPRC_HiFi_Y2/220118_HPRC_PacBio_HiFi_Metadata_Submission_v0.2_UW_wh_km.tsv'
wrangled_csv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UW_HPRC_HiFi_Y2/UW_HPRC_HiFi_Y2_data_table.csv'
tsv_path = '/Users/aofarrel/github/HPRC_metadata/submissions/UW_HPRC_HiFi_Y2/metadata-11130351-processed-ok.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = []
overide_csv_with_tsv_in_these_columns = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```