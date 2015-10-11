#!/usr/bin/env bash

# using sftp/put:
sftp userid@server_name
put june06extract

# using scp:
scp <file to be copied> <destination>

# copy a file from your computer to a server:
scp /path/to/local/filename userid@server_name:/path/to/server/dir

# copy a file from the server to your computer:
scp userid@server_name:/path/to/file_name /path/to/local/dir 

#For example, 
scp june06extract wrhse@warehouse.cit.cornell.edu:/mydata/june06extract.

# to copy the file "foobar.txt" from a remote host to the local host
scp your_username@remotehost.edu:foobar.txt /some/local/directory


# specific examples:
# download files:
scp jimmyod@bloom.ocean.washington.edu:blasted_20150513_1726.tsv /Users/threeprime/
scp jimmyod@bloom.ocean.washington.edu:blasted_20150514_1803.xml.gz /Users/threeprime/
scp jimmyod@bloom.ocean.washington.edu:Jesse_20150925/blasted_20150925_1632.xml.gz /Users/threeprime/Documents/Dropbox/Jesse

# upload files:
scp /Users/threeprime/Compute/remote/transfer_file_server.sh jimmyod@bloom.ocean.washington.edu
scp /Users/threeprime/Desktop/pear-0.9.6-bin-64 jimmyod@bloom.ocean.washington.edu:
scp /Users/threeprime/Desktop/Analysis_20150727_0004/all_lib/nosingle.txt.gz jimmyod@bloom.ocean.washington.edu:NextSeq_20150717/Analysis_20150727_0004
scp /Users/threeprime/Documents/Dropbox/Jesse/24Sept15/all_lib/9_OTUs.fasta.gz jimmyod@bloom.ocean.washington.edu:
scp /Users/threeprime/Documents/Dropbox/Jesse/24Sept15/blast_jesse_20150925.sh jimmyod@bloom.ocean.washington.edu:Jesse_20150925
scp /Users/threeprime/Desktop/Analysis_20151010_1925/all_lib/OTUs_usearch/OTUs.fasta.gz jimmyod@bloom.ocean.washington.edu:20151006_MBON
scp /Users/threeprime/temp_big_upload/20151006_MBON/blast_script.sh jimmyod@bloom.ocean.washington.edu:20151006_MBON

