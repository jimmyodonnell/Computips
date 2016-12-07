# Use the function sprintf to do zero padding in R
# format is:
# % - percent sign, 
# 0 - followed by zero, 
# 3 - followed by the total number of digits in the output, followed by d:
#-------------------------------------------------------------------------------

x <- 1:10
sprintf("%02d", x)
sprintf("%06d", x)
sprintf("%02d", 1:10)

