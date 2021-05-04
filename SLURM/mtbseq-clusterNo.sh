#!/bin/bash 
#SBATCH --job-name=cluster
#SBATCH --partition=workq  #workq is the default and unique queue, you do not need to specify, cuda
##SBATCH --mem=64GB  # amout of RAM in MB required (and max ram available). Xor "--mem-per-cpu"
#SBATCH --time=INFINITE  ## OR #SBATCH --time=10:00 means 10 minutes OR --time=01:00:00 means 1 hour
#SBATCH --ntasks=8  # nubmer of required cores
#SBATCH --nodes=1  # not really useful for not mpi jobs
#SBATCH --mail-type=ALL ## BEGIN, END, FAIL or ALL
#SBATCH --error="mtbseq.err"
#SBATCH --output="mtbseq.out"

source /opt/common/tools/ric.cosr/miniconda3/etc/profile.d/conda.sh

conda activate mtbseq

# see https://bioinformatics.computecanada.ca/question/using-slurm-to-pass-stdin-variables/ how to run this script:
# sbatch --export=A='cluster1.txt' mtbseqEB-cluster.sh

# default
# /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/do_cluster.sh 
# bash do_cluster.sh ${A}

MTBseq  --step TBjoin --continue --samples $A --threads 32 --project $A

