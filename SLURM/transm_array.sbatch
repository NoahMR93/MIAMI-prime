#!/bin/bash
#SBATCH -J transm # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1
#SBATCH -p shared # Partition
#SBATCH --mem 8088 # Memory request (9Gb)
#SBATCH -t 0-2:00 # Maximum execution time (D-HH:MM)
#SBATCH -o transm_%A_%a.out # Standard output
#SBATCH -e transm_%A_%a.err # Standard error

# Creating needed directories in the computing node
WORK_DIR=/scratch/${USER}/${SLURM_JOB_ID}/${SLURM_ARRAY_TASK_ID}
mkdir -pv ${WORK_DIR}
mkdir -pv ${WORK_DIR}/INFILES

# Copying input files to the computing node
cd $WORK_DIR
cp ${SLURM_SUBMIT_DIR}/${SLURM_ARRAY_TASK_ID}.xml .
cp ${SLURM_SUBMIT_DIR}/INFILES/${SLURM_ARRAY_TASK_ID}.in INFILES/
cp ${SLURM_SUBMIT_DIR}/INFILES/07212021B_NoART.in INFILES/

# Loading required modules
module load gcc
module load gperftools

# Run the transm model!
/n/seage_lab/sseifi/transm/bin/transm-v4.5.1 --cepac INFILES/ ${SLURM_ARRAY_TASK_ID}.xml

# Copying results back to local directory
cp -rf results_${SLURM_ARRAY_TASK_ID} ${SLURM_SUBMIT_DIR}
rm -rf ${WORK_DIR}
