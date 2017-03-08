################################################################################
# Some data frame/table/set/base merge/join operations, using multiple approaches
#*******************************************************************************

library(data.table) # data.table(), etc
library(plyr) # join
library(dplyr) # inner_join, outer_join, left_join, right_join, etc

# data:
df1 <- data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 <- data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))

# for manipulating as data.tables
dt1 <- data.table(df1, key = "CustomerId")
dt2 <- data.table(df2, key = "CustomerId")

#===============================================================================
# INNER JOIN
#-------------------------------------------------------------------------------
# Return only the rows in which the left table have matching keys in the right table.

# base:
merge(x = df1, y = df2, by = "CustomerId")
# if the matching variables have different names in the different data frames, use the by.x and by.y parameters

# plyr:
join(df1, df2, by = "CustomerId", type = "inner")
# Unlike merge, [join] preserves the order of x no matter what join type is used.

# dplyr:
inner_join(df1, df2, by = "CustomerId")

# data.table:
dt1[dt2]
# or
merge(dt1, dt2)

# note: dt1[dt2] is a right outer join (not a "pure" inner join) so that ALL rows from dt2 will be part of the result even if there is no matching row in dt1. Impact: You result has potentially unwanted rows if you have key values in dt2 that do not match the dt1's key values... but you can just specify nomatch = 0L in that case
dt1[dt2, nomatch = 0L]


#-------------------------------------------------------------------------------


#===============================================================================
# OUTER JOIN (aka FULL JOIN)
#-------------------------------------------------------------------------------
# Returns all rows from both tables, join records from the left which have matching keys in the right table.

# base:
merge(x = df1, y = df2, by = "CustomerId", all = TRUE)

# plyr:
plyr::join(x = df1, y = df2, by = "CustomerId", type = "full")

# dplyr:
dplyr::full_join(x = df1, y = df2, by = "CustomerId")

# data.table:
merge(dt1, dt2, by = "CustomerId", all = TRUE)
#-------------------------------------------------------------------------------


#===============================================================================
# LEFT OUTER JOIN
# Return all rows from the left table, and any rows with matching keys from the right table.

# base:
merge(x = df1, y = df2, by = "CustomerId", all.x = TRUE)

# plyr:
plyr::join(x = df1, y = df2, by = "CustomerId", type = "left")

# dplyr:
dplyr::left_join(x = df1, y = df2, by = "CustomerId")

# data.table:

#-------------------------------------------------------------------------------


#===============================================================================
# RIGHT OUTER JOIN
# Return all rows from the right table, and any rows with matching keys from the left table.

# base:
merge(x = df1, y = df2, by = "CustomerId", all.y = TRUE)

# plyr:
plyr::join(x = df1, y = df2, by = "CustomerId", type = "right")

# dplyr:
dplyr::right_join(x = df1, y = df2, by = "CustomerId")

# data.table:
merge(x = dt1, y = dt2, by = "CustomerId", all.y = TRUE)
#-------------------------------------------------------------------------------


#===============================================================================
# CROSS JOIN

# base:
merge(x = df1, y = df2, by = NULL)

# plyr:

# dplyr:

# data.table:


#===============================================================================
# Other tips:
# When you want to merge using more than one column: 
merge(x=df1,y=df2, by.x=c("x_col1","x_col2"), by.y=c("y_col1","y_col2"))

