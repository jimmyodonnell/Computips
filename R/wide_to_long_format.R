# Example from http://www.ats.ucla.edu/stat/r/faq/reshape.htm
hsb2 <- read.table('http://www.ats.ucla.edu/stat/r/faq/hsb2.csv', header=T, sep=",")
hsb2[1:10,]

## Wide to long

l <- reshape(hsb2, 
  varying = c("read", "write", "math", "science", "socst"), 
  v.names = "score",
  timevar = "subj", 
  times = c("read", "write", "math", "science", "socst"), 
  new.row.names = 1:1000,
  direction = "long")

l.sort <- l[order(l$id),]
l.sort[1:10,]


## Long to wide

w <- reshape(l.sort, 
  timevar = "subj",
  idvar = c("id", "female", "race", "ses", "schtyp", "prog"),
  direction = "wide")
  
w[1:10,]


