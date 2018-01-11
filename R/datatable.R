# a reference for the R package data.table aka datatable

library(data.table)

mycars <- mtcars # needs to be copied before being manipulated

# use row names from a dataframe as a new (first) column named 'rn'
setDT(mycars, keep.rownames = TRUE)[]

# sometimes data.table objects fail to print the first time they are referenced
# to fix this, end the first creation/assignment with brackets ('[]')
# use column names stored in a character vector
mycols <- c('rn', 'mpg', 'disp')
mycars[ , mycols, with = FALSE]

# perform function on columns
mycars[ , mean(mpg), by = cyl]

# and rename the new output
mycars[ , .(stuff = mean(mpg)), by = cyl]

# can do the same thing for multiple variables
mycars[ , .(mpg.mean = mean(mpg), mpg.var = var(mpg)), by = cyl]
