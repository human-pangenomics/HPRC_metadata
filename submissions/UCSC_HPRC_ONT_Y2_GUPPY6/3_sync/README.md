# Syncing from s3 to gs
Outputs from the ssds command that copies files from s3 (the submitter upload) to google cloud (which is accessible by AnVIL/Terra) like so:
```
ssds staging sync \
    --submission-id 121956E8-5DBD-462C-858C-A5361777EC1D \
    --deployment default \
    --dst-deployment gcp \
    &>sync_YEAR2_ONT_GUPPY6_S3_TO_GCP.txt &
```
For details on syncing see [Uploading and Syncing HPRC Submissions](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2327183361/Uploading+Syncing+HPRC+Submissions)
