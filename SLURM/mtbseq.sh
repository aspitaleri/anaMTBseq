#!/bin/bash 
#SBATCH --job-name=mtbseq
#SBATCH --partition=workq  #workq is the default and unique queue, you do not need to specify, cuda
##SBATCH --mem=64GB  # amout of RAM in MB required (and max ram available). Xor "--mem-per-cpu"
#SBATCH --time=INFINITE  ## OR #SBATCH --time=10:00 means 10 minutes OR --time=01:00:00 means 1 hour
#SBATCH --ntasks=32  # nubmer of required cores
#SBATCH --nodes=1  # not really useful for not mpi jobs
#SBATCH --mail-type=ALL ## BEGIN, END, FAIL or ALL
#SBATCH --error="mtbseq.err"
#SBATCH --output="mtbseq.out"

source /opt/common/tools/ric.cosr/miniconda3/etc/profile.d/conda.sh

conda activate mtbseq

A=`date +"%d%b%y%a%H%M%S"`
# DRS low freq
#MTBseq --step TBfull --continue --mincovf 1 --mincovr 1 --lowfreq_vars --minfreq 5 --minphred20 1 --samples sample_list --threads 32
MTBseq --step TBbwa --mincovf 1 --mincovr 1 --lowfreq_vars --minfreq 5 --minphred20 1 --samples sample_list --threads 32
MTBseq --step TBrefine --mincovf 1 --mincovr 1 --lowfreq_vars --minfreq 5 --minphred20 1 --samples sample_list --threads 32
MTBseq --step TBpile --mincovf 1 --mincovr 1 --lowfreq_vars --minfreq 5 --minphred20 1 --samples sample_list --threads 32
MTBseq --step TBlist --mincovf 1 --mincovr 1 --lowfreq_vars --minfreq 5 --minphred20 1 --samples sample_list --threads 32
MTBseq --step TBvariants --mincovf 1 --mincovr 1 --lowfreq_vars --minfreq 5 --minphred20 1 --samples sample_list --threads 32
#/idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/analysisMTBseq.sh -p 10
# default
MTBseq  --step TBvariants --continue --samples sample_list --threads 32 --project proj$A

# analysis
#/idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/analysisMTBseq.sh -c

/idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/analysisMTBseq.sh -g

