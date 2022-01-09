#!/bin/bash
#SBATCH -J transm # A single job name for the array
#SBATCH -n 1 # Number of cores
#SBATCH -N 1
#SBATCH -p shared # Partition
#SBATCH --mem 16000 # Memory request (16Gb)
#SBATCH -t 2-00:00 # Maximum execution time (D-HH:MM)
#SBATCH -o transm_%A_%a.out # Standard output
#SBATCH -e transm_%A_%a.err # Standard error

export WORK_DIR=/scratch/${USER}/${SLURM_JOB_ID}/${SLURM_ARRAY_TASK_ID}
mkdir -pv ${WORK_DIR}
mkdir -pv ${WORK_DIR}/INFILES

cd $WORK_DIR
cp ${SLURM_SUBMIT_DIR}/MIA_1K/MIAMI_test0__batch_${SLURM_ARRAY_TASK_ID}/MIAMI_test0_${SLURM_ARRAY_TASK_ID}.xml ./
cp ${SLURM_SUBMIT_DIR}/transm-v4.6.0 ./

# This is to copy all .in files in case the model requires multiple .in files
cp ${SLURM_SUBMIT_DIR}/INFILES/*.in INFILES/
cp ${SLURM_SUBMIT_DIR}/INFILES/07212021B_NoART.in INFILES/

module load gcc
module load gperftools

#/n/seage_lab/sseifi/transm/bin/transm-v4.5.1 --cepac INFILES/ MIAMI_test0${SLURM_ARRAY_TASK_ID}.xml
./transm-v4.6.0 --cepac INFILES/ MIAMI_test0_${SLURM_ARRAY_TASK_ID}.xml

cp -rf results_MIAMI_test0_${SLURM_ARRAY_TASK_ID} ${SLURM_SUBMIT_DIR}/results
rm -rf ${WORK_DIR}
