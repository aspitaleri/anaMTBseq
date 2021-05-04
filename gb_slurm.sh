#!/bin/bash
##SBATCH --array=0-3
#SBATCH --ntasks=32
##SBATCH --cpus-per-task=32
#SBATCH --output="gbtb.out"
#SBATCH --error="gbtb.err"
#SBATCH --job-name=gbtb

for file in *position_table.tab
do
   srun -n1 --exclusive bash /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/gb_genes_par.sh $file &
done
wait
touch gb-DONE
echo "gb DONE"
