#!/bin/bash
##SBATCH --array=0-3
#SBATCH --ntasks=32
##SBATCH --cpus-per-task=32
#SBATCH --output="gbfulltb.out"
#SBATCH --error="gbfulltb.err"
#SBATCH --job-name=gbfulltb

for file in *position_table.tab
do
   srun -n1 --exclusive bash /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/gb_full_par.sh $file &
done
# need to fix it the append mode
#cat gb*tmp >> gb
wait
cat gb*tmp > gb
rm -f gb*.tmp
touch gb_full-DONE
echo "gb_full DONE"
