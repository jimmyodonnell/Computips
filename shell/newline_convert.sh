#!/usr/bin/env bash

# convert to unix newlines

infile="${1}"

outfile="${infile%.*}"_nl.csv

sed $'s/\r$//' "${infile}"  > "${outfile}"
