#! /bin/bash

#working directory on phoenix cluster
#/private/groups/hprc/UCSC_HPRC_nanopore_Year3

#create first three columns for metadata submissions file, then paste into excel template
#double check remaining columns, especially seqkit, basecaller, basecaller version, and model 
#for i in /private/groups/hprc/UCSC_HPRC_nanopore_Year3/guppy/*/*bam;
    #do echo $(basename $i) $(echo $i | cut -d_ -f8) $(basename $i | cut -d_ -f1-6) \
    #>> metadata_first3columns.txt 
#done



#s3 location for ONT Year3 rebasecalling with mods using guppy 6
#https://s3-us-west-2.amazonaws.com/human-pangenomics/index.html?prefix=submissions/79275EDA-C282-424A-9D5B-A8E876592893--UCSC_HPRC_ONT_Y3_GUPPY6/
#s3 location for ONT Year2 raw data (fast5) 
#https://s3-us-west-2.amazonaws.com/human-pangenomics/index.html?prefix=submissions/9e7a12c3-2df0-4944-a107-b9fd1bf856be--UCSC_HPRC_nanopore_Year3/

#count the number of sample subdirectories in raw data submission
# aws s3 ls  s3://human-pangenomics/submissions/9e7a12c3-2df0-4944-a107-b9fd1bf856be--UCSC_HPRC_nanopore_Year3/  | wc -l
#69

#count the number of fast5 tar files in raw data submissions, there are multiple flowcells per sample
#aws s3 ls --recursive s3://human-pangenomics/submissions/9e7a12c3-2df0-4944-a107-b9fd1bf856be--UCSC_HPRC_nanopore_Year3/  | grep .tar | wc -l
#217

#Check that Guppy6 submission includes files for each
#wc -l UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.txt
#434

#cut -f3 UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.txt | sort | uniq | wc -l
#69

# grep pass.bam UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.txt | wc -l
#217
# grep fail.bam UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.txt | wc -l
#217

#check that files in submission file are in submission directory
#aws s3 ls --recursive s3://human-pangenomics/submissions/79275EDA-C282-424A-9D5B-A8E876592893--UCSC_HPRC_ONT_Y3_GUPPY6/ | grep bam$ > s3.bams
#wc -l s3.bams 
#434

#cut -f1 UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.txt | grep .bam$ | sort -u > want
#sed 's/.*\///' s3.bams | sort > have
#comm -3 have want #perfect files match

#check gs
#gsutil -u hpp-ucsc ls -R gs://fc-4310e737-a388-4a10-8c9e-babe06aaf0cf/submissions/79275EDA-C282-424A-9D5B-A8E876592893--UCSC_HPRC_ONT_Y3_GUPPY6/  | grep bam$ > gs.bams
#wc -l gs.bams
#434

#sed 's/.*\///' gs.bams | sort > have.gs
#comm -3 have.gs want #perfect files match

#create SRA submission metatdata table
#for i in $(cat UCSC_HPRC_ONT_Y3_GUPPY6_samples.tsv); do echo $i $(grep $i UCSC_HPRC_ONT_Y3_GUPPY6_Metadata_Submission.txt | cut -f1 | tr '\n' ' ' | sed '$s/ $/\n/') >> sra_file_list.txt; done

#merge with metadata and existing accession numbers in R
#check for number of files per sample, using the following to return max and min file number
#awk '{print NF}' sra_file_list.txt | sort -nu 
#7
#9 #should use 8 for last filename

#check that release file has been created properly:
#check that all files with GM ids have been placed in NA folders in working
#ubuntu@ip-172-31-5-195:~/HPRC_YEAR3_ONT_Guppy6/6_release$ grep \/GM UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | grep \/working\/HPRC\/NA | wc -l
#177
#ubuntu@ip-172-31-5-195:~/HPRC_YEAR3_ONT_Guppy6/6_release$ grep \/GM UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | wc -l
#177
#ubuntu@ip-172-31-5-195:~/HPRC_YEAR3_ONT_Guppy6/6_release$ grep \/GM UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | grep \/working\/HPRC\/GM | wc -l
#0

#and now for gcp
#ubuntu@ip-172-31-5-195:~/HPRC_YEAR3_ONT_Guppy6/6_release$ grep \/GM UCSC_HPRC_ONT_Y3_GUPPY6.transfer_gcp.csv | grep \/working\/HPRC\/NA | wc -l
#177
#ubuntu@ip-172-31-5-195:~/HPRC_YEAR3_ONT_Guppy6/6_release$ grep \/GM UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | wc -l
#177
#ubuntu@ip-172-31-5-195:~/HPRC_YEAR3_ONT_Guppy6/6_release$ grep \/GM UCSC_HPRC_ONT_Y3_GUPPY6.transfer_gcp.csv | grep \/working\/HPRC\/GM | wc -l
#0

#check the number of files per sample (bams, summary)
#for i in $(cut -d/ -f6 UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | sort | uniq); do grep $i UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | wc -l; done | sort -h
#for i in $(cut -d/ -f6 UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | sort | uniq); do grep $i UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | grep summary.txt.gz | wc -l; done | sort -h
#for i in $(cut -d/ -f6 UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | sort | uniq); do grep $i UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | grep fail.bam | wc -l; done | sort -h
#for i in $(cut -d/ -f6 UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | sort | uniq); do grep $i UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | grep pass | wc -l; done | sort -h
#for i in $(cut -d/ -f6 UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | sort | uniq); do grep $i UCSC_HPRC_ONT_Y3_GUPPY6.transfer_ec2.csv | wc -l; done | sort -h


