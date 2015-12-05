#!/usr/bin/env bash


# to print ONLY the line BEFORE the one containing matching pattern
awk '/pattern/ { print x };{x=$0} ' $myfile


# to print both the matching line AND the line preceding it:
awk '/pattern/ { print x ; print };{x=$0} ' $myfile
