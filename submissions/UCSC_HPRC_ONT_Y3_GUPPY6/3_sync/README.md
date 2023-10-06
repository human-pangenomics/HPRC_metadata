# Syncing from s3 to gs
Outputs from the ssds command that copies files from s3 (the submitter upload) to google cloud (which is accessible by AnVIL/Terra) like so:
```
ssds staging sync \
    --submission-id c0de0f97-f422-4057-90bd-12b40869d30a \
    --deployment default \
    --dst-deployment gcp \
    &>sync_WUSTL_HPRC_HiFi_Year3.log &
```
For details on syncing see [Uploading and Syncing HPRC Submissions](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2327183361/Uploading+Syncing+HPRC+Submissions)
