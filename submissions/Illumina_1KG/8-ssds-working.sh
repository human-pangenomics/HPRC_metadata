# Release from submission to working
ssds staging release \
    --deployment default \
    --submission-id AD30A684-C7A8-4D24-89B2-040DFF021B0C \
    --transfer-csv Y2_1000G_DATA.transfer.csv \
    &> Y2_1000G_DATA.transfer.log

ssds staging release \
    --deployment default \
    --submission-id 325b4b1c-9f20-49be-b03a-596da89c466e \
    --transfer-csv CHILDREN_1000G_DATA.transfer.csv \
    &> CHILDREN_1000G_DATA.transfer.log