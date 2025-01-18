#Altro metodo per classificare i cambiamenti nel tempo
#Fare la differenza tra due immagini: si procede per bande

#riprendo i pacchetti
library(terra)
library(imageRy)

im.list() #richiamo la lista dei dati

# importing data
# importiamo le immagini EN (European Nitrogen) di gennaio e marzo 2020 e le attribuiamo a degli elementi
GENNAIO <- im.import("EN_01.png") #prima foto, gennaio
MARZO <- im.import("EN_13.png") #ultima foto, marzo

# creiamo un multiframe a una colonna e due righe (quindi un'immagine sopra all'altra)
par(mfrow=c(2,1))
im.plotRGB.auto(GENNAIO) # la funzione con l'aggiunta di "auto" prende direttamente le prime tre bande e fa tutto in automatico; aggiungiamo la prima immagine
im.plotRGB.auto(MARZO) # aggiungo la seconda immagine

# osserviamo la differenza tra le due immagini satellitari
difEN = GENNAIO[[1]] - MARZO[[1]] # Sottrazione tra pixel del primo livello di GENNAIO e pixel del primo livello di MARZO
col <- colorRampPalette(c("blue", "white", "red"))(100) # scelgo la banda di colori, quindi blu è il valore minimo e rosso il valore massimo

#plottiamo
plot(difEN, col=col)


#### nuova analisi
#Ice melt in Grenland
g2000 <- im.import("greenland.2000.tif") #importiamo immagine della Groenlandia del 2000
clg<-colorRampPalette(c("black","blue","white","red")) (100) # chiamo questa palette diversamente da prima: nero sono le T pià basse, rosso le T più alte
plot(g2000, col=clg) #vediamo che la parte nera, più fredda, è quella più interna

#importing other data: immagini degli anni successivi
g2005 <- im.import("greenland.2005.tif") 
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

#multiframe con 2 immagini: 1 riga e due colonne
par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

#multiframe con tutte e 4 le immagini: due righe e due colonne
par(mfrow=c(2,2))
plot(g2000, col=clg)
plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

#stack: per facilitare il tutto, posso fare uno stack e assegnarlo all'oggetto "greenland"
greenland<-c(g2000, g2005, g2010, g2015)
plot(greenland, col=clg)

#faccio la differenza tra primo e quarto livello:
difg = greenland[[1]] - greenland[[4]]
plot(difg, col=col)

# Plottiamo
clgreen <- colorRampPalette(c("red","white","blue")) (100) #invertiamo la palette in modo da vedere il rosso nelle zone in cui la T è aumentata
plot(difg ,col=clgreen)

#Prendiamo 3 livelli di un RGB e per ogni livello metto un livello dello stack prima creato: in base al colore ottenuto, capirò in quale anno ho avuto i valori di T più elevati:
im.plotRGB(greenland, r=1, g=2, b=4) #g2000 on red, g2005 on green, g2015 on blue
