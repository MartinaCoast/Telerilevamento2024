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


#####
#per evidenziare la vegetazione nel prima e dopo sostituisco il R nel livello 3 con il NIR perchè la vegetazione riflette il NIR e così risulterà rosso
#VEGETAZIONE:
#calcolo DVI e NDVI e poi plottole due immagini per far vedere la differenza visiva nel prima e dopo sulla vegetazione
#posso far vedere la differenza tra TRUE COLOR e NIR, sia prima che dopo
# poi potrei calcolare le percentuali a cui corrisponde la veg, quindi fare una classificazione 
######


# Carico le immagini relative alle diverse bande sia per 2024 che per 2025, assegnando ogni banda a un oggetto
# Includo poi tutte le bande in uno stack per creare un'immagine unica per entrambi gli anni

#2024
g24_2 <- rast("24_b2.tiff")
g24_3 <- rast("24_b3.tiff")
g24_4 <- rast("24_b4.tiff")
g24_8 <- rast("24_b8.tiff")
g2024 <- c(g24_2, g24_3, g24_4, g24_8)

#2025
g25_2 <- rast("25_b2.tiff")
g25_3 <- rast("25_b3.tiff")
g25_4 <- rast("25_b4.tiff")
g25_8 <- rast("25_b8.tiff")
g2025 <- c(g25_2, g25_3, g25_4, g25_8)


# Imposto un multiframe per visualizzare le due immagini in True Color tramite la funzione par() di imageRy
# Creo una griglia di 1 riga e 2 colonne, aggiungo anche i titoli relativi agli anni
# Per le immagini seguo la seguente sequenza di bande: r=1, g=2, b=3
par(mfrow=c(1,2))
im.plotRGB(g2024, 1,2,3,title="2024")
im.plotRGB(g2025, 1,2,3,title="2025")

dev.off()

# Creo un secondo multiframe mettendo il NIR al posto del rosso in modo da evidenziare meglio l'impatto del crollo sulla vegetazione
# In questo modo tutto ciò che riflette il NIR (la vegetazione) risulterà rosso
par(mfrow(1,2))
im.plotRGB(g2024, 4,2,3,title="2024")
im.plotRGB(g2025, 4,2,3,title="2025")




