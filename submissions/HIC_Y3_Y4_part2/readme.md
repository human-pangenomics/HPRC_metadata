# HIC_Y3_Y4_part2

**These files were ID'd as corrupt by SRA and should be considered for removed from the HPRC bucket, as well as their copies in working**
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/HG03458/raw_data/hic/HG03458-2_FC2_S53_L003_R1_001.fastq.gz
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/HG03458/raw_data/hic/HG03458-2_FC2_S53_L003_R2_001.fastq.gz
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/NA19909/raw_data/hic/NA19909-1_FC1_S54_L003_R2_001.fastq.gz
* submissions/1005B25C-EAFA-40A7-AD42-45759D174009--HIC_Y3_Y4_part2/NA19909/raw_data/hic/NA19909-1_FC1_S54_L003_R2_001.fastq.gz (Not corrupt, but the R2 is, so may as well trash R1 as well)

Process:
1. /submissions/HIC_Y3_Y4_part2/HIC_Y3_Y4_part2_data_table.csv --> '.tsv
	* Changed "University of California Santa Cruz" --> "UC Santa Cruz Genomics Institute" on data table CSV (and all downstream files)
2. HIC_Y3_Y4_part2_data_table.tsv --> HIC_Y3_Y4_part2_paired.tsv --> HIC_Y3_Y4_part2_sra.tsv
3. Upload to SRA
4. Oops, some files are bad (SUB15335177)
5. Remove bad files from HIC_Y3_Y4_part2_sra.tsv
6. Resubmitted HIC_Y3_Y4_part2_sra.tsv (SUB15533226)

