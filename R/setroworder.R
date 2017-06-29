################################################################################
setroworder <- function(x, neworder){
	# reorder the rows of a data.table
	setorderv(
		x = x[, eval(call(":=", as.name(".r"), call("order", neworder)))], 
		cols = ".r"
	)[, ".r" := NULL]
}
