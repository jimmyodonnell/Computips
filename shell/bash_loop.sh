#!/usr/bin/env bash

typeset -i i END # let's be explicit
# using typeset with (or declare, which is the same) with `-i` 
# will force END later be evaluated as an integer
# see http://tldp.org/LDP/abs/html/declareref.html
# this allows the variables END and i to be evaluated arithmetically 
# in the 'for' statement of the loop below

for ((i=1;i<=END;++i))
do
   echo $i
done

# see also "find_to_array.sh"

mydir="/path/to/the/directory/to/search"
search_string='*.fastq*'

# to loop over the output of the find command
while IFS='' read -r -d '' thefile; do
  echo this is the file "${thefile}"
done < <(find "${mydir}" -type f -name "${search_string}" -print0)
