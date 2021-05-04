#!/bin/bash
##SBATCH --array=0-3
#SBATCH --ntasks=32
##SBATCH --cpus-per-task=32
#SBATCH --job-name=covtb
#SBATCH --output="covtb.out"
#SBATCH --error="covtb.err"

for file in *position_table.tab
do
   srun -n1 --exclusive bash /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/cov_genes_par.sh $file &
done
wait
touch cov-DONE
echo "cov DONE"

