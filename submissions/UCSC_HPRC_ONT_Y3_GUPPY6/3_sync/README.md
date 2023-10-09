# Syncing from s3 to gs
Outputs from the ssds command that copies files from s3 (the submitter upload) to google cloud (which is accessible by AnVIL/Terra) like so:

```
ssds staging sync \
    --submission-id 79275EDA-C282-424A-9D5B-A8E876592893 \
    --deployment default \
    --dst-deployment gcp \
    &>sync_YEAR3_ONT_GUPPY6_S3_TO_GCP.txt &
```

In this case the submission was done directly to both gcp and aws, so the sync command just confirmed that both submissions matched.

For details on syncing see [Uploading and Syncing HPRC Submissions](https://ucsc-cgl.atlassian.net/wiki/spaces/~63c888081d7734b550c2052b/pages/2327183361/Uploading+Syncing+HPRC+Submissions)
