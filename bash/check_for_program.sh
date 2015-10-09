#!/usr/bin/env bash

# test whether program is installed
program_name="pigz"

# source: http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script

# this works in bash and is POSIX compliant (i.e. should be consistent across systems)
if command -v "${program_name}" >/dev/null 2>&1; then
  echo "program found"
else
  echo "program not found"
fi

exit

# (works on BASH, not necessarily POISIX compliant)
if hash "${program_name}" 2>/dev/null; then
  echo "program found"
else
  echo "program not found"
fi



exit

# the following are all janky and unrecommended.

which "${program_name}"

if [ $? -eq 0 ]; then
  echo "program" "${program_name}" "is installed"
else
  echo "program" "${program_name}" "not installed"
fi


# Alternate:
# -e test 'is this a file' (but appears to work for files that don't exist, i.e. pogz or stuff)
if [ -e $( which pigz ) ]; then
  echo "program" "${program_name}" "is installed"
else
  echo "program" "${program_name}" "not installed"
fi
