# MULTIVARIATE ANALYSIS: how to reduce a multidimensional dataset

# Load the required packages
library(raster)
library(ggplot2)
library(viridis)

# Set the working directory in Windows
setwd("C:/lab")


# Import data
sen <- brick("sentinel.png")
sen
ncell(sen)  # the size
plot(sen)  # the plot

# In order to group bands, we remove the last one (it's empty)
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])
plot(sen2)

# Pair-wise comparison
pairs(sen2)

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000)
pca <- prcomp(sample)

# Variance explained
summary(pca)

# The first component is the one with the highest variability

# Correlation with original bands
pca

# Pc map: we visualize starting from the analysis of the PCA
pci <- predict(sen2, pca, index = c(1:3)) # or c(1:2)
plot(pci)
plot(pci[[1]])

# Plot using ggplot
pcid <- as.data.frame(pci[[1]], xy = T)  # coerce into a dataframe
pcid

ggplot() +
  geom_raster(pcid,
              mapping = aes(x = x, y = y, fill = PC1)) +
  scale_fill_viridis()  # direction = -1 in case of reverse colour ramp

# magma
ggplot() +
  geom_raster(pcid,
              mapping = aes(x = x, y = y, fill = PC1)) +
  scale_fill_viridis(option = "magma")

# inferno 
ggplot() +
  geom_raster(pcid,
              mapping = aes(x = x,y = y, fill = PC1)) +
  scale_fill_viridis(option = "inferno")


# Focal standard deviation
sd3 <- focal(pci[[1]], matrix(1/9, 3, 3), fun = sd)

# Coerce into a datafram
sd3d <- as.data.frame(sd3, xy = T)

# Plot
ggplot() +
  geom_raster(sd3d,
              mapping = aes(x = x, y = y, fill = layer)) +
  scale_fill_viridis()


# speeding up analyses
# aggregate cells: re-sampling
senres <- aggregate(sen, fact = 10)

# then repeat the PCA analysis
