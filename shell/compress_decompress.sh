#!/usr/bin/env bash

#In order to "zip" a directory, the correct command would be
tar -zcvf archive.tar.gz directory/ 
# This will tell tar to c (create) an archive from the files in directory (tar is recursive by default), compress it using the z (gzip) algorithm, store the output as a f (file) named archive.tar.gz, and v (verbosely) list all the files it adds to the archive.

# To decompress and unpack the archive into the current directory you would use
tar -zxvf archive.tar.gz 


# compress directory or compress directories
tar cvf - paths-to-archive | pigz > archive.tar.gz
tar cvf - /Users/threeprime/Documents | pigz > Documents_20150504.tar.gz


# to decompress files with extension .zip, do this:
unzip file.zip -d destination_folder


# To extract one or more members from an archive, enter:
tar -zxvf file.tar.gz

# To view a detailed table of contents (list of file), enter::
tar -tvf backup.tar.gz

# To extract resume.doc file from backup.tar.gz tarball, enter:
tar -zxvf backup.tar.gz resume.doc


# -z : Work on gzip compression automatically when reading archives.
# -x : Extract archives.
# -v : Produce verbose output i.e. display progress and extracted file list on screen.
# -f : Read the archive from the archive to the specified file. In this example, read backups.tar.gz archive.
# -t : List the files in the archive.

# convert compressed fastq to compressed fasta
infile="/Users/threeprime/Desktop/Analysis_20150725_1452/A/1_merged.assembled.fastq.gz"
seqtk seq -A "${infile}" | pigz > "${infile%%.*}".fasta.gz


################################################################################
# compress files recursively in subdirectories by extension:

# note that the dot (.) indicates the current working directory (printed to screen with: echo $PWD)

# This does all files with extension .fasta:
find . -type f -name '*.fasta' -exec gzip "{}" \;

# The problem with this is that a new process will be started for each file (IIRC). Not very efficient if there are a lot of files. So, to change it a little bit more, I would go for the following approach:
find . -type f -name '*.fasta' -print0 | xargs -0 gzip
