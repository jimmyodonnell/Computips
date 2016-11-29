
# Essential AWK Commands for Next Generation Sequence Analysis
# Source: http://bioinformatics.cvr.ac.uk/blog/essential-awk-commands-for-next-generation-sequence-analysis/

# Here are the few essential awk command line scripts for next generation sequence analysis.

# Users need latest version of gawk to run commands with bitwise operations. Most of the Linux distributions come with gawk. However OSX users have to install it from here

# http://rudix.org/packages/gawk.html

# Count number of reads in a FastQ file
awk 'END{print NR/4}' file.fastq

# Convert FastQ to FastA
awk 'NR%4==1{a=substr($0,2);}NR%4==2{print ">"a"\n"$0}' file.fastq

# Get reads matching a sequence pattern and convert them to FastA
awk 'NR%4==1{a=substr($0,2);}NR%4==2 && $1~/GAATTC/ {print ">"a"\n"$0}' file.fastq

# This will get all reads with EcoRI cleavage (GAATTC)

# Separate reads based on their length
awk 'NR%4==1{a=$0} NR%4==2{b=$0} NR%4==3{c=$0} NR%4==0&&length(b)>=75{print a”\n”b”\n”c”\n”$0;}' file.fq

# This will print reads thats are 75bp or more in length.

# Printing the above output in FastA format
awk 'NR%4==1{a=substr($0,2);} NR%4==2{b=$0} NR%4==3{c=$0} NR%4==0&&length(b)>=75{print a”\n”b”\n”c”\n”$0;}' file.fq

# Get All header lines from a SAM file
awk '$1~/^@/' file.sam

# Get all reads – excluding headers
awk '$1!~/^@/' file.sam

# Get all unmapped
gawk -F'\t' '$1!~/^@/ && and($2,0x4)' file.sam

# Get all mapped
gawk -F'\t' '$1!~/^@/ && !and($2,0x4)' file.sam

# Count unmapped
awk -F'\t' '$1!~/^@/ && and($2,0x4){i++};END{print i}' file.sam

# Count mapped
awk -F'\t' '$1!~/^@/ && !and($2,0x4){i++};END{print i}' file.sam

# Convert all unmapped reads into fasta format
awk -F'\t' '$1!~/^@/ && and($2,0x4) {print ">" $1; if(and($2,0x10)) system("echo " $10 "| rev| tr '[ATGC]' '[TACG]'"); else print $10}' file.sam

# Convert all mapped reads into fasta format
awk -F'\t' '$1!~/^@/ && !and($2,0x4) {print ">" $1; if(and($2,0x10)) system("echo " $10 "| rev| tr '[ATGC]' '[TACG]'"); else print $10}' file.sam

# Convert all reads into fasta format
awk -F'\t' '$1!~/^@/{print ">" $1; if(and($2,0x10)) system("echo " $10 "| rev| tr '[ATGC]' '[TACG]'"); else print $10}' file.sam
