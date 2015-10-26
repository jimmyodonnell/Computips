#!/usr/bin/env bash

# To suppress 'permission denied' and other error messages from the output of find:
find . -name "filetofind" 2>/dev/null

# this send standard error to a null device (instead of printing to screen)
