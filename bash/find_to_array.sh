#!/usr/bin/env bash

# find files and put them into an array

search_dir="${1}"

search_string='*.fastq*'

file_list=()
 while IFS= read -d $'\0' -r file ; do
     file_list=("${file_list[@]}" "$file")
 done < <(find "${search_dir}" -type f -name "${search_string}" -print0)

 echo "${file_list[@]}"
