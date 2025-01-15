# Satellite data visualisation in R by imageRy

library(terra)
library(imageRy)

# list of all data available in imageRy
im.list()

# Importing data
# assegnamo all'importazione il nome mato per semplicficare e importiamo l'immagine tra virgolette
mato <- im.import("matogrosso_ast_2006209_lrg.jpg") #abbiamo importato la nostra immagine
b2 <- im.import("sentinel.dolomites.b2.tif") #importo l'immagine sentinel b2: ho importatato l'immagine di cui visualizzo la banda 2 che corrisponde a tutto ciò che riflette nel blu

#mettiamo la c per concatenarli, metterli tutti insieme
# con la funzione colorRampPalette posso cambiare i colori
# il 3 mi serve per deteminare quante sfumature uso, potrei mettere anche 100 e viene più dettagliato
clg <- colorRampPalette(c("black", "grey", "light grey"))(3)

# Plotting the data: per plottare i dati relativi alle immagini che ho
plot(b2, col=clg)

# cambio i colori
clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan"))(3)
plot(b2, col=clcyan)

clcyan <- colorRampPalette(c("magenta", "cyan4", "cyan", "chartreuse"))(100) #imposto tante sfumature per avere un'immagine più dettagliata
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

# ho importato le 4 bande: b2 blu, b3 verde, b4 rosso e b8 infrarosso

# Multiframe
# creiamo 2 righe e 2 colonne per posizionare i grafici delle 4 bande
par(mfrow=c(2,2)) # ho creato l'impalcatura, devo inserire le immagini ancora

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

# Componiamo un'immagine satellitare sovrapponendo le 4 bande
stacksent<- c(b2, b3, b4, b8) #creo un vettore con le diverse bande e lo assegno all'oggetto stacksent
plot(stacksent, col=clcyan)

# Plottiamo una singola immagine satellitare, per esempio la numero 4 corrispondente alla banda b8: per selezionare i singoli elementi li metto tra []
dev.off() #distrugge il plot creato prima
plot(stacksent [[4]], col=clcyan) #adesso ho questo nuovo plot, le [] sono doppie perchè l'elemento 4 era in una matrice

# RGB plotting: sono una serie di filtri che, se combinati, forniscono potenzialmente tutti i colori
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


dev.off()
im.plotRGB(stacksent, 4, 3, 2)

par(mfrow=c(1,3))
im.plotRGB(stacksent, 3, 2, 1)
im.plotRGB(stacksent, 4, 2, 1)
im.plotRGB(stacksent, 4, 3, 2)

dev.off()
im.plotRGB(stacksent, 3, 4, 2)
im.plotRGB(stacksent, 3, 2, 4)


# final multiframe: put the 4 images alltogether
par(mfrow=c(2,2))
im.plotRGB(stacksent, 3, 2, 1) # natural colors
im.plotRGB(stacksent, 4, 3, 2) # nir on red
im.plotRGB(stacksent, 3, 4, 2) # nir on green
im.plotRGB(stacksent, 3, 2, 4) # nir on blue

# Correlation of informations
pairs(stacksent) 


