## UCSC_HPRC_nanopore_Year3

Valid stuff that still ought to be uploaded but currently cannot
* not_on_sra_lacks_metadata.tsv
* not_on_sra_FAIL.tsv, iff we are uploading fail bams

Process:
1. Cleaned some stuff up
2. (uselessly) Split existing SRA table into two based on whether or not samples had run accessions
3. p2 of the SRA table (the one that has files not on SRA) was merged with metadata table, greatly increasing the number of samples (yes, this basically re-adds back in the p1 samples) -- we did this because the metadata table and the SRA table have different metadata and combining them gives us the most possible
4. Took p2-metadata merge and compared against BQ to see what's actually on SRA or not in one big table that has as much metadata as possible, which gave us a list of 365 files not on SRA
5. Filter on not having fail in filename, in having a library_selection, and in having an NTSM score
6. Changed generator to different format of UCSC's name, and other assorted cleanups
7. Spun off R3 samples

No summary table due to a mixture of fail bams on and not on SRA

