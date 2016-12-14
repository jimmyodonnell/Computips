# function to break up vector x into chunks not longer than n
chunk <- function(x, n) split(x, ceiling(seq_along(x)/n))
