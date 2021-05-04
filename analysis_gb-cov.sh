

echo "##### ANALYSIS cov/gb files START #####"

echo "0. Check files :"

gb=`find . -maxdepth 1 -type f  -name "*tab.gb" | wc -l`
cov=`find . -maxdepth 1 -type f  -name "*tab.cov" | wc -l`

if [ $gb -gt 0 ] &&  [ $cov -gt 0 ] && [ $cov == $gb ]; then
	echo -e "\tFound $gb gb files and  $cov cov files"
else 
	echo "No gb/cov files!"
fi


echo "1. Clean old files"
rm -f header
rm -f paste.gb.sh
rm -f paste.cov.sh


echo "2. Make lista files"
[[ $(type -t ls) == "alias" ]] && unalias ls
ls -1 *pos*tab > lista


echo "3. Extract header"
for i in `cat lista`; do echo -n "$i " | awk -F_ '{printf $1" " }' >> header; done
sed -i -e "s/^/gene /g" header 
sed -i -e '$a\' header

echo "4. Create paste.gb.sh file"
for i in `cat lista`; do  echo -n "${i}.gb " >> paste.gb.sh; done
sed -i -e "s/^/paste /g" paste.gb.sh
sed -i -e "s/$/| awk '{ for (i=3;i<=NF;i+=2) \$i=\"\"} 1'/g" paste.gb.sh
bash paste.gb.sh > data.gb
cat header data.gb > data.gb.dat

echo "5. Create paste.cov.sh file"
for i in `cat lista`; do  echo -n "${i}.cov " >> paste.cov.sh; done
sed -i -e "s/^/paste /g" paste.cov.sh
sed -i -e "s/$/| awk '{ for (i=3;i<=NF;i+=2) \$i=\"\"} 1'/g" paste.cov.sh
bash paste.cov.sh > data.cov
cat header data.cov > data.cov.dat

echo "6. Transpose gb/cov and calculate percentage"
awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' data.cov.dat > data.cov.trans

awk '
{ 
    for (i=1; i<=NF; i++)  {
        a[NR,i] = $i
    }
}
NF>p { p = NF }
END {    
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str" "a[i,j];
        }
        print str
    }
}' data.gb.dat > data.gb.trans

a=`head -n 1 data.gb.trans`
echo $a > data.gb.csv
awk '{if ($2 ~ /^[0-9]/) print $1, ($2)/498.00,($3)/100.00,($4)/1446.00,($5)/178.00, ($6)/645.00, ($7)/118.00, ($8)/588.00,($9)/105.00,($10)/246.00,($11)/48.00,($12)/456.00,($13)/100.00,($14)/1209.00,($15)/139.00,($16)/3285.00,($17)/100.00,($18)/3297.00,($19)/1470.00,($20)/75.00,($21)/744.00,($22)/100.00,($23)/996.00,($24)/401.00,($25)/1347.00,($26)/2571.00,($27)/249.00,($28)/1011.00,($29)/100.00,($30)/444.00,($31)/113.00,($32)/37.00,($33)/675.00,($34)/131.00,($35)/2517.00,($36)/34.00,($37)/2028.00,($38)/242.00,($39)/810.00,($40)/18.00,($41)/2223.00,($42)/37.00,($43)/2895.00,($44)/429.00,($45)/420,($46)/100,($47)/1119.00,($48)/100.00,($49)/561.00,($50)/40.00,($51)/654.00,($52)/16.00,($53)/3519.00,($54)/497.00,($55)/1446.00,($56)/162.00,($57)/375.00,($58)/248.00,($59)/3138.00,($60)/275.00,($61)/1537.00,($62)/103.00,($63)/792.00,($64)/164.00,($65)/807.00,($66)/279.00,($67)/429.00}' data.gb.trans >> data.gb.csv

echo "7. Convert to tab files"
sed -e 's/ /\t/g' data.cov.trans > data.cov.tab
sed -e 's/ /\t/g' data.gb.csv > data.gb.tab1


#echo "8. Queuing Genome Breadth total (have a coffee ...)"


#Calculate Genome Wide Breadth of Coverage and Depth of Coverage
#for file in *position_table.tab ; do 
#	echo -n "$file " >> gb;
#	awk '{if( $16 + $17 + $18 + $19 >= 8) print FILENAME}' $file |  wc -l >> gb; 
#done

echo "8. Genome Breadth all in one"
#to calculate percentage
cat gb |  awk '{printf "%d %.2f\n",$2,($2/4411532)*100}' OFS="\t" > perc_gb.csv
echo -e "GB\tGBperc" > perc_gb.tab
sed -e 's/ /\t/g' perc_gb.csv >> perc_gb.tab

paste data.gb.tab1 perc_gb.tab > data.gb.tab

echo "9. Put all in one file"
paste data.gb.tab data.cov.tab > gb_cov.tab
#tab2xls gb_cov.tab > gb_cov.xls

echo "10. Clean temporary files"
rm -f data.cov data.gb paste.gb.sh paste.cov.sh header data.gb.trans data.gb.dat data.gb.csv data.cov.dat data.cov.trans perc_gb.tab perc_gb.csv data.gb.tab1


echo "##### ANALYSIS cov/gb files END #####"
