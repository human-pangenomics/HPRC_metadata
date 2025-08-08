## UW_HPRC_Hifi_Y3

Everything on data table has been submitted. AWS table contains more files, but we are assuming most of those AWS files are not important.

Small metadata conflicts in m64076_221001_041132-bc1012.5mc.hifi_reads.bam:
* is on SRA and wrangled as ccs_algorithm being 6.3.0 but is on the submitted data table as 6.2.0
* is on SRA and wrangled as polymerase_version being P2.2 but is on the submitted data table as P3.2


~~SRA appears to have changed the filenames of some of these files, turning some dashes into underscores. If someone downloads these files from SRA, they may get different filenames than what we have on record. The internal filename is still being used as the "index" here, and the SRA filename is in the notes column.~~ I'm starting to think these "name changes" only happen when keying on XML files.

Submission CSV has 91 filenames
Wrangled CSV has 91 filenames (loss: 0)
TSV has 91 filenames (loss: 0)

Validation:
```
submission_csv_path = '../submissions/UW_HPRC_HiFi_Y3/HPRC_PacBio_HiFi_Metadata_Submission_UW_Yr3.with5mc.tsv'
wrangled_csv_path = '../submissions/UW_HPRC_HiFi_Y3/UW_HPRC_HiFi_Y3_data_table.csv'
tsv_path = '../submissions/UW_HPRC_HiFi_Y3/metadata-12971042-processed-ok.tsv'
index = 'filename'
allow_wrangled_to_conflict_with_submission_here = []
overide_csv_with_tsv_in_these_columns = []
submission_csv_is_actually_tsv = True
wrangled_csv_is_actually_tsv = False
wrangled_csv_can_lack_library_id = False
tsv_is_multi_file = True
```