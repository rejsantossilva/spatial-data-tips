# Description -------------------------------------------------------------


#This routine imports raster and shapefile files into R, both objects for the 
#same projection, cuts (and mask) according to the polygon.


# Packages ----------------------------------------------------------------


#install, if necessary
install.packages("terra")

#load
library(terra)


# Import raster file as a SpatRaster --------------------------------------


#just a raster file
raster <- rast("Path/raster.tif")

#set of raster files in a folder
ET_1981_2010 <- terra::rast(list.files("Path",
                                       full.names = T,
                                       #pay attention to file format
                                       pattern = ".tif$"))


# Import a vector (shapefile) as a SpatVector -----------------------------


#just a shapefile
shapefile <- vect("Path/shapefile.shp")

#set of shapefiles in a folder
#Make a loop to import shapefiles in a list object

#Define path
path <- "Path"

#List all .shp files
files_shp <- dir(path, pattern = "*.shp")

#Make an empty list to store spatVect objects
shp_list <- list()

rm(i) #remove i before to start loop

for (i in length(files_shp)) {
  # Creates the full path to the file
  path_file <- paste0(path, 
                      files_shp[i])
  #Import the shapefile as a spatialVector object
  shp_list[[i]] <- vect(path_file)
  
  #optional
  print(shp_list[[i]])
  
} rm(i) #remove i index


# Export spatRaster -------------------------------------------------------


#Just a SpatRaster
#Set directory
setwd("Path")

#Export
terra::writeRaster(x = raster, #raster object
                   filename = "raster.tif", #pay attentio to file format
                   NAflag = NA, #determine the signature of NA values
                   datatype = "FLT4S", #determine data type
                   overwrite = TRUE) #overwrite file



#Many SpatRaster
#Set directory
setwd("Path")

#File names
name_file <- c("1", "2", "3")
tif <- ".tif" #file format
name_file <- paste0(nomes, 
                    tif) #paste character


rm(i) #remove i object
for(i in 1 : length(name_file)){
  terra::writeRaster(x = raster[[i]],
                     filename = name_file[i],
                     overwrite = TRUE)
}; rm(i)


# Export SpatVector -------------------------------------------------------


#Set directory
setwd("Path")

#Export
terra::writeVector(x = shapefile, 
                   filename = "shapefile.shp",
                   overwrite = TRUE)


#several files at the same time considering that the spatVect objects are 
#gathered in a list


#File names
name_file <- names(shp_list)
shp <- ".shp" #file format
name_file <- paste0(name_file, 
                    shp) #paste character


rm(i) #remove i object
for(i in 1 : length(name_file)){
  terra::writeVector(x = shp_list[[i]],
                     filename = name_file[i])
  
}; rm(i)


#end