echo -n "Rv0678 " > ${1}.cov 
a=`awk -F'\t' '{if(($1>= 778990) && ($1<= 779487 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "Rv0678_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 778890) && ($1<=  778989) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "Rv1979c " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2221719 ) && ($1<=  2223164) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "Rv1979c_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2223165) && ($1<=  2223342) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "Rv2983 " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>=3339118 ) && ($1<= 3339762 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "Rv2983_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>=3339000 ) && ($1<= 3339117 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "ahpc " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2726193 ) && ($1<= 2726780 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "ahpc_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2726088) && ($1<=  2726192) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "atpE " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1461045) && ($1<=  1461290) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "atpE_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1460997) && ($1<= 1461044 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "ddn " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3986844) && ($1<= 3987299 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "ddn_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3986744) && ($1<=  3986843) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "eis " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2714124) && ($1<=  2715332) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "eis_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2715333) && ($1<=  2715471) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "embA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4243233) && ($1<=  4246517) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "embA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4243133) && ($1<= 4243232 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "embB " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4246514) && ($1<= 4249810 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "ethA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4326004) && ($1<= 4327473 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "ethA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4327474) && ($1<=  4327548) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "fabG1 " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1673440) && ($1<= 1674183 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "fabG1_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1673340) && ($1<=  1673439 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "fbiA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3640543) && ($1<=  3641538) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "fbiA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3640142) && ($1<=  3640542) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "fbiB " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3641535) && ($1<=  3642881) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "fbiC " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1302931) && ($1<= 1305501 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "fbiC_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1302682) && ($1<= 1302930 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "fgd1 " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 490783) && ($1<= 491793 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "fgd1_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 490683) && ($1<= 490782 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "furA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2156149) && ($1<=  2156592) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "furA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2156593) && ($1<=  2156705) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "furA-katG " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2156112) && ($1<=  2156148) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "gid " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4407528) && ($1<=  4408202) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  | tr " " "\n" |awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "gid_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4408203) && ($1<=  4408333) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "gyrA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 7302) && ($1<=  9818) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "gyrA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 7268) && ($1<= 7301 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "gyrB " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 5240 ) && ($1<= 7267 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "gyrB_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 4998 ) && ($1<= 5239 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "inhA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1674202) && ($1<=  1675011) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "inhA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1674184) && ($1<= 1674201 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "katG " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2153889) && ($1<=  2156111) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "katG_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2156112) && ($1<= 2156148 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "mmpL5 " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>=775586 ) && ($1<= 778480 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "mmpS5 " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>=778477 ) && ($1<= 778905 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov  
echo -n "panD " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>=4043862 ) && ($1<= 4044281 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov  
echo -n "panD_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>=4044282 ) && ($1<= 4044382 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov  
echo -n "pepQ " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2859300) && ($1<=  2860418) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "pepQ_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2860419) && ($1<=  2860518) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "pnca " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2288681) && ($1<=  2289241) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "pnca_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 2289242) && ($1<=  2289281) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "rplC " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 800809) && ($1<=  801462) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "rplC_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 800793) && ($1<=  800808) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "rpoB " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 759807) && ($1<= 763325 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "rpoB_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 759310) && ($1<= 759806 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "rpsA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1833542) && ($1<= 1834987 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "rpsA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1833380) && ($1<=  1833541) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "rpsL " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 781560) && ($1<=  781934) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "rpsL_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 781312) && ($1<=  781559) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "rrl " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1473658) && ($1<= 1476795 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "rrl_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1473383) && ($1<=  1473657) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "rrs " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1471846) && ($1<=  1473382) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "rrs_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1471743) && ($1<= 1471845 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "thyA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3073680) && ($1<= 3074471 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "thyA_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3074472) && ($1<=  3074635) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "tlyA " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 1917940) && ($1<=  1918746) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk>> ${1}.cov
echo -n "whiB7 " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>=3568401  ) && ($1<=3568679  ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
echo -n "whiB7_ups " >> ${1}.cov
a=`awk  -F'\t' '{if(($1>= 3568680) && ($1<= 3569108 ) ) print $4+$5+$6+$7+$8+$9+$10+$11+$12+$13+$14}' $1`
echo $a  |tr " " "\n" | awk -f /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/stdev1.awk >> ${1}.cov
