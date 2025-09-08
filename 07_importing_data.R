#Importing data from external sources: questo è un metodo con cui importare qualsiasi immagine da internet dopo averla scaricata sul pc da qualsiasi sito
#in questo caso usiamo immagine "eclissi", la salvo sul pc

#usiamo queste librerie
library(terra)
library(imageRy)

#importiamo l'immagine: la funzione setwd (= setworking directory) serve per far capire ad R da dove prendere l'immagine
setwd("C:/Users/Acer/Documents/UNIBO/MAGISTRALE/telerilevamento geo-ecologico") # tra virgolette copio il percorso della mia immagine, ma cambio il verso delle barre

#usiamo funzione rast che serve per creare raster spaziali (sono oggetti), e assegnamo l'immagine all'oggetto eclissi
eclissi <- rast("eclissi.png")

#richiamo l'immagine per vedere le informazioni annesse
eclissi

#plotting the data: plottiamo l'immagine 
#plot è una funzione del pacchetto terra, plotRGB è una funzione di imageRy
im.plotRGB(eclissi, 1, 2, 3)
im.plotRGB(eclissi, 3, 2, 1) # se cambio l'ordine delle bande ho colori diversi

#band difference: facciamo la differenza tra due bande con gli indici spettrali
dif = eclissi[[1]] - eclissi [[2]]
plot(dif)

#Plottiamo un'altra immagine da EarthObservatory, poi facciamo la stessa cosa
forest<-rast("global_lcc_goodes.png")
#https://earthobservatory.nasa.gov/features/ForestCarbon

#plottiamo l'immagine
im.plotRGB(forest,1,2,3)

#guardare sentinel trovalo in user:ducciorocchini > 07_data_sources.md
#eesa
#Copernicus: scaricato il file sulla moisture

#Carico dati da Copernicus
#Scarico l'immagine dal sito dopo aver fatto registrazione e login

soil <- rast("c_gls_SSM1km_202404210000_CEURO_S1CSAR_V1.2.1.nc")
soil # Per avere le info sull'immagine

plot(soil) # Plotto l'immagine e ne escono due: la prima è il dato, la seconda l'errore

#Per plottare solo il primo livello, cioè la prima immagine (dato) senza l'errore:
plot(soil[[1]])

#Crop data: mi serve per ritagliare i dati, prenderne solo una parte
ext <- c(25, 30, 55, 58) # definisco l'estensione, quindi inserisco gli estremi: x min, x max (i primi due valori) e y min e y max (terzo e quarto valore)
soilcrop <- crop(soil, ext) # faccio un crop dell'immagine e gli do un nome diverso, quindi associo all'immagine soil l'estensione che voglio

#plottiamo la nuova immagine, il ritaglio
plot(soilcrop)
