#Telerilevamento geo-ecologico 2023/2024
#Alessandra Valenti Martinez

#The goal of this project is to observed how the vegetation cover changed before and after the fire disturbance
# occured in the hinterland of Sicily in the period 2017-2023

install.packages("sf")
 

# First of all, we open the packages from our library:

library(sp)
library(sf)
library(raster)
library(tidyverse)
library(viridis)


 # Now we set our working directory:
 
 setwd("C:/lab/Esame")
 
 
 
 img_list <- list.files(pattern = "20170707T095031")
 img_list

 import <- lapply(img_list, raster)  # to apply a function to many images of a list
 import
 
 # Stack vectors from a dataframe or list
 img_2017_raw <- stack(import)
 img_2017_raw  # 4 layers
 # stacking vectors concatenates multiple vectors into a single vector
 
 plot(img_2017_raw)  # now we have all the images in a single element
 
 # Plot with RGB in a multiframe
 par(mfrow = c(1,2)) # multiframe
 plotRGB(img_2017_raw, 4, 3, 2, stretch = "Lin") # NIR
 plotRGB(img_2017_raw, 3, 2, 1, stretch = "Lin") # natural colours
 
 dev.off()
 
 # Find the right coordinates to crop all the images of Sicily
 plot(img_2017_raw[[3]])
 img_2017_raw
 
 ext <- c(399960, 509760, 4108000, 4200000) # coordinates for cropping
 # Let's crop the image based on the chosen coordinates
 img_2017 <- crop(img_2017_raw, ext)
 img_2017
 
plot(img_2017) 

# Plot with RGB the cropped image
par(mfrow = c(1,2))
plotRGB(img_2017, 4, 3, 2, stretch = "Lin") # NIR
plotRGB(img_2017, 3, 2, 1, stretch = "Lin") # natural colours


## Other images: 2018-2023 -----

# List of files
img_list_18 <- list.files(pattern = "20180707T095029")
img_list_19 <- list.files(pattern = "20190707T095031")
img_list_20 <- list.files(pattern = "20200701T095031")
img_list_21 <- list.files(pattern = "20210706T095031")
img_list_22 <- list.files(pattern = "20220706T095039")
img_list_23 <- list.files(pattern = "20230706T095031")


# Apply a function over a list or vector
import_18 <- lapply(img_list_18, raster)
import_19 <- lapply(img_list_19, raster)
import_20 <- lapply(img_list_20, raster)
import_21 <- lapply(img_list_21, raster)
import_22 <- lapply(img_list_22, raster)
import_23 <- lapply(img_list_23, raster)

# Stack vectors from a dataframe or list
img_2018_raw <- stack(import_18)
img_2019_raw <- stack(import_19)
img_2020_raw <- stack(import_20)
img_2021_raw <- stack(import_21)
img_2022_raw <- stack(import_22)
img_2023_raw <- stack(import_23)

# Let's crop the image based on the coordinates chosen previously
img_2018 <- crop(img_2018_raw, ext)
img_2019 <- crop(img_2019_raw, ext)
img_2020 <- crop(img_2020_raw, ext)
img_2021 <- crop(img_2021_raw, ext)
img_2022 <- crop(img_2022_raw, ext)
img_2023 <- crop(img_2023_raw, ext)

# Plot with RGB the cropped images

plotRGB(img_2018, 4, 3, 2, stretch = "Lin") # NIR
plotRGB(img_2018, 3, 2, 1, stretch = "Lin") # natural colours

plotRGB(img_2019, 4, 3, 2, stretch = "Lin") # NIR
plotRGB(img_2019, 3, 2, 1, stretch = "Lin") # natural colours

plotRGB(img_2020, 4, 3, 2, stretch = "Lin") # NIR
plotRGB(img_2020, 3, 2, 1, stretch = "Lin") # natural colours

plotRGB(img_2021, 4, 3, 2, stretch = "Lin") # NIR
plotRGB(img_2021, 3, 2, 1, stretch = "Lin") # natural colours

plotRGB(img_2022, 4, 3, 2, stretch = "Lin") # NIR
plotRGB(img_2022, 3, 2, 1, stretch = "Lin") # natural colours

plotRGB(img_2023, 4, 3, 2, stretch = "Lin") # NIR
plotRGB(img_2023, 3, 2, 1, stretch = "Lin") # natural colours

dev.off()

# The most cloudy images -> 2015 and 2017



# NDVI -----

# Calculate NDVI
# NDVI is a metric for quantifying the health and density of vegetation
# range from -1 to +1

ndvi_2017 = (img_2017[[4]] - img_2017[[3]]) / (img_2017[[4]] + img_2017[[3]])
ndvi_2018 = (img_2018[[4]] - img_2018[[3]]) / (img_2018[[4]] + img_2018[[3]])
ndvi_2019 = (img_2019[[4]] - img_2019[[3]]) / (img_2019[[4]] + img_2019[[3]])
ndvi_2020 = (img_2020[[4]] - img_2020[[3]]) / (img_2020[[4]] + img_2020[[3]])
ndvi_2021 = (img_2021[[4]] - img_2021[[3]]) / (img_2021[[4]] + img_2021[[3]])
ndvi_2022 = (img_2022[[4]] - img_2022[[3]]) / (img_2022[[4]] + img_2022[[3]])
ndvi_2023 = (img_2023[[4]] - img_2023[[3]]) / (img_2023[[4]] + img_2023[[3]])

# Plot the NDVI
par(mfrow = c(3, 3))
clp1 <- colorRampPalette(c("darkblue", "white", "darkgreen", "black"))(100)


plot(ndvi_2017, col = clp1, main = "2017")
plot(ndvi_2018, col = clp1, main = "2018")
plot(ndvi_2019, col = clp1, main = "2019")
plot(ndvi_2020, col = clp1, main = "2020")
plot(ndvi_2021, col = clp1, main = "2021")
plot(ndvi_2022, col = clp1, main = "2022")
plot(ndvi_2023, col = clp1, main = "2023")

dev.off()

# Temporal difference 2015-2023
ndvi_dif1 = ndvi_2017 - ndvi_2023

# Plot the results of multitemporal analysis
clp2 <- magma(100)
plot(ndvi_dif1, col = clp2, main = "NDVI difference 2017-2023")
# the higher the difference the bigger the loss of vegetation
# if the difference is negative there is a gain in vegetation
# we mainly care about the loss and gain of forest cover

# It seems the NDVI has an overall decrease from 2015 to 2023

dev.off()



# Multivariate analysis -----

# PCA (Principal Component Analysis) on a sample of pixels (same as for classification)
sample <- sampleRandom(ndvi_dif1, 10000)
pca <- prcomp(sample)

# Variance explained
summary(pca)

# The first component is the one with the highest variability

# Correlation with original bands
pca

# Pc map: we visualize starting from the analysis of the PCA
pci <- predict(ndvi_dif1, pca, index = c(1:3)) # or c(1:2)
plot(pci)
plot(pci[[1]])

# Plot using ggplot
pcid <- as.data.frame(pci[[1]], xy = T)  # coerce into a dataframe
pcid

ggplot() +
        geom_raster(pcid,
                    mapping = aes(x = x, y = y, fill = layer.1)) +
        scale_fill_viridis(name = "PC1 values") +
        labs(title = "PCA of NDVI difference 2015-2023")

setwd("C:/lab/exam_project/images")

ggsave("pca1.png")

dev.off()



# Land cover -----

## Classification -----

# 1. Get values
values_2017 <- getValues(img_2017)
values_2018 <- getValues(img_2018)
values_2019 <- getValues(img_2019)
values_2020 <- getValues(img_2020)
values_2021 <- getValues(img_2021)
values_2022 <- getValues(img_2022)
values_2023 <- getValues(img_2023)

# 2. Classify
kcluster_2017 <- kmeans(values_2017, centers = 3)
kcluster_2018 <- kmeans(values_2018, centers = 3)
kcluster_2019 <- kmeans(values_2019, centers = 3)
kcluster_2020 <- kmeans(values_2020, centers = 3)
kcluster_2021 <- kmeans(values_2021, centers = 3)
kcluster_2022 <- kmeans(values_2022, centers = 3)
kcluster_2023 <- kmeans(values_2023, centers = 3)

# 3. Set values
class_2017 <- setValues(img_2017[[3]], kcluster_2017$cluster)
class_2018 <- setValues(img_2018[[3]], kcluster_2018$cluster)
class_2019 <- setValues(img_2019[[3]], kcluster_2019$cluster)
class_2020 <- setValues(img_2020[[3]], kcluster_2020$cluster)
class_2021 <- setValues(img_2021[[3]], kcluster_2021$cluster)
class_2022 <- setValues(img_2022[[3]], kcluster_2022$cluster)
class_2023 <- setValues(img_2023[[3]], kcluster_2023$cluster)

## Plots -----
clp3 <- colorRampPalette(c("blue", "white","orange"))(3)
par(mfrow = c(3,3))
plot(class_2017, col = clp3, main = "2017")
plot(class_2018, col = clp3, main = "2018")
plot(class_2019, col = clp3, main = "2019")
plot(class_2020, col = clp3, main = "2020")
plot(class_2021, col = clp3, main = "2021")
plot(class_2022, col = clp3, main = "2022")
plot(class_2023, col = clp3, main = "2023")

# class 1: bare soil, urban areas, absence of vegetation
# class 2: low vegetation, cultivated areas with vegetation
# class 3: forest, tree-covered land

# The colours of the classes can differ from one plot to another, they have to be fitted

dev.off()


## Percentages -----

# Create an empty data frame to store results
results <- data.frame(RasterName = character(0),
                      Class1_Frequency = numeric(0),
                      Class2_Frequency = numeric(0),
                      Class3_Frequency = numeric(0),
                      Class1_Percentage = numeric(0),
                      Class2_Percentage = numeric(0),
                      Class3_Percentage = numeric(0))

# Create a list that contains the values of each class
classes <- list(class_2017, class_2018, class_2019,
                class_2020, class_2021, class_2022, class_2023)

# Iterate through your raster objects
for (i in 1:length(classes)) {
        # Get the raster object
        raster_obj <- classes[[i]]
        
        # Get the pixel values
        values <- getValues(raster_obj)
        
        # Calculate frequencies
        class1_freq <- sum(values == 1)  # Assuming class 1 is represented by value 1
        class2_freq <- sum(values == 2)  # Assuming class 2 is represented by value 2
        class3_freq <- sum(values == 3)  # Assuming class 3 is represented by value 3
        
        # Calculate percentages
        total_pixels <- length(values)
        class1_percentage <- round((class1_freq / total_pixels) * 100, 1)
        class2_percentage <- round((class2_freq / total_pixels) * 100, 1)
        class3_percentage <- round((class3_freq / total_pixels) * 100, 1)
        
        # Store the results
        results <- rbind(results, data.frame(RasterName = names(raster_obj),
                                             Class1_Frequency = class1_freq,
                                             Class2_Frequency = class2_freq,
                                             Class3_Frequency = class3_freq,
                                             Class1_Percentage = class1_percentage,
                                             Class2_Percentage = class2_percentage,
                                             Class3_Percentage = class3_percentage))
}

# Print or use the results as needed
print(results)

# Look at the images to assign the values to the right classes
# Then save them in a dataframe to do some plots

# Create the dataframe with the results for each class
classes <- data.frame(
        year = c(2017, 2018, 2019, 2020, 2021, 2022, 2023),
        bare_soil = c(14.9, 16.9, 15.0, 17.4, 9.7, 18.9, 11.5, 14.6, 11.4),#da vedere
        low_vegetation = c(42.2, 37.8, 39.9, 28.7, 40.0, 35.2, 35.0, 38.6, 27.7),
        forest = c(42.9, 45.3, 45.1, 53.9, 50.3, 45.9, 53.5, 46.8, 60.8))
classes <- gather(classes, class, percentage, -year)
classes


## Results -----

# Plot about classes
classes$class <- reorder(classes$class, classes$percentage)

classes %>%
        ggplot(aes(x = year, y = percentage, fill = class)) +
        geom_bar(stat = "identity", position = "dodge") +
        labs(title = "Land Cover in Białowieża Forest by Year",
             x = "Year",
             y = "Percentage") +
        scale_fill_manual(values = c("gold2", "turquoise3", "darkgreen"),
                          name = "Class",
                          labels = c("bare soil", "low vegetation", "forest")) +
        theme_classic()
ggsave("plot_bar.png", width = 2000, height = 1350, units = "px")

classes %>%
        ggplot(aes(x = year, y = percentage, color = class)) +
        geom_line(linewidth = 2) +
        labs(title = "Land Cover in Białowieża Forest by Year",
             x = "Year",
             y = "Percentage") +
        scale_color_manual(values = c("gold2", "turquoise3", "darkgreen"),
                           name = "Class",
                           labels = c("bare soil", "low vegetation", "forest")) +
        theme_classic()
ggsave("plot_line.png", width = 2000, height = 1350, units = "px")


classes %>%
        ggplot(aes(x = year, y = percentage, color = class)) +
        geom_point(size = 3) +
        geom_smooth(method = "lm", aes(fill = class), linewidth = 1.5) +
        labs(title = "Land Cover in Białowieża Forest by Year",
             x = "Year",
             y = "Percentage") +
        scale_color_manual(values = c("gold2", "turquoise3", "darkgreen"),
                           name = "Class",
                           labels = c("bare soil", "low vegetation", "forest")) +
        scale_fill_manual(values = c("gold2", "turquoise3", "darkgreen"),
                          name = "Class",
                          labels = c("bare soil", "low vegetation", "forest")) +
        theme_classic()
ggsave("plot_scatter.png", width = 2000, height = 1350, units = "px")

# 
