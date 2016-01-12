#----------------------- PLOT A MAP -------------------------

#----------------------- LOAD PACKAGES ----------------------
library(rgdal)
library(rgeos)
library(raster)

# if you don't have any of these, you can install them with this command:
# install.packages("raster")
# Especially for rgdal, if prompted, you want to install the binary, NOT from source.

#----------------------- GET YE SOME DATA -------------------------
# "GSHHG: A Global Self-consistent, Hierarchical, High-resolution Geography Database"
# http://www.soest.hawaii.edu/pwessel/gshhg/
# also see https://www.ngdc.noaa.gov/mgg/shorelines/gshhs.html
# It's kinda large (~150MB on 20160111), but for many purposes is probably the only data you need.
# download the shape files: 
download.file(url = "http://www.soest.hawaii.edu/pwessel/gshhg/gshhg-shp-2.3.4.zip", destfile = file.path(".", "gshhg-shp-2.3.4.zip"))

# The geography data come in five resolutions:
# full resolution (f): Original (full) data resolution.
# high resolution (h): About 80 % reduction in size and quality.
# intermediate resolution (i): Another ~80 % reduction.
# low resolution (l): Another ~80 % reduction.
# crude resolution (c): Another ~80 % reduction.

# give the path to the directory containing the resolution you'd like to work with
GSHHG_dir <- "/Users/jimmy.odonnell/Downloads/gshhg-shp-2.3.4/GSHHS_shp/h"

# what is the filename (without extension) of the layer you want to load?
layer_of_interest <- "GSHHS_h_L1" 

# read in the data: remember, this is worldwide data
GSHHG_h_L1 <- readOGR(dsn = GSHHG_dir, layer = layer_of_interest)

# specify some info about the area of interest.
region_lat <- c(47, 49) # min, max latitude
region_lon <- c(-124, -122) # min, max longitude
bb_region <- rbind(x = region_lon, y = region_lat)

# subset the worldwide data to the area you specified above
PS_map <- crop(GSHHG_h_L1, extent(c(region_lon + c(-1, 1), region_lat + c(-1, 1))))

# presumably, you did the subsetting to reduce the size of the gigantic shapefile and make operations on it (like plotting) faster, so you should probably remove the huge shapefile/thingy to free up some memory.
rm(GSHHG_h_L1)

dev.new(
	width = 5, 
	height = 7
	)

plot(
	x = PS_map,
	# axes = TRUE, 
	col = "gray", 
	border = "black", 
	# bg = "aliceblue", 
	ylim = region_lat, 
	xlim = region_lon, 
	main = "Puget Sound plotted after subset", 
	)

	# xlab = "Longitude", 
	# ylab = "Latitude"

axis(
	side = 1, 
	at = seq(from = region_lon[1], to = region_lon[2]), 
	line = 0
	)

axis(
	side = 2, 
	at = seq(from = region_lat[1], to = region_lat[2]), 
	line = 0, 
	las = 2
	)

title(
	main = "", 
	sub = "", 
	xlab = "Longitude", 
	ylab = "Latitude"
	)


# colors
# library(RColorBrewer)
# par(mar = c(0, 4, 0, 0))
# display.brewer.all()
# plot(1:100, col = brewer.pal(11, "Spectral"))