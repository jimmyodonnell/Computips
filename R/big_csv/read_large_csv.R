# read a big csv:

# from help(read.table): These functions can use a surprising amount of memory when reading large files. There is extensive discussion in the ‘R Data Import/Export’ manual, supplementing the notes here.

# Less memory will be used if colClasses is specified as one of the six atomic vector classes. This can be particularly so when reading a column that takes many distinct numeric values, as storing each distinct value as a character string can take up to 14 times as much memory as storing it as an integer.
# 
# Using nrows, even as a mild over-estimate, will help memory usage.
# 
# Using comment.char = "" will be appreciably faster than the read.table default.
# 
# read.table is not the right tool for reading large matrices, especially those with many columns: it is designed to read data frames which may have columns of very different classes. Use scan instead for matrices.
# 


# dup_table_file <- "/Users/jimmy.odonnell/Desktop/Analysis_20151013_1719/all_lib/duplicate_table.matrix"
dup_table_csv <- "toy.csv"
dup_table_matrix <- "toy.matrix" # a file with values only
dup_table_rownames <- "toy.rownames" # extracted rownames
dup_table_colnames <- "toy.colnames" # extracted colnames

# using package data.table:
library(data.table)
system.time(dup_table_DT <- fread(input = dup_table_csv))

# using scan

# read in rows and columns, exclude the top left corner
rows <- scan(dup_table_rownames, what = "character", sep = ",")
rows <- rows[2:length(rows)]

columns <- scan(dup_table_colnames, what = "character", sep = ",")
columns <- columns[2:length(columns)]
# get number of rows to optimize functions:
N_rows <- as.numeric(system(command = paste("wc -l <", dup_table_matrix), intern = TRUE ))
# read in the (integers-only) matrix
dup_values <- scan(file = dup_table_matrix, what = "numeric", sep = ",", nlines = N_rows)
# takes ~42 seconds on big NWFSC iMac

# make into a matrix:
dup_table_mat <- matrix(data = as.integer(dup_values), nrow = N_rows, byrow = TRUE, dimnames = list(rows, columns))

# using (plain) read.table:
dup_table_rt <- as.matrix(read.csv(file = dup_table_csv, row.names = 1))

identical(dup_table_rt, dup_table_mat)


# alternate scan (can't figure this shit out...):
# empty quotes means read as a string variable
# scan(file = "scan.txt", what = list(age = 0, name = ""))
# x <- scan(file = "scan.txt", what = list(NULL, name = character()))
# x <- x[sapply(x, length) > 0]
# scan(file = dup_table_csv, what = as.list(c(NULL, rep("integer", length(columns)))), skip = 1, sep = ",")


cat("2 3 5 7", "11 13 17 19", file="ex.dat", sep="\n")
scan(file="ex.dat", what=list(x=0, y="", z=0), flush=TRUE)

# optimized read.table
# Even with optimization, the same operation with read table on the raw matrix (i.e. with rownames and colnames) never finishes
big_table <- read.table(file = dup_table_matrix, 
                        header = FALSE, 
                        sep = ",", 
                        nrows = N_rows, 
                        comment.char = "", 
                        colClasses = "integer"
)




# manipulating big data tables with the package 'data.table'
# data.table
library(data.table)

DF <- data.frame(
                  x = c("b", "b", "b", "a", "a"), 
                  v = rnorm(5)
                )

DF

DT <- data.table(
                  x = c("b", "b", "b", "a", "a"), 
                  v = rnorm(5)
                )
DT


# convert data.frame to data.table
CARS <- data.table(cars)
head(CARS)

# see a list of all data.tables in memory:
tables()

# show column types
sapply(DT,class)

# data tables can have KEYS consisting of one OR MORE columns

# show row 2
DT[2,]

# show rows where column x == "b" (no need for DF$x syntax)
DT[x == "b",]

# because there are no rownames, this does not work:
cat(try( DT["b", ], silent = TRUE))

# set keys
setkey(DT,x)

DT

# Notice that the rows in DT have now been re-ordered according to the values of x.
# confirm a data table has a key using hashkey(), key(), attributes(), or just running tables()
tables()

# now that DT has a key, try referencing again
DT["b", ]


# By default all the rows in the group are returned1. The mult argument (short for multiple) allows the first or last row of the group to be returned instead.
DT["b", mult="first"]
DT["b", mult="last"]

# the comma is optional with Keys
DT["b"]

#  create a new data.frame. We will make it large enough to demonstrate the difference between a vector scan and a binary search.
grpsize <- ceiling(1e7/26^2)   # 10 million rows, 676 groups

tt <- system.time(
  DF <- data.frame(
    x = rep(LETTERS, each = 26*grpsize), 
    y = rep(letters, each = grpsize), 
    v = runif(grpsize*26^2), 
    stringsAsFactors = FALSE
  )
)

tt

head(DF,3)

tail(DF,3)

dim(DF)

# We might say that R has created a 3 column table and inserted 10,000,068 rows. It took 5.981 secs, so it inserted 1,671,972 rows per second. This is normal in base R. Notice that we set stringsAsFactors=FALSE. This makes it a little faster for a fairer comparison, but feel free to experiment.
# Let’s extract an arbitrary group from DF:
tt=system.time(ans1 <- DF[DF$x=="R" & DF$y=="h",])
tt

head(ans1,3)
dim(ans1)

# Now convert to a data.table and extract the same group:
DT <- as.data.table(DF)       # but normally use fread() or data.table() directly, originally
system.time(setkey(DT,x,y))  # one-off cost, usually

ss=system.time(ans2 <- DT[list("R","h")]) #binary search
ss

head(ans2,3)

dim(ans2)

identical(ans1$v, ans2$v)

# At 0.010 seconds, this was 1384 times faster than 13.845 seconds, and produced precisely the same result. If you are thinking that a few seconds is not much to save, it’s the relative speedup that’s important. The vector scan is linear, but the binary search is O(log n). It scales. If a task taking 10 hours is sped up by 100 times to 6 minutes, that is significant.

# We can do vector scans in data.table, too. In other words we can use data.table badly.
system.time(ans1 <- DT[x=="R" & y=="h",]) # works but is using data.table badly
system.time(ans2 <- DF[DF$x=="R" & DF$y=="h",]) # on the data.frame
mapply(identical,ans1,ans2)


# FAST GROUPING
# The second argument to DT[...] is j and may consist of one or more expressions whose arguments are (unquoted) column names, as if the column names were variables. Just as we saw earlier in i as well.
DT[,sum(v)]
# When we supply a j expression and a ’by’ expression, the j expression is repeated for each ’by’ group.
DT[ , sum(v), by = x]

# Let’s compare it to tapply.
ttt=system.time(tt <- tapply(DT$v,DT$x,sum)); ttt
sss=system.time(ss <- DT[,sum(v),by=x]); sss
head(tt)
head(ss)
identical(as.vector(tt), ss$V1)

# group by two columns:
ttt=system.time(tt <- tapply(DT$v,list(DT$x,DT$y),sum)); ttt
sss=system.time(ss <- DT[,sum(v),by="x,y"]); sss

tt[1:5,1:5]
head(ss)

identical(as.vector(t(tt)), ss$V1)
