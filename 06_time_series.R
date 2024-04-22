library(terra)
library(imageRy)

im.list()

# importing data
# usiamo le foto EN: European Nitrogen, da gennaio a marzo
gennaio <- im.import("EN_01.png") #prima foto, gennaio
marzo <- im.import("EN_13.png") #ultima foto, marzo

# creiamo un multiframe a una colonna e due righe
par(mfrow=c(2,1))
im.plotRGB.auto(gennaio) # la funzione con l'aggiunta di "auto" prende direttamente le prime tre bande e fa tutto in automatico; aggiungiamo la prima immagine
im.plotRGB.auto(marzo) # aggiungo la seconda immagine

# osserviamo la differenza tra le due immagini satellitari
difEN = gennaio[[1]] - marzo[[1]] # i pixel della prima banda dell'immagine di gennaio sono sottratti a quelli della prima banda dell'immagine di marzo
col <- colorRampPalette(c("blue", "white", "red"))(100) # scelgo la banda di colori
plot(difEN, col=col)

#Ice melt in Grenland
g2000 <- im.import("greenland.2000.tif")
clg<-colorRampPalette(c("black","blue","white","red")) (100) # chiamo questa palette diversamente da prima evitiamo di sovrascrivere e quindi sostituire la color paette precedente
plot(g2000, col=clg)

#importing other data
g2005 <- im.import("greenland.2005.tif") 
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

par(mfrow=c(2,2))
plot(g2000, col=clg)
plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

#stack
greenland<-c(g2000, g2005, g2010, g2015)
plot(greenland, col=clg)

difg = greenland[[1]] - greenland[[4]]
plot(difg, col=col)

clgreen <- colorRampPalette(c("red","white","blue")) (100) #invertiamo la palette in modo da vedere il rosso nelle zone in cui la T è aumentata
plot(difg ,col=clgreen)

im.plotRGB(greenland, r=1, g=2, b=4) #g2000 on red, g2005 on green, g2015 on blue
