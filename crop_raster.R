# Description -------------------------------------------------------------


#This routine imports raster and shapefile files into R, both objects for the 
#same projection, cuts (and mask) according to the polygon.


# Packages ----------------------------------------------------------------

#install, if necessary
install.packages("terra")

#load
library(terra)


# Open file ---------------------------------------------------------------


raster <- rast("Path/raster.tif")
shapefile <- vect("Path/shapefile.shp")


# Project shapefile data --------------------------------------------------


#First, set current crs
shapefile <- project(shapefile,
                     crs(shapefile))

#Now, set a new crs
shapefile_proj <- project(shapefile,
                          crs(raster)) #choose the new projection

shapefile_proj
plot(shapefile_proj)


# Crop and mask raster based on polygon -----------------------------------


raster_crop <- crop(raster,
                    ext(shapefile))

raster_crop <- mask(raster_crop,
                    shapefile)

raster_crop
plot(raster_crop)


# Export raster_crop ------------------------------------------------------


setwd("Path")
writeRaster(x = raster_crop,
            filename = "raster_crop.tif",
            overwrite = TRUE)


#end