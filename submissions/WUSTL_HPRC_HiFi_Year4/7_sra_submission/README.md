# SRA submission

Make sure you have been added to the [ucsc-gi submitter group](https://submit.ncbi.nlm.nih.gov/groups/ucsc-gi).

Once the data passes QC it can be [uploaded to SRA](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2333147137/Upload+Reads+To+SRA).

If the samples don't have a Biosample ID yet, you need to create two files: one for the samples and one for the files. Both of these can be created using [sra_metadata.py](https://github.com/human-pangenomics/hpp_data_pipeline/blob/main/data_processing/commandline/sra_metadata.py) using the submitter metadata (convered to .tsv, see 1_submitter_metadata/README.md).

If the samples have already been submitted you only need to create one file, but the first field must be the Biosample ID. An example is submissions/UW_HPRC_HiFi_Y3/6_sra_submission/sra_metadata_UW_HPRC_HiFi_Y3_withBiosample.txt 

Follow [these instructions](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2333147137/Upload+Reads+To+SRA#Upload-Data-To-NCBI%2FSRA) to create the submission.
