# Importing data from external sources
# in questo caso usiamo immagine "eclissi", la salvo sul pc

# usiamo queste librerie
library(terra)
library(imageRy)

# importiamo l'immagine
setwd("C:/Users/Acer/Documents/UNIBO/MAGISTRALE/telerilevamento geo-ecologico") # tra parentesi copio il percorso della mia immagine, ma cambio il verso delle barre

# usiamo funzione rast che serve per creare raster spaziali
eclissi <- rast("eclissi.png")

# richiamo eclissi per vedere le caratteristiche
eclissi

# plotting the data: plottiamo l'immagine 
# plot è funzione del pacchetto terra, plotRGB è funzione di imageRy
im.plotRGB(eclissi, 1, 2, 3)
im.plotRGB(eclissi, 3, 2, 1) # se cambio l'ordine delle bande ho colori diversi

# metodo con cui importare qualsiasi immagine da internet dopo averla scaricata sul pc da qualsiasi sito

# band difference
dif = eclissi[[1]] - eclissi [[2]]
plot(dif)

# Plottiamo un'altra immagine da Earth observatory
# La scarico e faccio uguale

# guardare sentinel trovalo in user:ducciorocchini > 07_data_sources.md
# eesa
# copernicus: scaricato il file sulla moisture

# Carico dati da Copernicus
# Scarico l'immagine dal sito dopo aver fatto registrazione e login

soil <- rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc")
soil # Per avere le info sull'immagine

plot(soil) # Plotto l'immagine e ne escono due: la prima è il dato, la seconda l'errore

# Crop data: mi serve per prendere solo una part, è come se la ritagliassi
ext <- c(25, 30, 55, 58) # definisco l'estensione, quindi inserisco gli estremi: x min, x max, y min e y max
soilcrop <- crop(soil, ext) # faccio un crop dell'immagine e gli do un nome diverso, quindi associo all'immagine soil l'estensione che voglio
plot(soilcrop)
plot(soilcrop[[1]]) # Se voglio vedere solo la prima immagine, cioè il dato vero senza errore
