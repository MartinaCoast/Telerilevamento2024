#ANALISI MULTIVARIATA

#Recuperiamo i pacchetti:
library(terra)
library(imageRy)
library(viridis)

#Apriamo la lista di dati e usiamo le immagini delle dolomiti:
im.list()

#Importazione dei dati:
b2 <- im.import("sentinel.dolomites.b2.tif") #blu
b3 <- im.import("sentinel.dolomites.b3.tif") #verde
b4 <- im.import("sentinel.dolomites.b4.tif") #rosso
b8 <- im.import("sentinel.dolomites.b8.tif") #nir

#Creiamo uno stack unendo le varie immagini:
sentdo <- c(b2, b3, b4, b8)

#Creiamo un plot:
im.plotRGB(sentdo, r=4, g=3, b=2) #banda 4 montata su rosso, banda 3 su verde, banda 2 su blu

#Oppure:
im.plotRGB(sentdo, r=3, g=4, b=2) # in questo caso banda 3 montata su rosso, banda 4 su verde e banda 2 su blu

#Osserviamo quanto sono collegate le immagini tra di loro con la funzione "pairs", che calcola la correlazione basandosi sulla matrice di Pearson:
pairs(sentdo)
# Tra le bande blu, verde e rosso c'è un'alta correlazione (0.99 in un range che va da -1 (correlazione negativa) a +1(correlazione positiva))
# Le immagini in diagonale e in verde mostrano le correlazioni tra le bande. Rosso, Verde e Blu sono correlate tra loro, il NIR ha una correlazione minore con le altre bande.

#PCA: portare un sistema da n bande ad una banda sola
pcimage <- im.pca(sentdo) #PERCHè VEDO SOLO 3 IMMAGINI? NON ERANO 4?

#Per avere totale della deviazione standard di tutto il sistema fai la somma dei range di ogni asse
tot <- sum(1429.92581, 616.51606, 72.69737, 31.05157) # HO PRESO I VALROI GIUSTI??

#DA QUI IN POI SE I VALORI SONO SBAGLIATI LE PERCENTUALI NON SONO QUELLE!!
#Per avere la percentuale della variabilità spiegata dalla prima componenete:
1548.32458 * 100/tot #75%

#Per avere la percentuale della variabilità spiegata dalla seconda componenete:
423.42968 * 100/tot #circa 20%

#Per avere la percentuale della variabilità spiegata dalla terza componenete:
52.10700 * 100/tot # 2.5%

#Per avere la percentuale della variabilità spiegata dalla quarta componenete:
32.75954 * 100/tot #circa 1.5%

#plottiamo usando viridis:
vir <- colorRampPalette(viridis(7))(100)

plot(pcimage, col=vir) #NON HO CAPITO
#il 70% dell'informaizone è contenuto all'interno della prima componente; nella seconda ho il 20%; nella terza immagine in pratica non ha nessuna informazione all'interno, guarda quanto sono brutti i colori

#Oppure per evitare la colorRampPalette
plot(pcimage, col=viridis(100))

#Con un'altra palette di colori:
plot(pcimage, col=plasma(100))
