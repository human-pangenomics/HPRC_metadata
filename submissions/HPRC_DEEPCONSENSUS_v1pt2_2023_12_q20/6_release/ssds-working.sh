# Release from submission to working
conda activate aws-ssds
ssds staging release \
    --deployment default \
    --submission-id 3A25CF8A-1F36-42EE-BC9F-D29CECAA2A99 \
    --transfer-csv HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_release.csv \
    &> HPRC_DEEPCONSENSUS_v1pt2_2023_12_q20_release.transfer.log