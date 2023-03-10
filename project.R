
# Description -------------------------------------------------------------


#This routine imports raster and shapefile files into R, projects the spatRaster 
#and SpatVector objects to another desired projection and exports the objects 
#with a new projection.


# Packages ----------------------------------------------------------------

#install, if necessary
install.packages("terra")
install.packages("tidyverse")
install.packages("dplyr")

#load
library(terra)
library(tidyverse)
library(dplyr)


# Open file ---------------------------------------------------------------


raster <- rast("Path/raster.tif")
shapefile <- vect("Path/shapefile.shp")


# Project raster data -----------------------------------------------------


#First, set current crs
raster <- project(raster,
                  crs(raster),
                  method = "") #check which method is best for your data type


#Now, set a new crs
#In the case of a raster object it is preferable to use another raster, 
#but we can also use CRS. To do so, access the function's help and evaluate 
#the available options.

sirgas.crs <- "+proj=utm +zone=23 +south +ellps=GRS80 +units=m +no_defs"
wgs84.crs <- "EPSG:4326"
wgs84.crs2 <- "+proj=longlat +datum=WGS84 +no_defs"


raster_proj <- project(raster,
                       sirgas.crs, #choose the new projection or another raster
                       method = "") #check which method is best for your data type


raster_proj
plot(raster_proj)


# Project shapefile data --------------------------------------------------


#First, set current crs
shapefile <- project(shapefile,
                     crs(shapefile))

#Now, set a new crs
shapefile_proj <- project(shapefile,
                          "EPSG:4326") #choose the new projection

shapefile_proj
plot(shapefile_proj)


# Export spatial data -----------------------------------------------------


#raster

setwd("Path")
writeRaster(x = raster_proj,
            filename = "raster_proj.tif",
            overwrite = TRUE)

#shapefile
setwd("Path")
terra::writeVector(shapefile_proj, 
                   filename = "shapefile_proj.shp",
                   overwrite = TRUE)


#end