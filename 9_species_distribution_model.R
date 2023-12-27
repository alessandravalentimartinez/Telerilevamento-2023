# SPECIES DISTRIBUTION MODELLING

# Load the required packages
library(sdm)  # species distribution modelling
library(rgdal)  # to manage data about species
library(raster)


# Load a file found within the sdm package
file <- system.file("external/species.shp", package = "sdm")
species_data <- shapefile("C:/Users/raffo/AppData/Local/R/win-library/4.3/sdm/external/species.shp")
species_data  # looking at the dataset

# Occurrence is the presence/absence of a species or 1|0

# Plot the data about species
plot(species_data)
plot(species_data, pch = 19) # pch for the pattern of the occurrence points

# Looking at the occurrences
species_data$Occurrence

# Plot the presences, 1 = presence
presences <- species_data[species_data$Occurrence == 1,]
presences
plot(presences, col = "blue", pch = 19)

# Plot the absences, 0 = absence
absences <- species_data[species_data$Occurrence == 0,]
absences
plot(absences, col = "red", pch = 19)

# Plotting total occurrences but divided by colour
plot(presences, col = "blue", pch = 19)
points(absences, col = "red", pch = 19) # points() to plot it with the previous one

# Predictors: look at the path
path <- system.file("external", package = "sdm")
path

# List and stack the predictors
lst <- list.files(path = path, pattern = 'asc', full.names = T)
lst
preds <- stack(lst)
preds

# Plot the predictors
plot(preds)
plot(preds$vegetation)  # vegetation

# remember: we don't like this kind of palette -> from blue to red

# Colours palette
cl <- colorRampPalette(c('lightyellow', 'yellow','orange', 'darkorange','darkred')) (100)
plot(preds, col = cl)

# Plot predictors and occurrences together
plot(preds$elevation, col = cl)
points(presences, pch = 19)  # this species occur in lower altitudes

plot(preds$precipitation, col = cl)
points(presences, pch = 19) # and where it's quite moist

plot(preds$temperature, col = cl)
points(presences, pch = 19) # where it's hotter

plot(preds$vegetation, col = cl)
points(presences, pch = 19) # and where the vegetation cover is higher

# They're called predictors because they predict patterns


# Let's do a model

# setting data for sdm
data_sdm <- sdmData(train = species_data, predictors = preds)
   # training data
data_sdm

# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation,
          data = data_sdm,
          methods = "glm")  # widely used in ecology
m1

# make the raster output layer
p1 <- predict(m1, newdata = preds)  # preds as extension and grain
p1

# plot the output
plot(p1, col = cl)
points(presences, pch = 19)

# add to the stack
s1 <- stack(preds, p1)
plot(s1, col = cl)

# change names last plot
names(s1)[5] <- c('model')

# re-plot
plot(s1, col = cl)
