# ANALISI DELL'IMPATTO DEL CROLLO DEL GHIACCIAIO DEL BIRCH SUL VILLAGGIO DI BLATTEN (LOTSCHEN, SVIZZERA)
# Confronto tra agosto 2024 ed agosto 2025 SOTTOTITOLO

# Scarico le immagini da Copernicus Browser:
# Coordinate delle immagini {"type":"Polygon","coordinates":[[[7.770536,46.442508],[7.87493,46.442508],[7.87493,46.385371],[7.770536,46.385371],[7.770536,46.442508]]]}
# Scelgo le immagini relative al 23 agosto 2024 e 25 agosto 2025 in modo da avere poca copertura nevosa e simile situazione vegetazionale
# Le immagini sono state scaricate in formato tiff a 16 bit dal satellite Sentinel-2
# Per ogni immagine scarico le bande 2 (blu), 3 (verde), 4 (rosso) e 8 (NIR)

# Imposto su R la cartella directory dove ho salvato le immagini: R prenderà le immagini da qui
setwd("C:/Users/Acer/Documents/UNIBO/MAGISTRALE/telerilevamento geo-ecologico/ghiacciaio")


# Installo dal CRAN i paccchetti necessari ad analizzare le immagini con la funzione install.packages() mettendo il nome del pacchetto tra virgolette
install.packages("terra") #per lavorare con le immagini satellitari e usare la funzione rast()
install.packages("ggplot2") #per creare grafici a barre
#NON SO SE MI SERVE: install.packages("patchwork") #per attaccare insieme più plot
install.packages("viridis") #per utilizzare palette di colori adatti ai daltonici

# Installo la funzione devtools, presente sul CRAN, necessaria per scaricare il prossimo pacchetto
install.packages("devtools")
library(devtools)

# Installo il pacchetto imageRy, esterno al CRAN e presente su GitHub
# Questo pacchetto mi serve per classificare con im.classify() e plottare le immagini con im.plotRGB() 
install_github("ducciorocchini/imageRy")

# Richiamo tutti i pacchetti scaricati
library(terra) 
library(viridis) 
library(ggplot2) 
### library(patchwork) 
library(imageRy)


# Carico le immagini relative alle diverse bande sia per 2024 che per 2025, assegnando ogni banda a un oggetto
# Includo poi tutte le bande in uno stack per creare un'immagine unica per entrambi gli anni

#2024
g24_4 <- rast("24_b4.tiff") #red
g24_3 <- rast("24_b3.tiff") #green
g24_2 <- rast("24_b2.tiff") #blue
g24_8 <- rast("24_b8.tiff") #nir
G24 <- c(g24_4, g24_3, g24_2, g24_8)

#2025
g25_4 <- rast("25_b4.tiff") #red
g25_3 <- rast("25_b3.tiff") #green
g25_2 <- rast("25_b2.tiff") #blue
g25_8 <- rast("25_b8.tiff") #nir
G25 <- c(g25_4, g25_3, g25_2, g25_8)


# Imposto un multiframe per visualizzare le due immagini in True Color tramite la funzione par() di imageRy
# Creo una griglia di 1 riga e 2 colonne, aggiungo anche i titoli relativi agli anni
# Per le immagini seguo la seguente sequenza di bande: r=1, g=2, b=3
par(mfrow=c(1,2))
im.plotRGB(G24, 1,2,3)
title("2024")
im.plotRGB(G25, 1,2,3)
title("2025")

dev.off()

# Creo un secondo multiframe mettendo il NIR al posto del rosso in modo da evidenziare meglio l'impatto del crollo sulla vegetazione
# In questo modo tutto ciò che riflette il NIR (la vegetazione) risulterà rosso
par(mfrow=c(1,2))
im.plotRGB(G24, 4,2,3)
title("2024")
im.plotRGB(G25, 4,2,3)
title("2025")

dev.off()

###### PROVAAAAAA NON CAPISCO DOVE TROVO IMMAGINE IN TRUE COLOR
par(mfrow=c(3,2))
im.plotRGB(G24, 4,2,3)
im.plotRGB(G25, 4,2,3)
im.plotRGB(G24, 4,3,2)
im.plotRGB(G25, 4,3,2)
im.plotRGB(G24, 4,1,2)
im.plotRGB(G25, 4,1,2)
####


# Calcolo innanzitutto l'NDVI (Normalized Difference Vegetation Index) per entrambi gli anni seguendo la formula:
# NDVI = (nir-red)/(nir+red)
# In questo modo osservo l'impatto che il crollo del ghiacciaio ha avuto sulla vegetazione
NDVI_24 = (G24[[4]]-G24[[1]])/(G24[[4]]+G24[[1]])
NDVI_25 = (G25[[4]]-G25[[1]])/(G25[[4]]-G25[[1]])

# Seleziono una scala di colori dal pacchetto viridis, inclusivo per le persone affette da daltonismo
cl <- 

# Creo un multiframe con 1 riga e 2 colonne e plotto le immagini elaborate attraverso l'indice NDVI
par(mfrow=c(1,2))
plot(NDVI_24, col= ... (100))
plot(NDVI_25, col= ... (100))

dev.off()

# Classifico l'NDVI di entrambi gli anni in 3 cluster e creo un multiframe
# classe 1 = altro (uomo/neve)
# classe 2 = vegetazione
# classe 3 = no vegetazione

cG24 <- im.classify(NDVI_24, num_clusters=3)
cG25 <- im.classify(NDVI_25, num_clusters=3)

par(mfrow=c(1,2))
plot(cG24)
plot(cG25)

# Calcolo le percentuali di copertura per ogni classe per entrambi gli anni
f24 <- freq(cG24)
tot24 <- ncell(cG24)
prop24 = f24 / tot24
perc24 = prop24 * 100
perc24

f25 <- freq(cG25)
tot25 <- ncell(cG25)
prop25 = f25 / tot25
perc25 = prop25 * 100
prop25



