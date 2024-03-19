# Satellite data visualisation in R by imageRy

library(terra)
library(imageRy)

# list of data available in imageRy
im.list()

# Importing data
# assegnamo all'importazione il nome mato per semplicficare
mato <- im.import("matogrosso_ast_2006209_lrg.jpg") #abbiamo importato la nostra immagine
b2 <- im.import("sentinel.dolomites.b2.tif")

#mettiamo la c per concatenarli, metterli tutti insieme
# il 3 mi serve per deteminare quante sfumature uso, potrei mettere anche 100 e viene più dettagliato
clg <- colorRampPalette(c("black", "grey", "light grey"))(3)

# Plotting the data per plottare i dati relativi alle immagini che ho
plot(b2, col=clg)

# cambio i colori
clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(3)
plot(b2, col=clcyan)

clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan", "chartreuse"))(100)
plot(b2, col=clcyan)

# Importing the additional bands "sentinel.dolomites.b2.tif" "sentinel.dolomites.b3.tif" "sentinel.dolomites.b4.tif" "sentinel.dolomites.b8.tif"  
# Importiamo la banda del verde, la numero 3
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=clcyan)

# Importiamo la banda 4, quella del rosso 
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clcyan)

# Importiamo la banda 8, quella dell'infrarosso
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=clcyan)

# Multiframe
# creiamo 2 righe e 2 colonne per posizionare i grafici delle 4 bande
par(mfrow=c(2,2))

# Plottiamo le 4 bande che andranno a inserirsi nel multiframe che abbiamo appena creato
plot(b2, col=clcyan)
plot(b3, col=clcyan)
plot(b4, col=clcyan)
plot(b8, col=clcyan)

#  Adesso creiamo un altro multiframe con 1 sola riga e 4 colonne per posizionare i grafici delle 4 bande
par(mfrow=c(1,4))

# Plottiamo le 4 bande che andranno a inserirsi nel multiframe che abbiamo appena creato
plot(b2, col=clcyan)
plot(b3, col=clcyan)
plot(b4, col=clcyan)
plot(b8, col=clcyan)

# Facciamo un'immagine satellitare, sovrapponendo le 4 bande
stacksent<- c(b2, b3, b4, b8)
plot(stacksent, col=clcyan)

# Plottiamo una singola immagine satellitare, la numero 4 corrispondente alla banda b8
dev.off()
plot(stacksent [[4]], col=clcyan)

# RGB plotting
# stacksent[[1]] = b2 = blue
# stacksent[[2]] = b3 = green
# stacksent[[3]] = b4 = red
# stacksent[[4]] = b8 = nir

# Facciamo un plot RGB
im.plotRGB(stacksent, 3, 2, 1)

im.plotRGB(stacksent, 4, 2, 1)

# esercizio: metti una di fianco all'altra le due immagini, quella a colori veri e quella a colori filtrati
par(mfrow=c(1,2))
im.plotRGB(stacksent, 3, 2, 1)
im.plotRGB(stacksent, 4, 2, 1)

