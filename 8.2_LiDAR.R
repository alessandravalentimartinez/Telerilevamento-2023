# LiDAR: 3D in R

# LiDAR is a method for determining ranges by targeting an object or a surface
 # with a laser and measuring the time for the reflected light to return to the receiver.
# It may scan multiple directions -> 3D

# Load the required packages
library(raster)  # Geographic Data Analysis and Modeling
library(rgdal)  # Geospatial Data Abstraction Library
library(viridis)
library(ggplot2)
library(patchwork)

# Set working directory in Windows
setwd("C:/lab/lidar")


# Digital Surface Model 2013 ----

# Load data
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013  # info of the raster object

# Plot the DSM 2013
plot(dsm_2013, main = "Lidar Digital Surface Model San Genesio/Jenesien")

# Coerce the DSM 2013 into a dataframe
dsm_2013d <- as.data.frame(dsm_2013, xy = T)
head(dsm_2013d)

# Plot with ggplot
ggplot() +
  geom_raster(dsm_2013d,
              mapping = aes(x = x, y = y, fill = X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle("Lidar Digital Surface Model San Genesio/Jenesien")


# Digital Terrain Model 2013 ----

# Load data
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dtm_2013

# Plot the DTM 2013
plot(dtm_2013, main = "Lidar Digital Terrain Model San Genesio/Jenesien")

# Coerce the DTM 2013 into a dataframe
dtm_2013d <- as.data.frame(dtm_2013, xy = T)
head(dtm_2013d)

# Plot with ggplot
ggplot() +
  geom_raster(dtm_2013d,
              mapping = aes(x = x, y = y, fill = X2013Elevation_DigitalTerrainModel.0.5m)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("Lidar Digital Terrain Model San Genesio/Jenesien")


# Canopy Height Model 2013 ----

# Create CHM 2013 as difference between DSM and DTM
chm_2013 <- dsm_2013 - dtm_2013
chm_2013  # view CHM attributes

# Coerce the CHM 2013 into a dataframe
chm_2013d <- as.data.frame(chm_2013, xy = T)

# Plot CHM 2013 using ggplot
ggplot() +
  geom_raster(chm_2013d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2013 San Genesio/Jenesien")

# Save the CHM as tif file
writeRaster(chm_2013,"chm_2013_San_genesio.tif")


# Plots 2013 ----

# Multiframe using patchwork
p1 <- ggplot() +
  geom_raster(dsm_2013d,
              mapping = aes(x = x, y = y, fill = X2013Elevation_DigitalElevationModel.0.5m)) +
  scale_fill_viridis() +
  ggtitle("Lidar Digital Surface Model San Genesio/Jenesien")

p2 <- ggplot() +
  geom_raster(dtm_2013d,
              mapping = aes(x = x, y = y, fill = X2013Elevation_DigitalTerrainModel.0.5m)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("Lidar Digital Terrain Model San Genesio/Jenesien")

p3 <- ggplot() +
  geom_raster(chm_2013d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2013 San Genesio/Jenesien")

p1 + p2 + p3


# Digital Surface Model 2004 ----

# Load data
dsm_2004 <- raster("2004Elevation_DigitalElevationModel-2.5m.tif")
dsm_2004

# Plot the DSM 2004
plot(dsm_2004, main = "Lidar Digital Surface Model San Genesio/Jenesien")


# Digital Terrain Model 2004 ----

# Load data
dtm_2004 <- raster("2004Elevation_DigitalTerrainModel-2.5m.tif")
dtm_2004

# Plot the DTM 2004
plot(dtm_2004, main = "Lidar Digital Terrain Model San Genesio/Jenesien")


# # Canopy Height Model 2004 ----

# Create CHM 2004 as difference between DSM and DTM
chm_2004 <- dsm_2004 - dtm_2004
chm_2004

# Coerce into a dataframe
chm_2004d <- as.data.frame(chm_2004, xy = T)

# Plot CHM 2004
ggplot() +
  geom_raster(chm_2004d,
              mapping = aes(x = x,y = y, fill = layer)) +
  scale_fill_viridis() +
  ggtitle("CHM 2004 San Genesio/Jenesien")

# Save CHM as tif file
writeRaster(chm_2004,"chm_2004_San_genesio.tif")
