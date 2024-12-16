![White Logo](https://s3-us-west-2.amazonaws.com/human-pangenomics/backup/logo-proof-full.png)

## HPRC Sequencing Data Index

This repository contains metadata tables and resources for the Human Pangenome Reference Consortium (HPRC) sequencing datasets. These files provide detailed information on sequencing platforms, coverage, and file organization for ongoing analyses and project tracking.


## HPRC Data Explorer Tables

| File Path                                  | Description                                                                                     |
|--------------------------------------------|-------------------------------------------------------------------------------------------------|
| `HPRC_ONT.file.index.csv`                  | Oxford Nanopore (ONT) R9/R10 uBAM, including methylation tags.                                 |
| `HPRC_PacBio_HiFi.file.index.csv`          | PacBio HiFi CCS uBAMs for Sequel II and Revio instruments, including methylation tags.        |
| `HPRC_DeepConsensus.file.index.csv`        | DeepConsensus v1.2 post-processed files for PacBio HiFi Sequel II reads.  |
| `HPRC_HiC.file.index.csv`                  | Hi-C Fastq.gz files for all samples used for chromosome conformation analysis.                |
| `HPRC_Illumina_Child.sample.index.csv`     | Illumina CRAMs from the 1000 Genomes High Coverage dataset for short-read sequencing.          |

#### Key Features
Detailed metadata for HiFi, ONT, Hi-C, and Illumina datasets.
Includes sequencing coverage, file paths, and platform-specific information.
Designed for easy integration into pangenome assembly and analysis pipelines.

------------------
## Contributing
We welcome contributions to improve metadata organization or add new resources. Submit a pull request or open an issue for discussion.
