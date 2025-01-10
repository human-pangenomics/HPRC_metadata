#!/bin/bash
#SBATCH --job-name=cram_download     # Job name
#SBATCH --output=cram_download_%j.out  # Output file
#SBATCH --error=cram_download_%j.err   # Error file
#SBATCH --time=4:00:00               # Time limit (e.g., 4 hours)
#SBATCH --ntasks=1                   # Number of tasks
#SBATCH --cpus-per-task=4            # Number of CPU cores per task
#SBATCH --mem=16G                    # Memory (e.g., 16 GB)
#SBATCH --partition=long         # SLURM partition (adjust based on your SLURM setup)

bash pull.tsv
