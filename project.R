
# Description -------------------------------------------------------------


#This routine imports raster and shapefile files into R, projects the spatRaster 
#and SpatVector objects to another desired projection and exports the objects 
#with a new projection.


# Packages ----------------------------------------------------------------


#install, if necessary
install.packages("terra")

#load
library(terra)


# Open file ---------------------------------------------------------------


raster <- rast("Path/raster.tif")
shapefile <- vect("Path/shapefile.shp")


# Project raster data -----------------------------------------------------


#First, set current crs
terra::crs(raster) <- terra::crs(raster)

#Now, set a new crs
#In the case of a raster object it is preferable to use another raster, 
#but we can also use CRS. To do so, access the function's help and evaluate 
#the available options.

sirgas.crs <- "+proj=utm +zone=23 +south +ellps=GRS80 +units=m +no_defs"
wgs84.crs <- "EPSG:4326"
wgs84.crs2 <- "+proj=longlat +datum=WGS84 +no_defs"


raster_sirgas <- project(raster,
                         sirgas.crs, #choose the new projection or another raster
                         method = "") #check which method is best for your data type

raster_wgs84_opt1 <- project(raster,
                             wgs84.crs, #choose the new projection or another raster
                             method = "") #check which method is best for your data type

raster_wgs84_opt2 <- project(raster,
                             wgs84.crs, #choose the new projection or another raster
                             method = "") #check which method is best for your data type

raster_projras <- project(raster,
                          crs(another_raster),
                          method = "") #check which method is best for your data type

raster_projshp <- project(raster,
                          crs(shp),
                          method = "") #check which method is best for your data type

#read the new object or make a plot() to visialize


# Project shapefile data --------------------------------------------------


#First, set current crs
terra::crs(shapefile) <- terra::crs(shapefile)

#Now, set a new crs
#In the case of a raster object it is preferable to use another raster, 
#but we can also use CRS. To do so, access the function's help and evaluate 
#the available options.

sirgas.crs <- "+proj=utm +zone=23 +south +ellps=GRS80 +units=m +no_defs"
wgs84.crs <- "EPSG:4326"
wgs84.crs2 <- "+proj=longlat +datum=WGS84 +no_defs"

shapefile_sirgas <- project(shapefile,
                            sirgas.crs)

shapefile_wgs84_opt1 <- project(shapefile,
                                wgs84.crs)

shapefile_wgs84_opt2 <- project(shapefile,
                                wgs84.crs)

shapefile_projras <- project(shapefile,
                             crs(raster))

shapefile_projshp <- project(shapefile,
                             crs(another_shp))

#read the new object or make a plot() to visialize


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