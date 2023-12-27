#My first code in Git Hub
#How to plot images

#Packages are located in CRAN, it is the server from which we also downloaded R. 
#Let's install and load the raster package
install.packages("raster")
library(raster)

#import data, setting the working directory 
setwd("C:/lab")
getwd()

#Brick function to import the data
l2011 <- brick("p224r63_2011_masked.grd")

#plot data in a raw way
plot(l2011)

#Let's change colors
cl<- colorRampPalette(c("red", "orange", "yellow")) (100) #n. of shades
cl_5<- colorRampPalette(c("red", "orange", "yellow")) (5) #less details

# Plot with the colour palettes we created
plot(l2011, col=cl)
plot(l2011, col=cl_5)

# Plot just one element of the multi-layer image
plot(l2011[[4]], col=cl)

nir <- l2011[[4]] #or : nir <- l2011$B4_sre
plot(nir, col=cl)
plot(nir, col=cl_5)

#Change of palette
newpalette <- colorRampPalette(c("darkolivegreen1", "darkgoldenrod1", "cadetblue", "cyan")) (1000)
plot(l2011, col=newpalette)
plot(l2011[[4]], col=newpalette) #the fourth layer

# Exercise: plot the NIR band
# b1 = blue
# b2 = green
# b3 = red
# b4 = NIR

#New colour palette 
palette <- colorRampPalette(c("darkred", "chocolate4", "bisque3")) (100)

# Plot the NIR band of the image in different ways
plot(l2011$B4_sre, col=palette)
#or
plot(l2011[[4]], col=palette)

# to clean plots
dev.off()

#Function to export graphs
pdf("myfirstgraph.pdf")
plot(l2011[[4]], col=newpalette)
dev.off()

png("first.png")
plot(l2011[[4]], col = palette) 
dev.off()


#Function to plot 2 or more graphs in a multiframe, that is, I create many parts within the same block.
#we put the red band above and NIR below.
#I arrange them on two rows and one column.

par(mfrow=c(2,1)) # a multiframe with 2 rows and 1 column
plot(l2011[[3]], col=palette) #red
plot(l2011[[4]], col=palette) #NIR

dev.off() # to remove the multiframe

# Here we can see the differences between 2 different shaded palette
par(mfrow = c(2, 1))
plot(nir, col = cl) # 100-shaded palette, more details
plot(nir, col = cl_5) # 5-shaded palette, less details

dev.off()


# Let's plot all bands/layers
par(mfrow = c(2, 2))

#blue
clb<- colorRampPalette(c("cadetblue3", "cornflowerblue", "cadetblue", "cyan")) (1000)
plot(l2011[[1]], col=clb)

#green
clg <- colorRampPalette(c("darkolivegreen2", "chartreuse4", "aquamarine3")) (1000)
plot(l2011[[2]], col=clg)

#red
clr <- colorRampPalette(c("coral", "brown2", "darkred")) (1000)
plot(l2011[[3]], col=clr)

#NIR
clnir <- colorRampPalette(c("beige", "bisque", "burlywood3")) (1000)
plot(l2011[[4]], col=clnir)

par(mfrow=c(2,2))
plot(l2011[[1]], col=clb)
plot(l2011[[2]], col=clg)
plot(l2011[[3]], col=clr)
plot(l2011[[4]], col=clnir)

#save as pdf and png

pdf("mysecondgraph.pdf")
par(mfrow=c(2,2))
plot(l2011[[1]], col=clb)
plot(l2011[[2]], col=clg)
plot(l2011[[3]], col=clr)
plot(l2011[[4]], col=clnir)
dev.off()


png("myfirstpng.png")
par(mfrow=c(2,2))
plot(l2011[[1]], col=clb)
plot(l2011[[2]], col=clg)
plot(l2011[[3]], col=clr)
plot(l2011[[4]], col=clnir)
dev.off()

# RGB plotting, plot of multi-layered raster object
 # 3 bands are combined such that they represent the red, green and blue channel
 # This function can be used to make 'true (or false) color images
 # from Landsat and other multi-band satellite images.

# Blue = 1
# Green = 2
# Red = 3

plotRGB(l2011, r = 3, g = 2, b = 1, stretch = "Lin") # natural colours
plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "Lin") # vegetation is red
plotRGB(l2011, r = 3, g = 2, b = 4, stretch = "Lin") # vegetation is blue
plotRGB(l2011, r = 3, g = 4, b = 2, stretch = "Lin") # vegetation is green
# the fourth band is the NIR band, plants strongly reflect NIR

# Multiframe with natural and false colours
par(mfrow = c(2, 1))
plotRGB(l2011, r = 3, g = 2, b = 1, stretch = "Lin")  # natural colours
plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "Lin")

# Histogram stretching
plotRGB(l2011, r = 3, g = 2, b = 1, stretch = "Hist")  # natural colours
plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "Hist")

# Mixed stretching, differences between the 2 types of stretch
plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "Lin")
plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "Hist")

dev.off()

# Exercise: plot the NIR band
plot(l2011[[4]])

# Import the 1988 image
l1988 <- brick("p224r63_1988_masked.grd")
plot(l1988)

# Plot in RGB space (natural colours)
plotRGB(l1988, r = 3, g = 2, b = 1, stretch = "Lin")
plotRGB(l1988, r = 4, g = 3, b = 2, stretch = "Lin")

plotRGB(l1988, 4, 3, 2, stretch = "Lin")  # faster way

# Multiframe to see the differences between 1988 and 2011
par(mfrow = c(2,1))
plotRGB(l1988, 4, 3, 2, stretch = "Lin")
plotRGB(l2011, 4, 3, 2, stretch = "Lin")

dev.off()

plotRGB(l1988, 4, 3, 2, stretch = "Hist")  # histogram stretch

# Multiframe with 4 images
par(mfrow=c(2,2))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Hist")
plotRGB(l2011, 4, 3, 2, stretch="Hist")


