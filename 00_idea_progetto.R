#IDEA PROGETTO

#zona dietro casa nel 2001 quando ci siamo trasferiti
#zona dietro casa subito dopo la costruzione del museo
#zona dietro casa  2024
#focus su prato di fianco a casa, prima della tesi e adesso

#colori viridis cosi faccio vedere anche a marci

library(terra) #per lavorare con immagini satellitari
library(viridis) #per utilizzare colori per daltonici, Colorblind-Friendly Color Maps for R
library(ggplot2) #Create Elegant Data Visualisations Using the Grammar of Graphics
library(patchwork) #per mettere insieme più plot/the composer of plots
library(imageRy) #mi serve per fare la classificazione e il plotting delle immagini

setwd("C:/Users/Acer/Documents/UNIBO/MAGISTRALE/telerilevamento geo-ecologico/2017-2024")

r17 <- rast("r17.tiff")
g17 <- rast("g17.tiff")
b17 <- rast("b17.tiff")
nir17 <- rast("nir17.tiff")

m2017 <- c(r17, g17, b17, nir17)

r24 <- rast("r24.tiff")
g24 <- rast("g24.tiff")
b24 <- rast("b24.tiff")
nir24 <- rast("nir24.tiff")

m2024 <- c(r24, g24, b24, nir24)

par(mfrow=c(1,2))
im.plotRGB(m2017, 1,2,3)
im.plotRGB(m2024, 1,2,3)





