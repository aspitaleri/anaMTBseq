echo -n "$1 " > gb${1}.tmp
awk '{if( $16 + $17 + $18 + $19 >= 8) print FILENAME}' $1 |  wc -l  >> gb${1}.tmp; 
