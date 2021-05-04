use warnings;
#use lib '/home/aspitaleri/perl_modules/lib/perl5';
use lib '/idle/ric.cirillo/envs/ric.cirillo/perl5/lib/perl5';
use Data::Dumper qw(Dumper);
#use List::Util;
use List::Util qw(sum);
use List::Util qw( min max );
use Set::IntSpan;
use Getopt::Std;
use POSIX;
use lib '/idle/ric.cirillo/envs/ric.cirillo/perl5/Module';
# This contains all the genes used in the pharma resistance update to 13/12/2018
use Genes;
$version="0.6a";


getopts('vght:pfc',\%opt);


if ($opt{h}) {
    print "Version $version\n";
    print "-h \t shows this help\n";
    print "-g \t shows the genes db used and exit\n";
    print "-t \t set treshold frequency values. Default 10\n";
    print "-p \t overwrite pharma_gene.tab. Default no\n";
    print "-f \t overwrite pharma_gene_<treshold>.tab. Default no\n";
    print "-c \t if set cf4_cr4_fr75_ph4 tab files are analysed. Default it is no and cf1_cr1_fr5_ph1 are analysed\n";
    print "-v \t make the analysis verbose\n";
    exit;
}


if ($opt{t}) {
    $thresh=$opt{t};
    print "Using $thresh % as treshold\n";
}else{
    $thresh=10;
    print "Using default treshold 10 %\n";
}

if ($opt{g}) {
    print "gene -> Coord1 Coord2\n";
    $n=1;
    foreach $k (sort{$a cmp $b} keys %H) {
	if ($H{$k}[0] < $H{$k}[1]) {
	    print "$n $k  [$H{$k}[2]] -> ";
	    print " @{$H{$k}}";
	    $n++;
	    print "\n";
	}else{
	    print "$k ";
	    print "First column value has to be lower than second.\nCheck the order ...\n";
	    exit;
	}
    }
    exit;
}


unless (-f "pharma_gene.tab") {
    
    open(OUT,">pharma_gene.tab") or die "$!";
    
}else{
    if($opt{p}) {
	print "Overwriting pharma_gene.tab\n";
	open(OUT,">pharma_gene.tab") or die "$!";
    }else{

	print "File pharma_gene.tab exists\n";
	
	exit;
    }
}

unless (-f "pharma_gene_format_$thresh\.tab") {
    
    open(OUT1,">pharma_gene_format_$thresh\.tab") or die "$!";
    
}else{
    if($opt{f}) {
	print "Overwriting pharma_gene_$thresh\.tab\n";
	open(OUT1,">pharma_gene_format_$thresh\.tab") or die "$!";
    }else{
	
	print "File pharma_gene_format_$thresh\.tab exists\n";
	
	exit;
    }
}


if($opt{c}) {
    
    @tabfiles=glob('*variants_cf4_cr4_*.tab');
    print "Using variants_cf4_cr4_fr75 files\n";
}else{
 
    @tabfiles=glob('*variants_cf1_cr1_*.tab');
    print "Using variants_cf1_cr1_fr5 files\n";
}

$n_tabfiles= scalar @tabfiles;

if ($n_tabfiles == 0) {

    print "Neither variants*cf1.tab or variants*cf4 files found.\n";
    exit;
    
}else{
    
    print "Number of strains is $n_tabfiles\n";
}



for $i (@tabfiles) {
    
    #    $i = shift;
    
    open(FL,"$i") or die "$!";

    @file=<FL>;
    
    # remove header #Pos 
    shift @file;
    
    for $l (@file)  {
	
	chomp($l);
	
	@tmp1=split(/\t/,$l);
	
	foreach $k (keys %H) {
	    
	    if(($tmp1[0] >= $H{$k}[0]) && ($tmp1[0] <= $H{$k}[1])) {
		
		#		    @ntmp1 = join("\t",@tmp1);
		print OUT "$i \t $l\t$k\t$H{$k}[2]\n";
		$count{$k}+=1;
		$count1{$tmp1[12]}+=1;
		
	    }
	}
    }
}

close(OUT);

# VERBOSE

if ($opt{v}) {
    foreach $p (keys %count) {
	if (exists $count1{$p}) {
	    print "OK> $p $count{$p} $count1{$p}\n";
	    ++$ok;
	}else{
	    print "WARNING> $p $count{$p} nan\n";
	    ++$warning;
	}
    }
    
    print "$ok okay, $warning warnings ..\n";
}



print "Now formatting output ...\n";

open(FL1,"pharma_gene.tab") or die "$!";

while($l=<FL1>) {
    chomp($l);

    @tmp=split(/\t/,$l);
    $filetab=$tmp[0];
    $coord=$tmp[1];
    $index=$tmp[2];
    $ref=$tmp[3];
    $type=$tmp[4];
    $mut=$tmp[5];
    $snp = join ">",$ref,$mut;
    #    $subst=$tmp[11];
    @st=split(/\(/,$tmp[11]);
    $subst=$st[0];
    #need white space after freq
    $freq=join("",$tmp[9]," ");
    $gene_name=$tmp[18];
#    $locus=$tmp[19];
#    $gene_name=$tmp[13];
#    $gene=$tmp[12];
    # IR is the antibiotic
    $IR=$tmp[17];
    $c=1;
    
    @temp=split('_',$filetab);
    $ID=$temp[0];	
    
    # GeneName exists
    # check for both version with empty space and with -
    #    if (($gene_name ne " ") && ($gene_name ne "-")) {
    
    
    # Subst EXISTS -> use Subst. Only coding gene!
    if ($subst ne " ") {

	# Check whether the frequency is in the  treshold < range < 75 and write it. Under treshold write nothing. If rrl and rrs keep only if > 75%
#	if (($freq < 75) && ($freq>$thresh) && ($gene_name ne "rrl") && ($gene_name ne "rrs")) {
	if (($freq < 75) && ($freq>$thresh)) {	    
	    #remove white space from subst
	    chop($subst);
	    $subst = join(":",$subst,$freq);
	    # Keep clean rrl and rrs genes under 75% frequency
	    
=pod	
	}elsif (($freq<75) && (($gene_name eq "rrl") || ($gene_name eq "rrs"))) {
	    $ncoord="";
=cut
	}elsif($freq<=$thresh) {
	    $subst = "";
	}

	# Start to populate rows hash with subst. ID->gene_name->@(subst)
	push( @{ $rows{$ID}{$gene_name} }, $subst);
	
#	$found{$gene_name}++;
	$a=++$c{$ID};
	
	push (@IR,$IR);
	$IR{$IR}+=1;
	++$count;
	# Subst does NOT EXIST -> use coordinate. 
	# NEED TO CHECK WHETHER IT IS INS/DEL/SNP
    }elsif($subst eq " ") {
	
	# If index is > 0 then we have a Peptide/Amino acid Ins 
	if (($index > 0) && ($type eq "Ins")) {

#	    if (($freq<75) && ($freq>$thresh)  && ($gene_name ne "rrl") && ($gene_name ne "rrs")) {
	    
	    # hash P contains the array mutation residues. ID->coord->gene_name->@(residues)
	    push ( @ {$P{$ID}{$coord}{$gene_name}}, $mut);
#	    print "Ins> $ID $coord $gene_name $mut\n";
	    #	    }
	    
	    # If index == 0 then we have a SINGLE SNP/Del residue    
	}elsif($index == 0) {

	    #	    if (($freq>$thresh)  && ($gene_name ne "rrl") && ($gene_name ne "rrs")) {
	    #	    if (($freq>$thresh)  && ($gene_name ne "rrl")) {
	    if (($freq>$thresh) && ($type eq "SNP")) {
		
		
		# check for SNP
		#		if ($type eq "SNP") {
		
		if ($freq < 75) {
		    
		    if($gene_name =~ /ups/) {
			if ($H{$gene_name}[4] eq "forw" ) {		
			    $rel_coord=$H{$gene_name}[1]+1-$coord;
			    #			    $coord=$rel_coord;
			    $snp1=join("",$rel_coord,$mut);
			    $_ncoord = join("-", $ref,$snp1,$coord);
			    $ncoord = join(":",$_ncoord,$freq);
			    #			    print "$ID $gene_name $coord ", $H{$gene_name}[1]+1," -$rel_coord $ncoord $freq\n";
			}elsif($H{$gene_name}[4] eq "rev" ) {
			    $rel_coord=abs($H{$gene_name}[0]-1-$coord);
			    #			    $coord=$rel_coord;
			    $snp1=join("",$rel_coord,$mut);
			    $_ncoord = join("-", $ref,$snp1,$coord);
			    $ncoord = join(":",$_ncoord,$freq);
			    #			    print "$ID $gene_name $coord ", $H{$gene_name}[0]-1," +$rel_coord $ncoord $freq\n";
			}
		    }else{
			
			$ncoordT = join("_", $coord,$snp,"SNP");
			$ncoord = join(":", $ncoordT,$freq);
		    }
		    
		}elsif($freq >= 75) {

		    if($gene_name =~ /ups/) {
			if ($H{$gene_name}[4] eq "forw" ) {		
			    $rel_coord=$H{$gene_name}[1]+1-$coord;
#			    $coord=$rel_coord;
			    $snp1=join("",$rel_coord,$mut);
			    $ncoord = join("-", $ref,$snp1,$coord);
#			    print "$ID $gene_name $coord ", $H{$gene_name}[1]+1," -$rel_coord $ncoord $freq\n";
			}elsif($H{$gene_name}[4] eq "rev" ) {
			    $rel_coord=abs($H{$gene_name}[0]-1-$coord);
#			    $coord=$rel_coord;
			    $snp1=join("",$rel_coord,$mut);
			    $ncoord = join("-", $ref,$snp1,$coord);
#			    print "$ID $gene_name $coord ", $H{$gene_name}[0]-1," +$rel_coord $ncoord $freq\n";
			}
		    }else{
			$ncoord = join("_", $coord,$snp,"SNP");
		    }
		}
		
		push ( @ {$rows{$ID}{$gene_name}}, $ncoord);
		    
		    # check for Del
#		}
		#elsif($type eq "Del") {

#			push ( @ {$TTT{$ID}{$gene_name}}, $freq);
#			push ( @ {$T{$ID}{$gene_name}}, $coord);
#			push ( @ {$TT{$ID}{$gene_name}}, $ref);
		    
#			print "$ID $coord $gene_name DEL\n";
		    
		#		}
=pod		
	    }elsif (($freq<75) && (($gene_name eq "rrl") || ($gene_name eq "rrs"))) {
		$ncoord="";
=cut
	    }elsif(($freq<=$thresh) &&($type eq "SNP")){
		$ncoord="";
	    }
	    
	    if(($type eq "Del") && ($freq > $thresh)) {
		
		    #		    $ncoord = join("_", $coord,$freq);
		
		
		push ( @ {$T{$ID}{$gene_name}}, $coord);
		push ( @ {$TT{$ID}{$gene_name}}, $ref);
		#		push ( @ {$TTT{$ID}{$gene_name}}, ceil($freq));
		push ( @ {$TTT{$ID}{$gene_name}}, $freq);
#		push ( @ {$TTTT{$ID}{$gene_name}{$coord}}, $freq);
#		print "$ID $gene_name $coord DEL @{$TTTT{$ID}{$gene_name}{$coord}}\n";
		
	    }
	    
	    
	}
	
=pod OK	
	if ($index > 0) {
	    #first we join the element of the Ins peptide: A,C,G,C to ACGC
	    $pept = join("",@{$P{$ID}{$coord}{$gene_name}});
	    print "$ID $coord $gene_name $pept\n";
	    $nP{$ID}{$coord}{$gene_name} = $pept;
	}
=cut OK

	#NEW CODE FROM HERE for INS
	if ($index > 0) {
	    #first we join the element of the Ins peptide: A,C,G,C to ACGC
	    $pept = join("",@{$P{$ID}{$coord}{$gene_name}});


	    #	    if (($freq<75) && ($freq>$thresh)  && ($gene_name ne "rrl") && ($gene_name ne "rrs")) {
	    if (($freq<75) && ($freq>$thresh)) {
		$npeptT=join("_",$coord,$pept,"INS");
		$npept=join(":",$npeptT,$freq);
		$nP{$ID}{$coord}{$gene_name} = $npept;
		if($opt{v}){
		    print "INS $ID $coord $gene_name $pept $freq\n";
		}
	    }
	    elsif( $freq > 75) {
		$npept=join("_",$coord,$pept,"INS");
		$nP{$ID}{$coord}{$gene_name} = $npept;
		if ($opt{v}) {
		    print "INS $ID $coord $gene_name $pept $freq\n";
		}
	    }
	}
	
    }

}

# Add INS peptide into rows hash
foreach $y (keys %nP) {
    foreach $yy (keys %{$nP{$y}}) {
	foreach $yyy (keys %{$nP{$y}{$yy}}) {
#	    print "Ins> $y $yyy $nP{$y}{$yy}{$yyy}\n";
	    push( @{ $rows{$y}{$yyy}}, $nP{$y}{$yy}{$yyy});
	}
    }
}

# Add DEL into rows hash
sub is_consecutive {
    my $last = shift;
    foreach my $num (@_) {
	return 0 if $num != $last + 1;
	$last = $num;
    }
    
    return 1;
}


# $y1 is ID
foreach $y1 (keys %T) {
    # $yy1 is gene_name
    foreach $yy1 (keys %{$T{$y1}}) {
	
	# frequency coordinate array
	#	print "@{$TTT{$y1}{$yy1}} @{$T{$y1}{$yy1}}\n";
	
	$mean_freq=sum(@{$TTT{$y1}{$yy1}})/@{$TTT{$y1}{$yy1}};
	$min_freq=sprintf("%.1f", min(@{$TTT{$y1}{$yy1}}));
	$max_freq=sprintf("%.1f", max(@{$TTT{$y1}{$yy1}}));
	$range =  Set::IntSpan->new(@{$T{$y1}{$yy1}});
	@range =  split(/,/,$range);
	$nuc_del = join("",@{$TT{$y1}{$yy1}});

	
	#	if (($min_freq<75) && ($min_freq>$thresh)) {
	for $zzz1 ( 0 .. $#{ $TTT{$y1}{$yy1} } ) {
	    $FREQ=$TTT{$y1}{$yy1}[$zzz1];
	    $yyy1=$zzz1;
	    
	    if ($opt{v}) {
		#		    printf "< $y1 $yy1 $yyy1 $nuc_del output_bus[%s] $min_freq $mean_freq\n", Set::IntSpan->new(@{$T{$y1}{$yy1}});
		#		    for $yyy1 ( 0 .. $#{ $T{$y1}{$yy1} } ) {
		print "DEL $y1 $T{$y1}{$yy1}[$yyy1] $yy1 $TT{$y1}{$yy1}[$yyy1] $TTT{$y1}{$yy1}[$yyy1]\n";
		
		#		    }
	    }
	    
	    if (($FREQ < 75) && ($FREQ > $thresh)) { 
	
		$inter=join("-",$min_freq,$max_freq);

		#30 Apr 2019
		#$nrangeT = join("_", $range,$nuc_del,"DEL");
		#coord_ref_DEL
		$nrangeT = join("_", $T{$y1}{$yy1}[$zzz1],$TT{$y1}{$yy1}[$zzz1],"DEL");
		
		#$nrange = join(":", $nrangeT,$max_freq);
		#coord_ref_DEL:freq
		$nrange = join(":", $nrangeT,$FREQ);  
		push( @{ $rows{$y1}{$yy1}}, $nrange);
	    }else{
	

		#30 Apr 2019
		#$nrange = join("_", $range,$nuc_del,"DEL");
		#coord_ref_DEL
		$nrange = join("_", $T{$y1}{$yy1}[$zzz1],$TT{$y1}{$yy1}[$zzz1],"DEL");
		
		push( @{ $rows{$y1}{$yy1}}, $nrange);
	    }
	    
	}
    }
}



@setNames = sort keys %H;
print OUT1 join ("\t", 'Name', @setNames), "\n";

print OUT1 "Range\t";
foreach $o (sort keys %H) {
    print OUT1 "r[";
    print OUT1 join ("-", $H{$o}[0],$H{$o}[1]);
    print OUT1 "]";
    print OUT1 "\t";
}
print OUT1 "\n";

print OUT1 "LocusName\t";
foreach $oo (sort keys %H) {
    print OUT1 "$H{$oo}[2]";
    print OUT1 "\t";
}
print OUT1 "\n";


foreach $rowName (sort keys %rows) {
    
    
    foreach $l (@setNames) {
	
	if (defined $rows{$rowName}{$l}) {
	    
#	    $val=join("+", @{$rows{$rowName}{$l}});
	    $val=join("", @{$rows{$rowName}{$l}});
	    
	    
	    push @data, $val;
		
	}else {
	    
	    push @data, "";
	}
	
	
    }
    print OUT1 join("\t", $rowName, @data), "\n";
    @data=();
}

close(OUT1);

