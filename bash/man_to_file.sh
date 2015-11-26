#!/usr/bin/env bash

# to save the contents of a man page to a text file:

man grep | col -b > grep_manual.txt

# or, to pdf!
man -t grep | ps2pdf ->  grep_manual.pdf
