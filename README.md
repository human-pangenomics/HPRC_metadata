# Submission workflows

Every submission contains subdirectories with information on all steps taken to create per-sample metadata.
Includes metadata generated by submitters, our QC, and SRA.

To add, copy the empty_submission subdirectory and follow the README prompts.

When done, create the new hprc_metadata.tsv file like so:
```
aws s3 ls s3://human-pangenomics/working --recursive --profile <your_profile> > s3.files
./merge_metadata.py --flist s3.files
```

*Please note:* The below is a concatenation of all README.md files in submissions/empty_submission

## Submitter metadata
Contains metadata xlsx files from submitters (.xlsx, unchanged) and cleaned tab separated versions (.tsv) for use in downstream applications.

## Bash scripts
Lab journal style code showing how files were created and commandline scripts executed.
Contains information on abnormally named samples and other pipeline hiccups.

## Syncing from s3 to gs
Outputs from the ssds command that copies files from s3 (the submitter upload) to google cloud (which is accessible by AnVIL/Terra) like so:
```
ssds staging sync \
    --submission-id c0de0f97-f422-4057-90bd-12b40869d30a \
    --deployment default \
    --dst-deployment gcp \
    &>sync_WUSTL_HPRC_HiFi_Year3.log &
```
For details on syncing see [Uploading and Syncing HPRC Submissions](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2327183361/Uploading+Syncing+HPRC+Submissions)

## Terra

For more details on the below, see [Setup A PacBio HiFi Wrangling Workspace In AnVIL](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2333245441/Setup+A+PacBio+HiFi+Wrangling+Workspace+In+AnVIL)

We run two QC workflows on the input HiFi bam files,
[Readstats](https://dockstore.org/workflows/github.com/human-pangenomics/hpp_production_workflows/ReadStats:master?tab=info)
and
[NTSM](https://dockstore.org/workflows/github.com/human-pangenomics/hpp_production_workflows/NTSM:master?tab=info).  
Note that these Dockstore pages have an Export to AnVIL option on the right hand side.  

To create input tables for these workflows upload
[Generate_Terra_Tables_HiFi_QC.ipynb](https://github.com/human-pangenomics/hpp_data_pipeline/blob/main/data_processing/AnVIL/Generate_Terra_Tables_HiFi_QC.ipynb) to the Analysis section

After running both workflows, check the results using
[Extract_HiFi_QC_Results.ipynb](https://github.com/human-pangenomics/hpp_data_pipeline/blob/main/data_processing/AnVIL/Extract_HiFi_QC_Results.ipynb)  
Note that this is meant for manual validation and does not output any files.

It is possible to merge Readstats, SRA (see step 5), and submitter info using
[mergeSRAMetaReadstats.ipynb](https://github.com/human-pangenomics/hpp_data_pipeline/blob/main/data_processing/AnVIL/mergeSRAMetaReadstats.ipynb) but it might be easier to just output the Readstats info in a table and merge using a commandline script.

## Readstats

Either the output of mergeSRAMetaReadstats.ipynb (see 4_terra/README.md) or a similar table with the relevant Readstats column names:
filename
total_reads
total_bp
total_Gbp
min
max
mean
quartile_25
quartile_50
quartile_75
N25
N50
N75

## Release

Once the files have gone through QC they can be released to the working sections of s3 and gs. This puts all data directly under their sample IDs, removing the submission details ('c0de0f97-f422-4057-90bd-12b40869d30a-WUSTL_HPRC_HiFi_Year3').  

The SSDS release command needs an input file with source and destination files. [create_release_csv.sh](https://github.com/human-pangenomics/hpp_data_pipeline/blob/main/data_processing/commandline/create_release_csv.sh) can be used to create this; make sure to update it with the correct information first.

Then the commands are run like so:
```
ssds staging release     --deployment default     --submission-id c0de0f97-f422-4057-90bd-12b40869d30a     --transfer-csv WUSTL_HPRC_HiFi_Year3.transfer_ec2.csv     &>WUSTL_HPRC_HiFi_Year3.transfer_aws.stdout &
ssds staging release     --deployment gcp     --submission-id c0de0f97-f422-4057-90bd-12b40869d30a     --transfer-csv WUSTL_HPRC_HiFi_Year3.transfer_gcp.csv     &>WUSTL_HPRC_HiFi_Year3.transfer_gcp.stdout &
```

## SRA submission

Make sure you have been added to the [ucsc-gi submitter group](https://submit.ncbi.nlm.nih.gov/groups/ucsc-gi).

Once the data passes QC it can be [uploaded to SRA](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2333147137/Upload+Reads+To+SRA).

If the samples don't have a Biosample ID yet, you need to create two files: one for the samples and one for the files. Both of these can be created using [sra_metadata.py](https://github.com/human-pangenomics/hpp_data_pipeline/blob/main/data_processing/commandline/sra_metadata.py) using the submitter metadata (convered to .tsv, see 1_submitter_metadata/README.md).

If the samples have already been submitted you only need to create one file, but the first field must be the Biosample ID. An example is submissions/UW_HPRC_HiFi_Y3/6_sra_submission/sra_metadata_UW_HPRC_HiFi_Y3_withBiosample.txt 

Follow [these instructions](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2333147137/Upload+Reads+To+SRA#Upload-Data-To-NCBI%2FSRA) to create the submission.

## SRA metadata

Once SRA accepts the submission it creates a link 'Download metadata file with SRA accessions' under My Submissions. This file contains the biosample and () and is named something like metadata-12876517-processed-ok.tsv.  
Rename it with the submission ID while keeping the SRA file ID (e.g. WUSTL_HPRC_HiFi_Year3_12876517.tsv) and put it in this directory.

## Aggregate Sample Files

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