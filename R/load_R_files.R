#!/usr/bin/R

# Load all files with extension "R" in a directory:

R_files <- list.files(path = "/path/to/directory", pattern = "*.R$", full.names = TRUE)
sapply(R_files, source)

