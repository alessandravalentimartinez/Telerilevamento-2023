# VARIABILITY

# Load the required packages
library(raster)
library(ggplot2)
library(patchwork)
library(viridis)

# Set the working directory in Windows
setwd("C:/lab")


# Import the Similaun image from the Sentinel satellite
sen <- brick("sentinel.png")
ncell(sen)  # image size

# Plot the image
plot(sen)
plotRGB(sen, 1, 2, 3, stretch = "Lin") # 1 = NIR, 2 = red, 3 = green

# NIR on g component
plotRGB(sen, 2, 1, 3, stretch = "Lin")

# Calculate the variability over NIR
nir <- sen[[1]]
mean3 <- focal(nir, matrix(1/9, 3, 3), fun = mean)
# Calculate focal values for the neighborhood of focal cells using a matrix of weights,
 # perhaps in combination with a function, mean() in this case
plot(mean3)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd)
plot(sd3)

# Let's create a dataframe
sd3_d <- as.data.frame(sd3, xy = T)

# Plot the dataframe with ggplot2
ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer))

# using viridis
ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis()

# cividis
p1 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "cividis")

# magma 
ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "magma")

# Adding a title
p2 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer))+
  scale_fill_viridis(option = "magma") +
  ggtitle("Standard deviation via the magma colour scale")

p1 + p2


# Multiframe with patchwork

# viridis
p1 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis() +
  ggtitle("Standard deviation via the viridis colour scale")

# inferno
p2 <- ggplot() +
  geom_raster(sd3_d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis(option = "inferno") +
  ggtitle("Standard deviation via the inferno colour scale")

p1 + p2


# Exercise: plot the original image (nir) and its standard deviation
nird <- as.data.frame(nir, xy = T)

p3 <- ggplot() +
  geom_raster(nird,
              mapping = aes(x = x, y = y, fill = sentinel_1)) +
  scale_fill_viridis(option = "cividis") +
  ggtitle("NIR via the cividis colour scale")

p3

p3 + p1
