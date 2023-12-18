
# Description -------------------------------------------------------------


#This routine roduces a frequency table of the values contained in the spatRaster
#object and calculates the percentage for each class.


# Packages ----------------------------------------------------------------


library(terra)
library(dplyr)


# Open raster layer -------------------------------------------------------


raster <- rast("Path/raster.tif")


# Make a frequence table --------------------------------------------------


#Identify which are classes
freq_raster <- terra::freq(raster)
freq_raster <- as.data.frame(freq_raster)

#Make a new collunm and estimate classes percentage
freq_raster %>%
  #Make a countT collunm that will be the sum of count collunm
  mutate(countT= sum(count)) %>%
  #Calculate values by group/category
  group_by(value, .add=TRUE) %>%
  #Make a per collunm that will be the percentage values
  mutate(per=paste0(round(100*count/countT,2),'%'))


#end
