## UW_HPRC_HiFI_Y2

I have notes indicating this may have been uploaded to SRA twice, but I didn't get around to properly confirming.

Submission CSV has 82 filenames
Wrangled CSV has 80 filenames (loss: 2)
TSV has 80 filenames (loss: 0)

Files that are on SRA but with *possibly* different filenames that what's in the post_sra_metadata TSV *might* exist (weasel words here because SRA sometimes changes filenames in different views):

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
submission_csv_path = '../submissions/UW_HPRC_HiFi_Y2/220118_HPRC_PacBio_HiFi_Metadata_Submission_v0.2_UW_wh_km.tsv'
wrangled_csv_path = '../submissions/UW_HPRC_HiFi_Y2/UW_HPRC_HiFi_Y2_data_table.csv'
NCBI_tsv_path = '../submissions/UW_HPRC_HiFi_Y2/metadata-11130351-processed-ok.tsv'
index = 'filename'
allowed_submission_wrangled_conflicts = []
allowed_wrangled_NCBI_conflicts = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```