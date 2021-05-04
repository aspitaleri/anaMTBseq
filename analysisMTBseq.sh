#!/bin/bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:

PWD=`pwd`

check () {

	if [ -d Called ]; then
		PWD=`pwd`;
		echo -e "\t\e[92m<<<Working Dir is $PWD>>>"
		tput sgr0
	else
		echo -e "\t\e[91m<<<WARNING RUN analysisMTBseq.sh in the root dir of MTBseq job>>>"
		tput sgr0
		exit
	fi
}

show_help () {
	echo -e "\e[93m##########################################################"
	tput sgr0
	echo -e "\t\t\e[7mMTBseq run and downstream analysis\n\t\e[91mMAKE SURE TO RUN IT IN THE DIR OF MTBseq RUN\n\t\tVersion 0.7\t>> SLURM edition <<"
	tput sgr0
	echo "Options: "
	echo "-h show this help"
	echo "-r run MTBseq standard job (DRS+phylo). This includes -g option too"
	echo "-n <file> run matrix calculation on a strain subset. Ex: -n cluster1.txt"
	echo "-q strain1,strain2,strain3 run matrix calculation on a strain subset. Ex: q POR5,POR51,POR10"
	echo "-p <treshold> DRS analysis in Called. Ex: -p 10"
	echo "-c clean statistic, classification and matrix files (xlsx output)"
	echo "-m <file> custom cluster matrix analysis (xlsx output). Contains a single column list of strains. Ex: -m cluster1"
	echo "-g run genome breadth and coverage analysis in Position Tables"
	echo "-l <threshold> run linkage clustering on matrix. Ex -l 3"
	echo -e "-a statistical analysis. \e[91mUse this option ONLY AFTER -g OPTION"
	tput sgr0
	echo "-d run default analysis all in one (not yet)"
	echo -e "\e[93m##########################################################"
	tput sgr0

}


outputdir () {

	check
	data=`date +%d%m%y`
# to create sequencial output dir	
#	while ! mkdir OUTPUT_${data}_$n 2> /dev/null; do     n=$((n+1)); done 

#	if [ ! -d OUTPUT_${data} ]; then
	if [ ! -d OUTPUT ]; then
	
		mkdir OUTPUT
	fi
}

pharma () {
	
	check
	outputdir

	cd Called
	echo "Running pharma_gene_format using treshold: "$1
#	rm -f pharma_gene.tab
	perl /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/pharma_gene_format.pl -t $1 -p -f
	perl /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/csv2xls.pl pharma_gene_format_${1}.tab pharma_gene_format_${1}.xls 
	
	mv pharma_gene_format_${1}.tab ../OUTPUT
	mv pharma_gene_format_${1}.xls ../OUTPUT

# last column is not present in the xls file	
#	tab2xls pharma_gene_format_${1}.tab > pharma_gene_format_${1}.xls
	cd ..
}



gb_cov () {
	
	check
	outputdir

	cd Position_Tables
	[[ $(type -t ls) == "alias" ]] && unalias ls
	ls -1 *pos*tab > lista1
	ls -1 *pos*tab.cov 2>/dev/null | awk -F'.cov' '{print $1}' > lista.cov
	ls -1 *pos*tab.gb 2>/dev/null | awk -F'.gb' '{print $1}' > lista.gb
	cat lista.cov lista.gb lista1 |sort -V | uniq  -c | awk '{if($1 != 3) print $2}' > lista
	num=`wc -l lista | awk '{print $1}'`
#	cp /lustre1/workspace/Cirillo/SCRIPTS/Andrea/BASH/analysis_gb-cov.sh .
	if [ -f gb-DONE ] && [ -f cov-DONE ] && [ -f gb_full-DONE ] && [ $num -eq 0 ]; then
		echo -e "Genome Breadth and Coverage already done for all strains\nExiting ...\nNow:\nanalysisMTBseq.sh -a"
		exit;
	else
		echo "Submitting Genome Breadth and Coverage for $num strains: "
#	cp /lustre1/workspace/Cirillo/SCRIPTS/Andrea/BASH/gb_pbs.sh .
	cp /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/gb_slurm.sh .
#	cp /lustre1/workspace/Cirillo/SCRIPTS/Andrea/BASH/gb_full_pbs.sh .
	cp /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/gb_full_slurm.sh .
#	cp /lustre1/workspace/Cirillo/SCRIPTS/Andrea/BASH/cov_pbs.sh .
	cp /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/cov_slurm.sh .
		cat lista
		sbatch gb_slurm.sh
		sbatch gb_full_slurm.sh
		sbatch cov_slurm.sh
	fi
	echo "Running genome breadth and coverage per single genes and full"
	cd ..
}

anal () {
	
	check
	outputdir
	
	cd Position_Tables/
	echo "Going to run analysis"
#	num=`cat lista.cov lista.gb lista1 |sort -V | uniq  -c | awk '{if($1 != 3) print $2}' | wc -l lista | awk '{print $1}'`
#	if [ -f gb-DONE ] && [ -f cov-DONE ] && [ -f gb_full-DONE ] && [ $num -ne 0 ]; then
	if [ -f gb-DONE ] && [ -f cov-DONE ] && [ -f gb_full-DONE ]; then
		bash /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/analysis_gb-cov.sh
		touch ana-DONE
	else
		echo "All strains have been analyzed or you forgot to run analysis_MTBseq.sh -g"
		exit;
	fi
	
	
	perl /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/csv2xls.pl gb_cov.tab gb_cov.xls 
	cd ..
	cd OUTPUT
	if [ -f data.cov.tab ] && [ -f data.gb.tab ] && [ -f gb_cov.tab ] && [ -f gb_cov.xls ]; then
		mv data.cov.tab data.cov.tab.bk
		mv data.gb.tab data.gb.tab.bk
		mv gb_cov.tab gb_cov.tab.bk
		mv gb_cov.xls gb_cov.xls.bk
			
		mv ../Position_Tables/data.cov.tab .
		mv ../Position_Tables/data.gb.tab .
		mv ../Position_Tables/gb_cov.tab .
		mv ../Position_Tables/gb_cov.xls .

	else
		mv ../Position_Tables/data.cov.tab .
		mv ../Position_Tables/data.gb.tab .
		mv ../Position_Tables/gb_cov.tab .
		mv ../Position_Tables/gb_cov.xls .
	fi
#	awk '{if ($1 !~ /^gene/) for(i=2;i<=59;i++) t+=$i; print $1,t; t=0}' data.gb.tab | awk '{if($2<58) print $0}'
	cd ..
	
}	



clean () {

	check
	outputdir

	cd Statistics/
	sed -e "s/'//g" Mapping_and_Variant_Statistics.tab >  Mapping_and_Variant_Statistics-clean.tab 
	cd ..
	cd Classification/
	sed -e "s/'//g" Strain_Classification.tab >  Strain_Classification-clean.tab
	cd ..

	paste Statistics/Mapping_and_Variant_Statistics-clean.tab Classification/Strain_Classification-clean.tab > OUTPUT/Mapping_Classification.tab
	
	cd OUTPUT/
	perl /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/csv2xls.pl Mapping_Classification.tab Mapping_Classification.xls
	cd ..

	source /idle/ric.cirillo/envs/ric.cirillo/python3-users/bin/activate
	
	cd Groups/
	
#	a=(*cf4*.matrix)
#	size=`echo ${#a[@]}`
#	if [ $size -gt  1 ]; then	
#		for f in "${a[@]}"; do
#			python /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/clean_matrix.py $f
#			mv *_matrix.csv ../OUTPUT
#			mv *_matrix.xls ../OUTPUT
#		done
#	else
#		echo "No cf4 matrix found"
#	fi

	a=(`find . -name "*cf4*.matrix" -type f -printf "%f\n"`)
	
	size=`echo ${#a[@]}`
	
	if [ $size -eq 0 ]; then
		echo "Not cf4 matrix files found - No matrix files generated"
	else
		echo "$size cf4 matrix found:"
		printf '> %s\n' "${a[@]}"
	fi
	
	for i in `find . -name "*cf4*.matrix" -type f -printf "%f\n"`; do  
		
		if [ -f $i ]; then 

			python /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/clean_matrix.py $i
			mv *_matrix.csv ../OUTPUT
			mv *_matrix.xlsx ../OUTPUT
		else
	
			echo "No cf4 matrix files found"
		fi
	done

	cd ..
	
#	deactivate

# last column is not present in the xls file	
#	tab2xls Mapping_Classification.tab > Mapping_Classification.xls

}



cluster () {


        source /idle/ric.cirillo/envs/ric.cirillo/python3-users/bin/activate

        cd Groups/

        a=(`find . -name "*cf4*.matrix" -type f -printf "%f\n"`)

        size=`echo ${#a[@]}`

        if [ $size -eq 0 ]; then
                echo "Not cf4 matrix files found - No matrix files generated"
        else
                echo "$size cf4 matrix found:"
#                printf '> %s\n' "${a[@]}"
        fi

	select opt in "${a[@]}" "Stop the script"; do
  		case $opt in
    		*cf4*.matrix)
      		echo "Matrix file $opt selected"
		python /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/cluster.py $opt $1
                mv *_cluster-*.csv ../OUTPUT
		mv *_cluster_element-*.csv ../OUTPUT
      		;;
    		"Stop the script")
      		echo "You chose to stop"
      		break
      		;;
    		*)
     		echo "This is not a number"
      		;;
  		esac
	done
	
#       for i in `find . -name "*cf4*.matrix" -type f -printf "%f\n"`; do
#
#                if [ -f $i ]; then
#
#                        python /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/cluster.py $i $1
#                        mv *_cluster.csv ../OUTPUT
#                        mv *_cluster_element.csv ../OUTPUT
#                else
#
#                        echo "No cf4 matrix files found"
#                fi
#        done
#
        cd ..

}



anamatrix () {

	check
	outputdir

	source /idle/ric.cirillo/envs/ric.cirillo/python3-users/bin/activate
	
	cd Groups/
	
	a=(`find . -name "${1}*cf4*.matrix" -type f -printf "%f\n"`)

	python /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/clean_matrix.py $a

	mv ${1}*_matrix.xls ../OUTPUT
	mv ${1}*_matrix.csv ../OUTPUT
	
	cd ..
	
}

runmatrix () {

	check
	outputdir

	id=`whoami`
	email=${id}@hsr.it

	cp /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/SLURM/mtbseq-cluster.sh .

	if [ $id == "cabibbe.andreamauriz" ]; then
	
		email="cabibbe.andreamauirizio@hsr.it"
	fi

	file=$1

	sbatch --account=$id --mail-user=$email --export=A=$file mtbseq-cluster.sh

}


runmatrixNo () {

	check
        outputdir

        id=`whoami`
        email=${id}@hsr.it

        cp /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/SLURM/mtbseq-clusterNo.sh .

        if [ $id == "cabibbe.andreamauriz" ]; then

                email="cabibbe.andreamauirizio@hsr.it"
        fi


	cd Position_Tables


	for i in *gatk_position_table.tab; do

        	ls ${i} >> ../t;

	done

	cd ..

	awk -F_ '{print $1,$2}' OFS='\t' t > tt

	rm -f t
	
	sample=tt
	
	array="${@}"

	IFS=',' read -ra list <<< $array

	echo "Removing $array from list"

	#check it before

	for i in "${list[@]}"; do

		A=`grep -q -w $i $sample 2>&1`

		if [ $? -gt 0 ]; then

					
			echo -e "\t\e[91mERROR: $i does not exist in Position_Tables"
			echo -e "\tExiting - Check string input";
			rm -f tt
			tput sgr0
			exit;
		fi
	done

	# do backup first

	bar=$(IFS=- ; echo "${list[*]}")
	
	mv $sample sample_list-no${bar}

	for i in "${list[@]}"; do
		sed -i "/\<$i\>/d" sample_list-no${bar}
	done

	rm -f tt

#	sbatch --account=$id --mail-user=$email --export=A=${list[@]} mtbseq-clusterNo.sh
	sbatch --account=$id --mail-user=$email --export=A=sample_list-no${bar} mtbseq-clusterNo.sh
}


run () {

	if ! ls *fastq.gz 1>/dev/null; then
		echo -e "\e[91m>>>No fastq.gz files in the dir. Exiting<<<"
		tput sgr0
		exit 1
	fi	

	A=`date +"%d%b%y%a%H%M%S"`
	
	id=`whoami`
	email=${id}@hsr.it

	cp /idle/ric.cirillo/envs/ric.cirillo/anaMTBseq/SLURM/mtbseq.sh .

	if [ $id == "cabibbe.andreamauriz" ]; then
	
		email="cabibbe.andreamaurizio@hsr.it"
	fi

	if [ -f "sample_list" ]; then 

		cp sample_list .sample_list.bkp_${A}
	fi
	
	for i in *_R2*.fastq.gz; do basename=`ls $i | cut -d "_" -f 1`;x=$(date +%d%m%y) ; echo $x ; mv $i ${basename}_${x}_150bp_R2.fastq.gz; done
	
	for i in *_R1*.fastq.gz; do basename=`ls $i | cut -d "_" -f 1`;x=$(date +%d%m%y) ; echo $x ; mv $i ${basename}_${x}_150bp_R1.fastq.gz; done

	for i in *R1.fastq.gz; do x=` ls $i | cut -d "_" -f1,2` ; echo $x >> samplelist ; done

	perl -p -e "s/_/\t/g" samplelist > sample_list
	
	
	sbatch --account=$id --mail-user=$email mtbseq.sh
}

stat () {

	check

	cd Position_Tables
	a=`wc -l lista1 | awk '{print $1}'`
	b=`ls *tab.cov|wc -l`	
	c=`ls *tab.gb|wc -l`	
	
	if [ $a -eq $b ] && [ -f cov-DONE ]; then
		echo "coverage done";
	else
		echo "$b coverage out of $a"
	fi

	if [ $a -eq $c ] && [ -f gb-DONE ]; then
 		echo "genome breadth done";
	 else
	 	echo "$c genome breadth out of $a"
	 fi


	cd ..
}


# using default function should do all the analysis in a single step
default () {

	echo "Not yet"

}


while getopts "h?p:gacdsm:rn:q:l:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    p)	pharma $OPTARG
	exit 0
        ;;
    l) cluster $OPTARG
	exit 0
	;;
    g)  gb_cov 
	exit 0
        ;;
#    s)  stat
#        ;;
    a)  anal
	exit 0
	;;
    c)  clean
	exit 0
	;;
    m)  anamatrix $OPTARG
	exit 0
	;;
    n) runmatrix $OPTARG
	exit 0
	;;
    q) runmatrixNo ${OPTARG}
	exit 0
	;;
    r) run
	exit 0
	;;
    d) default
	;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift
