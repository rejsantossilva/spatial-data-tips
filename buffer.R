
# Description -------------------------------------------------------------


#This routine provides simple steps to create a buffer around a polygon or
#raster object.


# Packages required -------------------------------------------------------


#install, if necessary
install.packages("terra")

#load
library(terra)



# Open spatial data -------------------------------------------------------


raster <- ras("Path/raster.tif")
shapefile <- vect("Path/shapefile.shp")


# Project shapefile -------------------------------------------------------

#Please, pay attention to the current projection of your object. If it is 
#necessary to change the projection, check the routine that provides this step.


# Make a buffer with 2000 meters ------------------------------------------


#shapefile 
shapefile_buffer <- terra::buffer(x = shapefile,
                                  width = 100) #meter unit


#raster
raster_buffer <- terra::buffer(x = raster,
                               width = 2000) #meter unit


# Export matopiba_buffer_utm shapefile ------------------------------------


#Set directory
setwd("Path")

#shapefile
terra::writeVector(shapefile_buffer, 
                   filename = "shapefile_buffer.shp",
                   overwrite = TRUE)


#shapefile
terra::writeRaster(raster_buffer, 
                   filename = "raster_buffer.tif",
                   overwrite = TRUE)


#the end