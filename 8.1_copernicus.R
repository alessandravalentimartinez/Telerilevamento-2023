# COPERNICUS: downloading and visualizing data of Earth Observation

# Load the required packages
library(ncdf4)
library(raster)
library(ggplot2)
library(viridis)

# Set the working directory in Windows
setwd("C:/lab")

# register and download data from:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html


# Upload the data as a raster object
soil_moist <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")
soil_moist
ncell(soil_moist)  # the total size
plot(soil_moist)  # plot

# Coerce data into a dataframe
soil_moist_d <- as.data.frame(soil_moist, xy = T)

# Columns' names of the dataframe
colnames(soil_moist_d)

# Plot with ggplot
ggplot() +
  geom_raster(soil_moist_d,
              mapping = aes(x = x, y = y, fill = Surface.Soil.Moisture)) +
  ggtitle("Soil Moisture from Copernicus")
 # fill = third column of the dataframe

# Let's crop the image by coordinates
ext <- c(23, 30, 62, 68)
soil_moist_crop <- crop(soil_moist, ext)
soil_moist_crop

# Coerce the cropped image into a dataframe
soil_moist_crop_d <- as.data.frame(soil_moist_crop, xy= T)

# Plot the cropped image with ggplot, adding viridis scale color
ggplot() +
  geom_raster(soil_moist_crop_d,
              mapping = aes(x = x, y = y, fill = Surface.Soil.Moisture)) +
  ggtitle("Cropped soil moisture from Copernicus") +
  scale_fill_viridis()


# Exercise: the same path but with an other image chosen by me

fcover <- raster("c_gls_FCOVER-RT0_202006300000_GLOBE_PROBAV_V2.0.1.nc")
fcover
ncell(fcover)
plot(fcover)

# Too big, let's crop
ext <- c(166, 179, -48, -34)  # New Zealand coordinates
fcover_nz <- crop(fcover, ext)
fcover_nz_d <- as.data.frame(fcover_nz, xy = T)
colnames(fcover_nz_d)

ggplot() +
  geom_raster(fcover_nz_d,
              mapping = aes(x = x, y = y,
                            fill = Fraction.of.green.Vegetation.Cover.1km))
# fill = third column of the dataframe

# Let's focus on Egmnot National Park
ext <- c(173, 176, -40, -38 )
fcover_eg <- crop(fcover_nz, ext)
plot(fcover_eg)
fcover_eg_d <- as.data.frame(fcover_eg, xy = T)

# Plot using ggplot
ggplot() +
  geom_raster(fcover_eg_d,
              mapping = aes(x = x, y = y,
                            fill = Fraction.of.green.Vegetation.Cover.1km)) +
  ggtitle("Cropped soil moisture from Copernicus") +
  scale_fill_viridis()
