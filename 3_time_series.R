# TIME SERIES ANALYSIS: importing and analysing several images

# Data and code from Emanuela Cosma

# Load the required packages
library(raster)
library(rasterVis)
library(rgdal)


# 1 - Greenland increase of temperature ----

# Set the working directory in Windows
setwd("C:/lab/greenland")

# raster() function to import tif images with a single layer
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

ls()  # list of objects imported and loaded

# Plot in a multiframe
par(mfrow = c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# List of files:
rlist <- list.files(pattern = "lst")
rlist

# Apply a function over a list or vector
import <- lapply(rlist, raster)  # to apply a function to many files of a list
import

# Stack vectors from a dataframe or list
TGr <- stack(import)
TGr  # 4 layers
# stacking vectors concatenates multiple vectors into a single vector

plot(TGr)  # now we have all the images in a single element

# Plot with RGB
plotRGB(TGr, 1, 2, 3, stretch = "Lin")
plotRGB(TGr, 2, 3, 4, stretch = "Lin")

# Plot using a colour palette
cl <- colorRampPalette(c("blue","lightblue","pink","red"))(100)
plot(TGr, col = cl)

dev.off()

# Difference between 2005 and 2000:
dift = TGr[[2]] - TGr[[1]]
plot(dift, col = cl)


# 2 - NO2 decrease during the lockdown period ----

# New working directory
setwd("C:/lab/en")

# Import the first image file
en01 <- raster("EN_0001.png")
en01
plot(en01) # it's January, before the lockdown

# Plot using a colour palette
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en01, col = cl)

# Plot the last image
en13 <- raster("EN_0013.png")
plot(en13, col = cl) # it's March, after lockdown began

# Let's import the whole set
rlist_2 <- list.files(pattern = "EN")
rlist_2

# lapply(X, FUN)
rimp <- lapply(rlist_2, raster)
rimp

# stack
en <- stack(rimp)
en

# Plot everything
plot(en, col = cl)

# Check by visualizing plot in a multiframe
par(mfrow = c(1,2))
plot(en[[1]], col = cl)
plot(en01, col = cl)
dev.off()

# Check by looking for differences
dif_check <- en01 - en[[1]]
dif_check
plot(dif_check)

# Plot first and last images
par(mfrow = c(1,2))
plot(en[[1]], col = cl)
plot(en[[13]], col = cl)
# or by using stack()
en113 <- stack(en[[1]], en[[13]])
plot(en113, col = cl)

# Let's see the difference:
difen <-  en[[1]] - en[[13]]
cl_dif <- colorRampPalette(c('blue','white','red'))(100) #
par(mfrow = c(1,1))
plot(difen, col = cl_dif)

# plotRGB
par(mfrow = c(2,1))
plotRGB(en, 1, 7, 13, stretch = "lin")
plotRGB(en, 1, 7, 13, stretch = "hist")
