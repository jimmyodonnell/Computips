#!/usr/bin/env bash

# check whether a variable is an integer

myvar="${2}"

# Method 1: case statement, portable across many shells (e.g. zsh, etc)
case $myvar in

    ''|*[!0-9]*)
      echo "Error: minimum length argument ('""${myvar}""') is not a number" >&2
      exit 1
    ;;

    *) echo the variable is an integer

    ;;
esac

# Method 2: using regular expression
integers='^[0-9]+$'
if ! [[ "${myvar}" =~ $integers ]] ; then
   echo "Error: minimum length argument ('""${myvar}""') is not a number" >&2
   exit 1
fi
