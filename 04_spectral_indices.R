# Spectral indicies

# Riprendo i pacchetti che mi servono
library (terra)
library (imageRy)

# vediamo la lista di dati del pacchetto imageRy
im.list()

# importiamo l'immagine del Matogrosso del 1992 e le diamo un nuovo nome
m1992 <- im.import ("matogrosso_l5_1992219_lrg.jpg") ##il nome del file è così perchè ha corrispondenza con il sito EarthObservatory o con Nasa Visible Earth

# Bande
# banda 1 = NIR = infrarosso
# banda 2 = red
# banda 3 = green

# facciamo dei plot con la funzione im.plotRGB
im.plotRGB(m1992, r=1, g=2, b=3)  # posso anche non mettere lettera=, è la stessa cosa
#vediamo foresta pluviale in rosso nel 1992: acqua non appare nera perchè è presente grande quantità di sedimento

# mettiamo infrarosso NIR sul verde
im.plotRGB(m1992, 2, 1, 3) #le parti in rosa sono zone di suolo nudo, ossia distrutte dalla deforestazione

# mettiamo infrarosso NIR sul blu: cosi risultano gialle le zone più colpite dalla deforestazione
im.plotRGB(m1992, 2, 3, 1) #la geometria che appare in giallo è euclidea, quindi antropogenica

# Importiamo l'immagine del Matogrosso del 2006, nominandola
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Faccio un par tra 1992 e 2006 con 1 riga e 2 colonne
par(mfrow=c(1,2))
im.plotRGB(m1992, 1, 2, 3) #la foresta è rigogliosa
im.plotRGB(m2006, 1, 2, 3) #la foresta è distrutta

dev.off() #cancello il plot

# Mettiamo NIR su verde
im.plotRGB(m2006, 2, 1, 3) #aumenta molto il rosa: soprattutto a sud, tutto è distrutto

# Mettiamo NIR su blu
im.plotRGB(m2006, 2, 3, 1)

# Mettiamo a confronto le due situazioni banda per banda, unendo tutte le 6 immagini su 2 righe e 3 colonne
par(mfrow=c(2,3))
im.plotRGB(m1992, 1, 2, 3) # 1992 nir on red
im.plotRGB(m1992, 2, 1, 3) # 1992 nir on green
im.plotRGB(m1992, 2, 3, 1) # 1992 nir on blue

im.plotRGB(m2006, 1, 2, 3) # 2006 nir on red
im.plotRGB(m2006, 2, 1, 3) # 2006 nir on green
im.plotRGB(m2006, 2, 3, 1) # 2006 nir on blue


# calcolo indice DVI (Difference Vegetation Index - indice di vegetazione)
#Prendo ogni singolo pixel della banda e faccio la sottrazione tra NIR e R per ottenere DVI

# band 1 = NIR
# band 2 = red

#DVI 1992
dvi1992 = m1992[[1]] - m1992[[2]] # dichiariamo gli elementi che vogliamo utilizzare, quindi il primo elemento [1] e il secondo elemento [2] dell'immagine satellitare
dvi1992

# plotting the DVI
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

# rifacciamo la stessa operazione per calcolare il DVI del 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
# DVI 2006
dvi2006 = m2006[[1]] - m2006[[2]]
dvi2006

plot(dvi2006, col=cl)

# esercizio: plot the dvi1992 beside the dvi2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# Normalized Difference Vegetation Index
ndvi1992 = dvi1992/(m1992[[1]] + m1992[[2]])
ndvi2006 = dvi2006/(m2006[[1]] + m2006[[2]])

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# speediing up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2) # è la stessa cosa che ho appena fatto, semplicemente questa è una funzione dentro al pacchetto di imageRy, dove 1 e 2 rappresentano sempre le bande NIR e RED
plot(ndvi2006a, col=cl)
