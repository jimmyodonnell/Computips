#!/usr/bin/env bash

arg1="${1}"

arg2="${2}"

echo "this is argument 1 variable:" "${arg1}"
echo "this is argument 1 direct:" "${1}"

echo "this is argument 2 variable:" "${arg2}"
echo "this is argument 2 direct:" "${2}"

myarr=( ${2} )
echo "whole array:" ${myarr[@]}
echo "0" "${myarr[0]}"
echo "1" "${myarr[1]}"
echo "2" "${myarr[2]}"
echo "3" "${myarr[3]}"

if [[ -n "${2}" ]]; then
   echo "the command line arg had length gt 0:" "${2}"
 else
   echo "the command line arg had length 0" "${2}"
fi


# sort values
sorted=($(printf '%s\n' "${myarr[@]}" | sort -nr | uniq ))
echo "${sorted[@]}"

