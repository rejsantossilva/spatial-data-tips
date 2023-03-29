
# Description -------------------------------------------------------------


#This routine provides functions to change the resolution of a spatRaster 
#object using the terra package.

#In addition to changing the resolution, this routine resamples the spatRaster 
#object to the same extent as another spatRaster object.


# Packages ----------------------------------------------------------------


library(terra)


# Open raster layer -------------------------------------------------------


raster_30m <- rast("Path/raster.tif")
raster_1km <- rast("Path/raster_model.tif")


# Upscaling map -----------------------------------------------------------


#To upscale map from 30 meters to 1 km it's necessary to estimate the pixel 
#size in the original spatRaster object.

#To estimate correctly, note whether your raster is in decimal degrees or 
#UTM (usually meters). This is critical to getting the "fact" argument right, 
#which tells the number of cells horizontally and vertically.

#If the resolution is in decimal degrees (e.g. WGS84 lon/lat projection 
#(EPSG: 4326), the resolution is expected to be ~0.0002694946, 0.0002694946. 
#So, multiply 0.0002694946 * 38 to get a cell ~0.01024079, equivalent to ~1km.

raster_1km <- aggregate(x = raster_30m,
                        fact = c(38, 38),
                        #check the options based on raster object informations
                        #eg.: near to categorical values or billinear to bilinear
                        #interpolation.
                        method = "")

#If raster_1km is an overlayer object
nlyrs <- nlyr(raster_30m)
raster_1km <- aggregate(x = raster_30m,
                        fact = c(38, 38, nlyrs),
                        #check the options based on raster object informations
                        #eg.: near to categorical values or billinear to bilinear
                        #interpolation.
                        method = "")

# Downscaling map ---------------------------------------------------------


#Create a SpatRaster with a higher resolution (smaller cells).
#To increase the resolution (reduce the cell size) of a spatRaster object it 
#will also be necessary to estimate the pixel size in the original object.

#if raster_30m is in decimal degrees
raster_30m <- disagg(x = raster_1km,
                     fact = c(36, 36),
                     #check the options based on raster object informations
                     #eg.: near to categorical values or billinear to bilinear
                     #interpolation.
                     method = "")

#If raster_1km is overlayer object
nlyrs <- nlyr(raster_1km)
raster_30m <- disagg(x = raster_1km,
                     fact = c(36, 36, nlyrs),
                     #check the options based on raster object informations
                     #eg.: near to categorical values or billinear to bilinear
                     #interpolation.
                     method = "")


# Resample spatRaster -----------------------------------------------------


#resample function allows changing the resolution of a spatRaster object 
#that is based on another spatRaster object with the same projection. 
#For this, it is necessary to confirm that both objects have the same 
#crs/projection configuration. You can access the project.R script for more 
#information on this step).

raster_30m <- resample(x = raster_1km,
                       y = raster_30m,
                       #check the options based on raster object informations
                       #eg.: near to categorical values or billinear to bilinear
                       #interpolation.
                       method = "")


raster_1km <- resample(x = raster_30m,
                       y = raster_1km,
                       #check the options based on raster object informations
                       #eg.: near to categorical values or billinear to bilinear
                       #interpolation.
                       method = "")


#end