# VEGETATION INDICES: calculating spectral indices

# Load the raster package
library(raster)

# Set the working directory in Windows
setwd("C:/lab/data")


# IMAGE FROM 1992 ----

# Import the image.png from 1992
l1992 <- brick("defor1_.png")
l1992

# Plot image with plot() and plotRGB()
plot(l1992)  # 3 layers
plotRGB(l1992, 1, 2, 3, stretch = "Lin")

# What is NIR? NIR is red since the image is red
# NIR = 1
# red = 2
# green = 3

# images exported by NASA with NIR, first band is 1

# Calculate DVI for 1992
dvi1992 = l1992[[1]] - l1992[[2]]  # NIR - red
dvi1992

# Plot the DVI
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col = cl) 
# the darker the red the healthier the vegetation

plot(l1992)
# reflectance is between 0 and 255
# so the DVI image range is -255 to 255, because red is 0 - 255


# IMAGE FROM 2006 ----

# Import the most recent image
l2006 <- brick("C:/lab/defor2_.png")
l2006

# Plot image from 2006
plot(l2006)
plotRGB(l2006, 1, 2, 3, stretch = "Lin")

# Calculate DVI for 2006
dvi2006 = l2006[[1]] - l2006[[2]]

# Plot the DVI
plot(dvi2006, col = cl)


# TIME DIFFERENCE ----

# Plot the image from 1992 ontop of that of 2006
par(mfrow = c(2, 1))
plotRGB(l1992, 1, 2, 3, stretch = "Lin")
plotRGB(l2006, 1, 2, 3, stretch = "Lin")

# Plot the image from 1992 beside that of 2006
par(mfrow = c(1,2))
plotRGB(l1992, 1, 2, 3, stretch = "Lin")
plotRGB(l2006, 1, 2, 3, stretch = "Lin")

dev.off()

# Plot the DVI of 1992 and 2006 in a multiframe
par(mfrow = c(1, 2))
plot(dvi1992, col = cl) 
plot(dvi2006, col = cl) 

dev.off()

# Multitemporal analysis: calculate the difference of DVI from 1992 to 2006
dvi_dif = dvi1992 - dvi2006

# Plot the results of multitemporal analysis
cld <- colorRampPalette(c("blue", "white", "red"))(100)
plot(dvi_dif, col = cld)
# the higher the difference the bigger the deforestation
# if the difference is negative there is a gain in forest cover

# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1

# Hence, NDVI can be used to compare images with a different radiometric resolution


# NDVI ----
# NDVI = Normalized Difference Vegetation Index

# Calculate NDVI for 1992
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])  # standardization
plot(ndvi1992, col = cl)  # now the index is standard, from -1 to +1

# Calculate NDVI for 2006
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])
plot(ndvi2006, col = cl)

# Calculate differences of NDVI between 1992 and 2006
ndvi_dif = ndvi1992 - ndvi2006
plot(ndvi_dif, col = cld)
