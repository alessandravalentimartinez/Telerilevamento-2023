#Telerilevamento geo-ecologico 2023/2024
#Alessandra Valenti Martinez

#The goal of this project is to assess the vegetation condition on La Palma Island
# considering the volcanic eruption occured in 2021


# First of all, we open the packages from our library:
library(raster) #creating, reading, manipulating, and writing raster data
library(ggplot2) #data visualization
library(tidyterra) #interface between terra and tidyverse 
library(terra) #creating, reading, manipulating, and writing raster data
library(patchwork) #needed for multiframe graphics
library(viridis) #needed for plot the color palette


# Now we set our working directory:

setwd("C:/lab/Esame")


########################################################################
# NDVI 
#Calculate NDVI
#is an indicator of the greenness of the biomes
#NDVI = (REF_nir – REF_red)/(REF_nir + REF_red)
#where REF_nir and REF_red are the spectral reflectances 
#measured in the near infrared and red wavebands respectively
# We get the data from Copernicus

ndvi2020 <- rast("ndvi2020.nc")
ndvi2021 <- rast("ndvi2021.nc")
ndvi2022 <- rast("ndvi2022.nc")
ndvi2023 <- rast("ndvi2023.nc")


# Now let's crop the data to only look at our area
new_ext <- c (-18.0106, -17.7140, 28.4404, 28.8565)
ndvi2020_newext <- crop(ndvi2020, new_ext)
ndvi2021_newext <- crop(ndvi2021, new_ext)
ndvi2022_newext <- crop(ndvi2022, new_ext)
ndvi2023_newext <- crop(ndvi2023, new_ext)

#Let's take a look at our data:
ndvi2020_newext
ndvi2021_newext
ndvi2022_newext
ndvi2023_newext



### Now let's plot the graphs

##2020
ndvi2020_gg <- ggplot() + 
  geom_raster(ndvi2020_newext, mapping = aes(x=x,  y = y, fill = NDVI)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2020 NDVI")


#Let's add the legend
ndvi2020_gg <- ndvi2020_gg + labs(fill= "NDVI")
ndvi2020_gg

#Let's save the new plot
ggsave(filename = "ndvi2020.png", plot = ndvi2020_gg)


##2021
ndvi2021_gg <- ggplot() + 
  geom_raster(ndvi2021_newext, mapping = aes(x=x,  y = y, fill = NDVI)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2021 NDVI")


#Let's add the legend
ndvi2021_gg <- ndvi2021_gg + labs(fill= "NDVI")
ndvi2021_gg

#Let's save the new plot
ggsave(filename = "ndvi2021.png", plot = ndvi2021_gg)

##2022
ndvi2022_gg <- ggplot() + 
  geom_raster(ndvi2022_newext, mapping = aes(x=x,  y = y, fill = NDVI)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2022 NDVI")


#Let's add the legend
ndvi2022_gg <- ndvi2022_gg + labs(fill= "NDVI")
ndvi2022_gg

#Let's save the new plot
ggsave(filename = "ndvi2022.png", plot = ndvi2022_gg)


##2023
ndvi2023_gg <- ggplot() + 
  geom_raster(ndvi2023_newext, mapping = aes(x=x,  y = y, fill = NDVI)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2023 NDVI")


#Let's add the legend
ndvi2023_gg <- ndvi2023_gg + labs(fill= "NDVI")
ndvi2023_gg

#Let's save the new plot
ggsave(filename = "ndvi2023.png", plot = ndvi2023_gg)


# Now let's look at all the plots together to compare them
NDVIcomparison <- ndvi2020_gg + ndvi2021_gg + ndvi2022_gg + ndvi2023_gg
print(NDVIcomparison)
ggsave(filename = "NDVIcomparison.png" , plot = NDVIcomparison)



########

#List of files
rlist <- list.files(pattern ="ndvi") #make a list of the files that start with "ndvi"
rlist 


# Apply a function over a list or vector
import <- lapply(rlist, raster) # specify the list and the function to import the data
import 

# Let's stack the data, all the four layers in a single file:
ndvistacked <- stack(import)

lapalma_ndvistacked <- crop(ndvistacked, new_ext)
lapalma_ndvistacked

# Now let's look at the difference between the NDVI in 2020 and in 2023

ndvidifference2023_raw <- lapalma_ndvistacked[[4]]-lapalma_ndvistacked[[1]]

# Set all values that equal zero to NA
ndvidifference2023_ <- ndvidifference2023_raw; ndvidifference2023_[ndvidifference2023_ == 0] <- NA 
ndvidifference2023 <- as.data.frame(ndvidifference2023_, xy=TRUE)


ndvidifference2023_plot <-ggplot() + 
  geom_raster(ndvidifference2023, mapping = aes(x=x,  y = y, fill = layer)) +
  scale_fill_viridis(option = "rocket") +
  ggtitle("NDVI difference between 2020 2023")

ndvidifference2023_plot

ggsave(filename = "NDVI_difference2023.png", plot = ndvidifference2023_plot)


# Now let's look at the difference between the NDVI in 2021 and in 2022
ndvidifference2122_raw <- lapalma_ndvistacked[[3]]-lapalma_ndvistacked[[2]]

# Set all values that equal zero to NA
ndvidifference2122_ <- ndvidifference2122_raw; ndvidifference2122_[ndvidifference2122_ == 0] <- NA 
ndvidifference2122 <- as.data.frame(ndvidifference2122_, xy=TRUE)

#Let's plot the difference
ndvidifference2122_plot <- ggplot() + 
  geom_raster(ndvidifference2122, mapping = aes(x=x,  y = y, fill = layer)) +
  scale_fill_viridis(option = "rocket") +
  ggtitle("NDVI difference between 2021 2022")

ndvidifference2122_plot

ggsave(filename = "NDVI_difference2122.png", plot = ndvidifference2122_plot)



########################################################################
# FCOVER

# Calculate FCOVER
# FCOVER is a metric for quantifying the fraction of vegetation of an area
# range from 0 to +1
# We get the data from Copernicus

fcover2020 <- rast ("fcover2020.nc")
fcover2021 <- rast ("fcover2021.nc")
fcover2022 <- rast ("fcover2022.nc")
fcover2023 <- rast ("fcover2023.nc")


# Now let's crop the data to only look at our area
new_ext <- c (-18.0106, -17.7140, 28.4404, 28.8565)
fcover2020_newext <- crop(fcover2020, new_ext)
fcover2021_newext <- crop(fcover2021, new_ext)
fcover2022_newext <- crop(fcover2022, new_ext)
fcover2023_newext <- crop(fcover2023, new_ext)





### Now let's plot the graphs for each years

##2020
fcover2020_gg <- ggplot() + 
  geom_raster(fcover2020_newext, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2020 fcover")


#Let's add the legend
fcover2020_gg <- fcover2020_gg + labs(fill= "fcover")
fcover2020_gg

#Let's save the new plot
ggsave(filename = "FCOVER2020.png", plot = fcover2020_gg)


##2021
fcover2021_gg <- ggplot() + 
  geom_raster(fcover2021_newext, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2021 fcover") 

#Let's add the legend
fcover2021_gg <- fcover2021_gg + labs(fill= "fcover")
fcover2021_gg

#Let's save the new plot
ggsave(filename = "FCOVER2021.png", plot = fcover2021_gg)

##2022
fcover2022_gg <- ggplot() + 
  geom_raster(fcover2022_newext, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2022 fcover")

#Let's add the legend
fcover2022_gg <- fcover2022_gg + labs(fill= "fcover")
fcover2022_gg

#Let's save the new plot
ggsave(filename = "FCOVER2022.png", plot = fcover2022_gg)

##2023
fcover2023_gg <- ggplot() + 
  geom_raster(fcover2023_newext, mapping = aes(x=x,  y = y, fill = FCOVER)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2023 fcover")

#Let's add the legend
fcover2023_gg <- fcover2023_gg + labs(fill= "fcover")
fcover2023_gg

#Let's save the new plot
ggsave(filename = "FCOVER2023.png", plot = fcover2023_gg)




# Now let's look at all the plots together to compare them
fcover_comparison <- fcover2020_gg + fcover2021_gg + fcover2022_gg + fcover2023_gg
fcover_comparison

ggsave(filename = "FCOVER_comparison.png", plot = fcover_comparison)




########

# List of files
rlist <- list.files(pattern= "fcover")
rlist 

# Apply a function over a list or vector
import <- lapply(rlist, raster)
import


# Let's stack the data:
fcoverstacked <- stack(import)
fcoverstacked

#Let's crop the data
fcoverstacked_newext <- crop(fcoverstacked, new_ext)
fcoverstacked_newext


#Now let's look at the difference between 2023 and 2020
fcover_difference2320 <- fcoverstacked_newext[[4]]-fcoverstacked_newext[[1]]
fcover_difference2320_df <- as.data.frame(fcover_difference2320, xy = TRUE)

fcoverdifference2320_plot <- ggplot() + 
  geom_raster(fcover_difference2320_df, mapping = aes(x=x,  y = y, fill = layer)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("Difference in Fraction of Green Vegetation Cover 2020 2023") 

fcoverdifference2320_plot

ggsave(filename = "FCOVER_difference2320.png", plot = fcoverdifference2320_plot)


#Now let's look at the difference between 2021 and 2022
fcover_difference2122 <- fcoverstacked_newext[[3]]-fcoverstacked_newext[[2]]
fcover_difference2122_df <- as.data.frame(fcover_difference2122, xy = TRUE)

fcoverdifference2122_plot <- ggplot() + 
  geom_raster(fcover_difference2122_df, mapping = aes(x=x,  y = y, fill = layer)) +
  scale_fill_viridis(option = "magma") +
  ggtitle("Difference in Fraction of Green Vegetation Cover 2021 2022") 

fcoverdifference2122_plot

ggsave(filename = "FCOVER_difference2122.png", plot = fcoverdifference2122_plot)



####################################################################

# Now let's do the same for the LAI
# Calculate LAI
# LAI is a metric for quantifying the leaf area index of an area
# range from 0 to +∞
# We get the data from Copernicus

lai_2020 <- rast ("lai_2020.nc")
lai_2021 <- rast ("lai_2021.nc")
lai_2022 <- rast ("lai_2022.nc")
lai_2023 <- rast ("lai_2023.nc")

# Now let's crop the data to only look at our area
new_ext <- c (-18.0106, -17.7140, 28.4404, 28.8565)
lai_2020_newext <- crop(lai_2020, new_ext)
lai_2021_newext <- crop(lai_2021, new_ext)
lai_2022_newext <- crop(lai_2022, new_ext)
lai_2023_newext <- crop(lai_2023, new_ext)


### Now let's plot the graphs

##2020
lai_2020_gg <- ggplot() + 
  geom_raster(lai_2020_newext, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2020 LAI") 


# Let's add the legend
lai_2020_gg <- lai_2020_gg + labs(fill= "LAI")
lai_2020_gg

# Let's save the new plot
ggsave(filename = "LAI_2020.png", plot = lai_2020_gg)


##2021
lai_2021_gg <- ggplot() + 
  geom_raster(lai_2021_newext, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2021 LAI") 

# Let's add the legend
lai_2021_gg <- lai_2021_gg + labs(fill= "LAI")
lai_2021_gg

# Let's save the new plot
ggsave(filename = "LAI_2021.png", plot = lai_2021_gg)

##2022
lai_2022_gg <- ggplot() + 
  geom_raster(lai_2022_newext, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2022 LAI") 

# Let's add the legend
lai_2022_gg <- lai_2022_gg + labs(fill= "LAI")
lai_2022_gg

# Let's save the new plot
ggsave(filename = "LAI_2022.png", plot = lai_2022_gg)

#2023
lai_2023_gg <- ggplot() + 
  geom_raster(lai_2023_newext, mapping = aes(x=x,  y = y, fill = LAI )) +
  scale_fill_viridis(option = "magma") +
  ggtitle("2023 LAI") 

# Let's add the legend
lai_2023_gg <- lai_2023_gg + labs(fill= "LAI")
lai_2023_gg

# Let's save the new plot
ggsave(filename = "LAI_2023.png", plot = lai_2023_gg)




# Now let's look at all the plots together to compare them
lai_comparison <- lai_2020_gg + lai_2021_gg + lai_2022_gg + lai_2023_gg
lai_comparison

ggsave(filename = "LAI_comparison.png", plot = lai_comparison)




########
# List of files
rlist <- list.files(pattern= "lai_2")
rlist 

# Apply a function over a list or vector
import <- lapply(rlist, raster)
import

# Let's stack the data:
laistacked <- stack(import)
laistacked

# Let's crop the data
laistacked_newext <- crop(laistacked, new_ext)
laistacked_newext


# Now let's look at the difference between 2023 and 2020
lai_difference2320 <- laistacked_newext[[4]]-laistacked_newext[[1]]
laidifference2320_df <-  as.data.frame(lai_difference2320, xy = TRUE)

laidifference2320_plot <- ggplot() + 
  geom_raster(laidifference2320_df, mapping = aes(x=x,  y = y, fill = layer)) +
  scale_fill_viridis(option = "rocket") +
  ggtitle("LAI difference 2020 2023")

laidifference2320_plot
ggsave(filename = "LAI_difference2320.png", plot = laidifference2320_plot)


# Now let's look at the difference between 2021 and 2022
lai_difference2122 <- laistacked_newext[[3]]-laistacked_newext[[2]]
laidifference2122_df <-  as.data.frame(lai_difference2122, xy = TRUE)

laidifference2122_plot <- ggplot() + 
  geom_raster(laidifference2122_df, mapping = aes(x=x,  y = y, fill = layer)) +
  scale_fill_viridis(option = "rocket") +
  ggtitle("LAI difference 2021 2022")

laidifference2122_plot
ggsave(filename = "LAI_difference2122.png", plot = laidifference2122_plot)
