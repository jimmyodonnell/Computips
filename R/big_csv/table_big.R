# read a big (wide == many columns) csv

library(data.table) # fread

file_path <- "/Users/threeprime/temp_big/20150717_nextseq/Analysis_20151019_1918/all_lib/duplicate_table.csv"

dup_dt <- fread(input = file_path, sep = ",", header = TRUE)

dup_dt[,1]
