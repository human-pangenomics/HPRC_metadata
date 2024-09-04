# Release

Once the files have gone through QC they can be released to the working sections of s3 and gs. This puts all data directly under their sample IDs, removing the submission details ('c0de0f97-f422-4057-90bd-12b40869d30a-WUSTL_HPRC_HiFi_Year3').  

The SSDS release command needs an input file with source and destination files. [create_release_csv.sh](https://github.com/human-pangenomics/hpp_data_pipeline/blob/main/data_processing/commandline/create_release_csv.sh) can be used to create this; make sure to update it with the correct information first.

Then the commands are run like so:
```
ssds staging release     --deployment default     --submission-id c0de0f97-f422-4057-90bd-12b40869d30a     --transfer-csv WUSTL_HPRC_HiFi_Year3.transfer_ec2.csv     &>WUSTL_HPRC_HiFi_Year3.transfer_aws.stdout &
ssds staging release     --deployment gcp     --submission-id c0de0f97-f422-4057-90bd-12b40869d30a     --transfer-csv WUSTL_HPRC_HiFi_Year3.transfer_gcp.csv     &>WUSTL_HPRC_HiFi_Year3.transfer_gcp.stdout &
```
