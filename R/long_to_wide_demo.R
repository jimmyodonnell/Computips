#-------------------------------------------------------------------------------
# Rearrange data from long format to wide format
#-------------------------------------------------------------------------------

setwd("~/Downloads")
getwd()

# read in data in long format
data_long <- read.csv("benthic_alltaxa.csv", stringsAsFactors = FALSE)

# it is generally bad practice to have spaces in column names.
# because the values in column "Taxon" will be used as column names, let's go
# ahead and clean them up first. Note that there are also some trailing spaces 
# in the names, which could potentially trip you up.
data_long[,"Taxon"] <- gsub(
  pattern = " ", 
  replacement = "_", 
  x = data_long[,"Taxon"]
  )

# reshape it in wide format, 
# using "Site" as the variable that identifies individual samples
data_wide <- reshape(
  data = data_long, 
  idvar = "Site", 
  timevar = "Taxon", 
  direction = "wide"
  )

# by default, combinations for which there is no data are filled with NA;
# so change all NAs to 0
data_wide[is.na(data_wide)] <- 0

# to remove the "TotalCount." prefix from column names:
colnames(data_wide) <- gsub(
  pattern = "TotalCount.", 
  replacement = "", 
  x = colnames(data_wide), 
  fixed = TRUE
  )

#-------------------------------------------------------------------------------
# alternative
#-------------------------------------------------------------------------------
# I have recently been loving the package data.table, which among other things, 
# does some basic operations a little more intuitively.

library(data.table)
DT_long <- data.table(data_long)
DT_wide <- dcast(
  data = DT_long, 
  formula = Site ~ Taxon, 
  fill = 0,
  value.var = "TotalCount")
