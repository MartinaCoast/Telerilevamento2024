#IDEA PROGETTO

# Villaggio di Blatten in svizzera estate 2024-estate 2025, pre e post crollo ghiacciaio del Birch
# ANALISI DELL'IMPATTO DEL CROLLO DEL GHIACCIAIO DEL BIRCH SUL VILLAGGIO DI BLATTEN, SVIZZERA
# colori viridis cosi faccio vedere anche a marci

# Installo dal CRAN i paccchetti necessari ad analizzare le immagini con la funzione install.packages() mettendo il nome del pacchetto tra virgolette
install.packages("terra") #per lavorare con le immagini satellitari
install.packages("ggplot2") #Create Elegant Data Visualisations Using the Grammar of Graphics
install.packages("patchwork") #per mettere insieme più plot/the composer of plots
install.packages("viridis") #per utilizzare colori per daltonici, Colorblind-Friendly Color Maps for R

# Installo la funzione devtools, presente sul CRAN, necessaria per scaricare il prossimo pacchetto
install.packages("devtools")
library(devtools)

# Installo il pacchetto imageRy, esterno al CRAN e presente su GitHub
# Questo pacchetto mi serve per scaricare più velocemente le immagini


# Richiamo i pacchetti
library(terra) 
library(viridis) 
library(ggplot2) 
library(patchwork) 
library(imageRy) #mi serve per fare la classificazione e il plotting delle immagini

setwd("C:/Users/Acer/Documents/UNIBO/MAGISTRALE/telerilevamento geo-ecologico/ghiacciaio")









#SATELLITE SENTINEL-2: 
# banda 2 = blu
# banda 3 = verde
# banda 4 = rosso
# banda 8 = nir

#mettiamo banda 1=rosso, banda 2 è verde, banda 3 è blu, banda 4 è nir
r17 <- rast("r17.tiff")
g17 <- rast("g17.tiff")
b17 <- rast("b17.tiff")
nir17 <- rast("nir17.tiff")

#cosi adesso ho l'immagine in true color data dalla sovrapposizione delle varie bande
m2017 <- c(r17, g17, b17, nir17) #sovrappongo le varie bande nell'ordine cui sopra

r24 <- rast("r24.tiff")
g24 <- rast("g24.tiff")
b24 <- rast("b24.tiff")
nir24 <- rast("nir24.tiff")

m2024 <- c(r24, g24, b24, nir24)

par(mfrow=c(1,2))
im.plotRGB(m2017, 1,2,3)
im.plotRGB(m2024, 1,2,3)
#vsualizzo le immagini facendole corrispondere a ogni banda il proprio colore=> banda rossa verrà colorata di rosso ecc
#però qui non noto troppo le differenze, quindi dato che mi interessa il cambiamento della vegetazione, proviamo a scambiare le bande visualizzando la banda del nir in rosso

dev.off()

par(mfrow=c(2,2))
im.plotRGB(m2017, 1,2,3) 
im.plotRGB(m2017, 4,2,3) #cosi metto a confronto le due immagini dello stesso anno ma con l'infrarosso nel secondo caso
im.plotRGB(m2024, 1,2,3)
im.plotRGB(m2024, 4,2,3) #stessa cosa






