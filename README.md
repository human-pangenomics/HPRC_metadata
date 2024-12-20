![White Logo](https://s3-us-west-2.amazonaws.com/human-pangenomics/backup/logo-proof-full.png)

## HPRC Sequencing Data Index

This repository contains metadata tables and resources for the Human Pangenome Reference Consortium (HPRC) sequencing datasets. These files provide detailed information on sequencing platforms, coverage, and file organization for ongoing analyses and project tracking.

File Path	Description
HPRC_ONT.file.index.csv	Oxford Nanopore (ONT) R9/R10 uBams, including methylation tags.
HPRC_PacBio_HiFi.file.index.csv	PacBio HiFi CCS uBams for Sequel II and Revio instruments, with DeepConsensus v1.2 data.
HPRC_DeepConsensus.file.index.csv	DeepConsensus v1.2 post-processed files for PacBio HiFi reads, providing high-confidence data.
HPRC_HiC.file.index.csv	Hi-C Fastq.gz files for all samples, used for chromosome conformation analysis.
HPRC_Illumina_Child.sample.index.csv	Illumina CRAMs from the 1000 Genomes High Coverage dataset, for short-read sequencing.

## Usage
1. Clone the repository:
```bash
git clone git@github.com:human-pangenomics/HPRC_metadata.git
```
2. Access metadata files in the data/hprc-data-explorer-tables/ directory.
3. Use these tables to filter, track, or analyze sequencing data.


## Contributing
We welcome contributions to improve metadata organization or add new resources. Submit a pull request or open an issue for discussion.