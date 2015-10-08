#!/usr/bin/env bash

# test whether program is installed
program_name="pigz"

which "${program_name}"

if [ $? -eq 0 ]; then
  echo "program" "${program_name}" "is installed"
else
  echo "program" "${program_name}" "not installed"
fi
