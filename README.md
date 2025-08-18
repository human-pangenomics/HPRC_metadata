![White Logo](https://s3-us-west-2.amazonaws.com/human-pangenomics/backup/logo-proof-full.png)

## HPRC Sequencing Data Index

This repository contains metadata tables and resources for the Human Pangenome Reference Consortium (HPRC) sequencing datasets. These files provide detailed information on sequencing platforms, coverage, and file organization for ongoing analyses and project tracking.


## /data
1. Clone the repository:
```bash
git clone git@github.com:human-pangenomics/HPRC_metadata.git
```
2. Access metadata files in the data/hprc-data-explorer-tables/ directory.
3. Use these tables to filter, track, or analyze sequencing data.

## /submissions
Folder-based incomplete collection of R2 submissions. Most subfolders contain a readme.md which explains how many files were uploaded to SRA and any known metadata inconsistencies, as well as a validation line for running `validate_and_combine_per_submission.py` which can be found in `/utils` (see below)

## /utils
Contains: 
* general data wrangling scripts and files. Install instructions included it `/utils/readme.md`
* files relating to the AnVIL transfer -- see `/utils/AnVIL_transfer/readme.md` for context
* files relating to the SRA transfer

## Contributing
We welcome contributions to improve metadata organization or add new resources. Submit a pull request or open an issue for discussion.
