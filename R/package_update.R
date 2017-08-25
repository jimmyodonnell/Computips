#--run in the old version of R
setwd("C:/Temp/")
packages <- installed.packages()[,"Package"]
save(packages, file="Rpackages")

#--run in the new version
setwd("C:/Temp/")
load("Rpackages")
for (p in setdiff(packages, installed.packages()[,"Package"]))
install.packages(p)


load("packages_installed.RData")


# watch out for rstan!
install.packages(packages_installed)


# More in depth, from https://stackoverflow.com/questions/1401904/painless-way-to-install-a-new-version-of-r
# Just for completeness, there are some ways to prevent you from having this problem. As Dirk said, save your packages in another directory on your computer.

install.packages("thepackage",lib="/path/to/directory/with/libraries")

# You can change the default .Library value using the function .libPaths too

.libPaths("/path/to/directory/with/libraries")

# This will put this path as a first value in the .Library variable, and will make it the default.

# If you want to automate this further, you can specify this in the Rprofile.site file, which you find in the /etc/ directory of your R build. Then it will load automatically every time R loads, and you don't have to worry about that any more. You can just install and load packages from the specified directory.

# Finally, I have some small code included in my Rprofile.site allowing me to reinstall all packages when I install a new R version. You just have to list them up before you update to the new R version. I do that using an .RData file containing an updated list with all packages.

library(utils)

## Check necessary packages
load("G:\Setinfo\R\packagelist.RData") # includes a vector "pkgs"
installed <- pkgs %in% installed.packages()[, 'Package']
if (length(pkgs[!installed]) >=1){
  install.packages(pkgs[!installed])
}
# I make the packagelist.RData by specifying .Last() in my Rprofile.site. This updates the package list if I installed some :

.Last <- function(){
  pkgs <- installed.packages()[,1]
  if (length(pkgs) > length(installed)){
    save(pkgs,file="G:\Setinfo\R\packagelist.RData")
  }
}
# When I install a new R version, I just add the necessary elements to the Rprofile.site file and all packages are reinstalled. I have to adjust the Rprofile.site anyway (using sum contrasts, adding the extra code for Tinn-R, these things), so it's not really extra work. It just takes extra time installing all packages anew.