#! /bin/bash

#working directory on phoenix cluster
#/private/groups/hprc/UCSC_HPRC_nanopore_Year2/guppy_run2

#s3 location for ONT Year2 rebasecalling with mods using guppy 6
#https://s3-us-west-2.amazonaws.com/human-pangenomics/index.html?prefix=submissions/121956E8-5DBD-462C-858C-A5361777EC1D--UCSC_HPRC_ONT_Y2_GUPPY6/
#s3 location for ONT Year2 raw data (fast5) and basecalled data w/o mods using guppy 5 
#https://s3-us-west-2.amazonaws.com/human-pangenomics/index.html?prefix=submissions/90A1F283-2752-438B-917F-53AE76C9C43E--UCSC_HPRC_nanopore_Year2/

#count the number of sample subdirectories in raw data submission
#aws s3 ls  s3://human-pangenomics/submissions/90A1F283-2752-438B-917F-53AE76C9C43E--UCSC_HPRC_nanopore_Year2/  | wc -l
#55

#count the number of fast5 tar files in raw data submissions, there are multiple flowcells per sample
#aws s3 ls --recursive s3://human-pangenomics/submissions/90A1F283-2752-438B-917F-53AE76C9C43E--UCSC_HPRC_nanopore_Year2/ | grep .tar | wc -l
#175

#Check that Guppy6 submission includes files for each
#wc -l UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.txt
#350 lines in file w/o header

#cut -f3 UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.txt | sort | uniq | wc -l
#55 samples

#grep pass.bam UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.txt | wc -l
#175 pass.bam files

#grep fail.bam UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.txt | wc -l
#175 fail.bam files

#check that files in submission file are in submission directory
#aws s3 ls --recursive s3://human-pangenomics/submissions/121956E8-5DBD-462C-858C-A5361777EC1D--UCSC_HPRC_ONT_Y2_GUPPY6 | grep bam$ > s3.bams 
#wc -l s3.bams
#350 s3.bams

#cut -f1 UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.txt | grep .bam$ | sort -u > want
#sed 's/.*\///' s3.bams | sort > have
#comm -3 have want #perfect files match

#check gs
#gsutil -u hpp-ucsc ls -R gs://fc-4310e737-a388-4a10-8c9e-babe06aaf0cf/submissions/121956E8-5DBD-462C-858C-A5361777EC1D--UCSC_HPRC_ONT_Y2_GUPPY6 | grep bam$ > gs.bams
#wc -l gs.bam
#350

#sed 's/.*\///' gs.bams | sort > have.gs
#comm -3 have.gs want #perfect files match

#create SRA submission metatdata table
#for i in $(cat sample.list.txt); do echo $i $(grep $i UCSC_HPRC_ONT_Y2_GUPPY6_Metadata_Submission.txt | cut -f1 | tr '\n' ' ' | sed '$s/ $/\n/'); done > sra_file_list.txt

#merge with metadata and existing accession numbers in R
#check for number of files per sample, using the following to return max and min file number
#awk '{print NF}' sra_file_list.txt | sort -nu | tail -n



