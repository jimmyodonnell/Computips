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
# download.file(url = "http://www.soest.hawaii.edu/pwessel/gshhg/gshhg-shp-2.3.4.zip", destfile = file.path(".", "gshhg-shp-2.3.4.zip"))

# You'll then need to unzip it; you could do it from R, but the destination path isn't always the same, and it could overwrite something.
# system(unzip "gshhg-shp-2.3.4.zip" -d "gshhg-shp-2.3.4")


# The geography data come in five resolutions:
# full resolution (f): Original (full) data resolution.
# high resolution (h): About 80 % reduction in size and quality.
# intermediate resolution (i): Another ~80 % reduction.
# low resolution (l): Another ~80 % reduction.
# crude resolution (c): Another ~80 % reduction.
resolution <- "f"

# give the path to the directory containing the resolution you'd like to work with
GSHHG_dir <- "/Users/threeprime/Documents/Data/GIS/gshhg-shp-2.3.4/GSHHS_shp/"

GSHHG_dir <- paste(GSHHG_dir, resolution, sep = "")

# what is the filename (without extension) of the layer you want to load?
# layer_of_interest <- "GSHHS_l_L1"
layer_of_interest <- paste("GSHHS_", resolution, "_L1", sep = "") 

# read in the data: remember, this is worldwide data
GSHHG_obj <- readOGR(dsn = GSHHG_dir, layer = layer_of_interest)

# specify some info about the area of interest.
# PUGET SOUND: lat c(47,49) lon: c(-124, -122)
SAN_JUAN_ISLAND_lat <- c(48.4, 48.65) 
SAN_JUAN_ISLAND_lon <- c(-123.2, -122.95)
region_lat <- SAN_JUAN_ISLAND_lat # min, max latitude 
region_lon <- SAN_JUAN_ISLAND_lon # min, max longitude

# rather than clip right at the min and max points, you might want the extent to be a bit larger. Set the following line to the percent increase you'd like
expansion_percent_lon <- 10
expansion_percent_lat <- 10
lon_exp <- diff(region_lon) * expansion_percent_lon/100
plot_lon <- region_lon + c(-lon_exp, lon_exp)
lat_exp <- diff(region_lat) * expansion_percent_lat/100
plot_lat <- region_lat + c(-lat_exp, lat_exp)

bb_region <- rbind(x = plot_lon, y = plot_lat)
bb_dim <- apply(bb_region, 1, diff)

# subset the worldwide data to the area you specified above
PS_map <- crop(GSHHG_obj, extent(c(bb_region[1,], bb_region[2,])))

# presumably, you did the subsetting to reduce the size of the gigantic shapefile and make operations on it (like plotting) faster, so you should probably remove the huge shapefile/thingy to free up some memory.
rm(GSHHG_obj)

# If you'd like to add some features
named_features <- rbind(
  c("Seattle", -122.333056, 47.609722),
  c("Puget Sound", -122.5, 48)
)
colnames(named_features) <- c("name", "lon", "lat")

#----------------------- PLOT THE FRIGGIN MAP ALREADY! -------------------------

# how wide should the map be?
map_width_inches <- 8

# Then that means the height should be...
map_height_inches <- round(bb_dim[2] * map_width_inches / bb_dim[1])


# OUTPUT FILE NAME AND DIMENSIONS
pdf(
  file = "site_map.pdf",
  width = map_width_inches, 
  height = map_height_inches
)

# SET BORDERS
par(mar = c(4,4,1,1))

# BASE MAP
plot(
	x = PS_map,
	# axes = TRUE, 
	col = "darkseagreen", 
	border = "grey", 
	bg = "aliceblue", 
	ylim = region_lat, 
	xlim = region_lon
	)

# POINTS
points(
  x = sites$Lon, 
  y = sites$Lat, 
  col = "black", 
  bg = c("red", "yellow", "orange")[as.numeric(sites$team)], 
  pch = c(21, 24)[as.numeric(sites$Dataset)], 
  cex = 1.5
)

# X Axis (longitude)
axis(
	side = 1, 
	# at = seq(from = region_lon[1], to = region_lon[2]), 
	cex.axis = 0.8, 
	line = 0
	)

# Y Axis (latitude)
axis(
	side = 2, 
# 	at = seq(from = region_lat[1], to = region_lat[2]), 
	line = 0, 
	cex.axis = 0.8, 
	las = 2
	)

# ADD BORDER
box()

# LABELS
title(
  # main = "Puget Sound plotted after subset", 
  sub = "", 
	xlab = "Longitude", 
	ylab = "Latitude"
	)

make.italic <- function(x) as.expression(lapply(x, function(y) bquote(italic(.(y)))))

# OTHER TEXT
text(
  x = as.numeric(named_features[,"lon"]), 
  y = as.numeric(named_features[,"lat"]), 
  labels = make.italic(named_features[,"name"]), 
  col = c("darkgreen", "lightblue4"), 
  pos = c(4, NULL)
)

dev.off()



# colors
# library(RColorBrewer)
# par(mar = c(0, 4, 0, 0))
# display.brewer.all()
# plot(1:100, col = brewer.pal(11, "Spectral"))