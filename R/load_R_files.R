#!/usr/bin/R

# Load all files with extension "R" in a directory:

R_files <- list.files(path = "/path/to/directory", pattern = "*.R$", full.names = TRUE)
sapply(R_files, source)

# A function from the help files:
sourceDir <- function(path, trace = TRUE, ...) {
    for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
       if(trace) cat(nm,":")           
       source(file.path(path, nm), ...)
       if(trace) cat("\n")
    }
}
