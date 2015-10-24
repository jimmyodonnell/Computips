

################################################################################
# Install packages
################################################################################
# basic install
install.packages("vegan")

# install package from source (tar.gz file)
install.packages("~/Desktop/diversitree_0.9-7.tar.gz", repos=NULL, type="source")

# From local file on your machine, already downloaded tar.gz or .tgz binary file:
install.packages("~/directory/packagefilepath.tgz", repos=NULL)

# From the command line (a.k.a. shell, terminal, etc)
# download .tgz file
curl http://cran.r-project.org/bin/macosx/universal/contrib/r-release/plotrix_2.6-1.tgz > plotrix_2.6-1.tgz
# install it
sudo R CMD INSTALL plotrix_2.6-1.tgz
# check it's there
ls -l /Library/Frameworks/R.framework/Resources/library/

################################################################################
# check if package exists
################################################################################
if (!vegan %in% installed.packages()) install.packages(vegan)

required_packages <- c("ggplot2", "Rcpp")
required_packages <- c("stuff", "things")

packages_to_install <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

if(length(packages_to_install)) install.packages(packages_to_install)


################################################################################
# Check for, install, and load a bunch of packages
################################################################################
# check that required packages are installed; if they aren't, attempt to install them.
# if installation doesn't work, quit.
required_packages <- c("ape", "gtools")


for(package in required_packages){
	
	# check if the package is installed
	if( package %in% installed.packages()){
		
		print(paste("loading ", package))
		
		# if it is, load it.
		library(package, character.only = TRUE)
		
	} else {
		
		print(paste(package, "is not installed; attempting to install it..."))
		
		# if it's not installed, install it
		install.packages(package)
		
		# Check if installation was successful
		if( package %in% installed.packages()){
			
			print(c("loading ", package))
			
			# load the package if it was
			library(package, character.only = TRUE)
			
		} else {
			
			# otherwise, stop and spit an error message 
			# (this will exit the script if run non-interactively)
			stop(c("Couldn't find or load the R package ", package))
			
		}
		
	}
	
}
