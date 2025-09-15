# ANALISI DELL'IMPATTO DEL CROLLO DEL GHIACCIAIO DEL BIRCH SUL VILLAGGIO DI BLATTEN (LOTSCHEN, SVIZZERA)
# Confronto tra agosto 2024 ed agosto 2025 SOTTOTITOLO

# Scarico le immagini da Copernicus Browser:
# Coordinate delle immagini {"type":"Polygon","coordinates":[[[7.770536,46.442508],[7.87493,46.442508],[7.87493,46.385371],[7.770536,46.385371],[7.770536,46.442508]]]}
# Scelgo le immagini relative al 23 agosto 2024 e 25 agosto 2025 in modo da avere poca copertura nevosa e simile situazione vegetazionale
# Le immagini sono state scaricate in formato tiff a 16 bit dal satellite Sentinel-2
# Per ogni immagine scarico le bande 2 (blu), 3 (verde), 4 (rosso) e 8 (NIR)

# Imposto su R la cartella directory dove ho salvato le immagini: R prenderà le immagini da qui
setwd("C:/Users/Acer/Documents/UNIBO/MAGISTRALE/telerilevamento geo-ecologico/ghiacciaio")

# Richiamo tutti i pacchetti necessari
library(terra) #per lavorare con le immagini satellitari e usare la funzione rast()
library(viridis) #per utilizzare palette di colori adatti ai daltonici
library(ggplot2) #per creare grafici a barre
library(patchwork) #per la visualizzazione di più grafici insieme
library(imageRy) #per classificare con im.classify() e plottare con im.plotRGB() le immagini


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
im.plotRGB(G24, 3,2,1)
title("2024", line=-2)
im.plotRGB(G25, 3,2,1)
title("2025", line=-2)

dev.off()

# Creo un secondo multiframe mettendo il NIR al posto del rosso in modo da evidenziare meglio l'impatto del crollo sulla vegetazione
# In questo modo tutto ciò che riflette il NIR (la vegetazione) risulterà rosso
par(mfrow=c(1,2))
im.plotRGB(G24, 4,2,1)
title("2024 (nir)", line=-2)
im.plotRGB(G25, 4,2,1)
title("2025 (nir)", line=-2)

dev.off()

# Multiframe con le due situazioni a confronto, prima in TC poi con NIR al posto del rosso
par(mfrow=c(2,2))
im.plotRGB(G24, 3,2,1)
title("2024", line=3)
im.plotRGB(G25, 3,2,1)
title("2025", line=3)
im.plotRGB(G24, 4,2,1)
title("2024 (nir)", line=3)
im.plotRGB(G25, 4,2,1)
title("2025 (nir)", line=3)


# Calcolo innanzitutto l'NDVI (Normalized Difference Vegetation Index) per entrambi gli anni seguendo la formula:
# NDVI = (nir-red)/(nir+red)
# In questo modo osservo l'impatto che il crollo del ghiacciaio ha avuto sulla vegetazione
NDVI_24 = (G24[[4]]-G24[[3]])/(G24[[4]]+G24[[3]]) #NDVI 2024
NDVI_25 = (G25[[4]]-G25[[3]])/(G25[[4]]+G25[[3]]) #NDVI 2025

# Creo un multiframe e plotto le immagini elaborate attraverso l'indice NDVI
# Seleziono una scala di colori dal pacchetto viridis, inclusivo per le persone affette da daltonismo
par(mfrow=c(1,2))
plot(NDVI_24, col=viridis (100), main="2024") #2024
plot(NDVI_25, col=viridis (100), main="2025") #2025
#il range non è in funzione della radiazione radiometrica ma è un valore adimensionale che va da -1 a 1.

dev.off()

# Classifico l'NDVI di entrambi gli anni in 2 cluster e creo un multiframe
# classe 1 = altro (suolo nudo/neve/acqua)
# classe 2 = vegetazione

cG24 <- im.classify(NDVI_24, num_clusters=2)
cG25 <- im.classify(NDVI_25, num_clusters=2)

par(mfrow=c(1,2))
plot(cG24)
plot(cG25)

# Calcolo le percentuali di copertura per ogni classe per entrambi gli anni
f24 <- freq(cG24)
tot24 <- ncell(cG24)
prop24 = f24 / tot24
perc24 = prop24 * 100
perc24
## classe 1 = 42.3%, classe 2 = 57.7% 

f25 <- freq(cG25)
tot25 <- ncell(cG25)
prop25 = f25 / tot25
perc25 = prop25 * 100
perc25
## classe 1 = 47,0% , classe 2 = 52.9%


# Adesso calcolo l'NDWI (Normalized Difference Water Index) per osservare come la frana ha influito sul corpo idrico della valle
###The NDWI is used to monitor changes related to water content in water bodies. As water bodies strongly absorb light in visible to infrared electromagnetic spectrum, NDWI uses green and near infrared bands to highlight water bodies. It is sensitive to built-up land and can result in over-estimation of water bodies. The index was proposed by McFeeters, 1996.
# Utilizzo la seguente formula:
# NDWI= green-NIR/green+nir
NDWI_24 = (G24[[2]]-G24[[4]])/(G24[[2]]+G24[[4]]) #2024
NDWI_25 = (G25[[2]]-G25[[4]])/(G25[[2]]+G25[[4]]) #2025

# Nuovamente creo un multiframe e plotto le immagini elaborate attraverso l'indice NDWI
# Seleziono sempre una scala di colori dal pacchetto viridis, inclusivo per le persone affette da daltonismo
par(mfrow=c(1,2))
plot(NDWI_24, col=cividis (100), main="2024") #2024
plot(NDWI_25, col=cividis (100), main="2025") #2025

dev.off()

# Classifico l'NDWI di entrambi gli anni in 2 cluster e creo un multiframe
# classe 1 = altro (vegetazione)
# classe 2 = acqua

wG24 <- im.classify(NDWI_24, num_clusters=2)
wG25 <- im.classify(NDWI_25, num_clusters=2)

par(mfrow=c(1,2))
plot(wG24)
plot(wG25)

# Calcolo le percentuali di copertura per ogni classe per entrambi gli anni
fw24 <- freq(wG24)
totw24 <- ncell(wG24)
propw24 = fw24 / totw24
percw24 = propw24 * 100
percw24
## classe 1 = 58.4%, classe 2 = 41.6%

fw25 <- freq(wG25)
totw25 <- ncell(wG25)
propw25 = fw25 / totw25
percw25 = propw25 * 100
percw25
## classe 1 =  54.2%, classe 2 = 45.7%


# Cerchiamo di visualizzare visivamente la differenza tra NDVI e NDWI per entrambi gli anni
# A valori positivi corrisponde dominanza di vegetazione e a valori negativi corrisponde una dominanza di acqua
diff24 <- NDVI_24 - NDWI_24
plot(diff24, col = viridis(100), main = "NDVI_24 - NDWI_24")

diff25 <- NDVI_25 - NDWI_25
plot(diff25, col = viridis(100), main = "NDVI_25 - NDWI_25")


# Creo un dataset con le percentuali ottenute per confrontare come sono variate le frequenze tra prima e dopo il crollo del ghiacciaio:
anno <- c("2024","2025")
vegetazione <- c(57.7,52.9)
acqua <- c(41.6, 45.7)

# Le percentuali sono espresse in relazione alla superficie totale dell'area di studio pari a 50.96 km2
# Creazione del dataframe
tab <- data.frame(anno, vegetazione, acqua)
tab
View(tab) # Visualizzo il dataframe in versione tabella



