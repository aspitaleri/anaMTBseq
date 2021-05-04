
/idle/ric.cirillo/envs/spitaleri.andrea/SOFTW/dos2unix-7.4.2/dos2unix $1

a=$(ls $1 | cut -d "." -f 1)

cp $1 $a

cd Position_Tables


for i in `cat ../$a`; do
	
	ls ${i}_*tab >> ../t; 

done

cd ..

awk -F_ '{print $1,$2}' OFS='\t' t > ${a}.samples

rm -f t 
