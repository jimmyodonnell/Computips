#!/usr/bin/env bash

typeset -i i END # let's be explicit

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
