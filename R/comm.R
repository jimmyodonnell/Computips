comm <- function(x, y){
	# compare two vectors. (similar to Unix comm)
	# returns a dataframe with 3 columns of TRUE/FALSE:
	# - 1: element appears in x
	# - 2: element appears in y
	# - 3: element appears in both x and y
	full  <- union(x, y)
	xnoty <- setdiff(x, y)
	ynotx <- setdiff(y, x)
	both  <- intersect(x, y)
	out <- data.frame(
	  name = full, 
	  xnoty = full %in% xnoty, 
	  ynotx = full %in% ynotx, 
	  both  = full %in% both
	)
	return(out)
}
