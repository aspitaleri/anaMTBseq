for i in *_R2*.fastq.gz; do basename=`ls $i | cut -d "_" -f 1`;x=$(date +%d%m%y) ; echo $x ; mv $i ${basename}_${x}_150bp_R2.fastq.gz; done

for i in *_R1*.fastq.gz; do basename=`ls $i | cut -d "_" -f 1`;x=$(date +%d%m%y) ; echo $x ; mv $i ${basename}_${x}_150bp_R1.fastq.gz; done

for i in *R1.fastq.gz; do x=` ls $i | cut -d "_" -f1,2` ; echo $x >> samplelist ; done

perl -p -e "s/_/\t/g" samplelist > sample_list

