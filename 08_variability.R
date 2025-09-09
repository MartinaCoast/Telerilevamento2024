# Measuring variability from satellite imagery

# MISURA DELLA VARIABILITA': a partire da un'immagine, si possono misurare i valori di riflettanza per ogni pixel. 
# Vedendo come riflette ogni pixel per le bande si forma una grafico: più i punti sono simili, più la nuvola sarà compatta.
# Maggiore è la variabilità in termini spettrali maggiore sarà la variabilità a livello ambientale e quindi saranno presenti più nicchie ecologiche e più specie.
# Si può applicare la stessa variabilità per la geomorfologia. Questo grazie alla deviazione standard: presa una curva normale, la ds sarà il 68% dei dati. 
# Maggiore è la deviazione standard, maggiore sarà la variabilità ecosistemica/geomorfologica.

#riprendiamo i soliti pacchetti
library(imageRy)
library(terra)

im.list() #visualizziamo i dati contenuti in imageRy
sent <- im.import("sentinel.png") #importiamo questa immagine del Satellite Sentinel

#plottiamo
im.plotRGB(sent, 1, 2, 3) #veg è rossa; suolo nudo è azzurro; acqua è nera perchè assorbe infrarosso
#nir = banda 1
#rosso = banda 2
#verde = banda 3

im.plotRGB(sent, r=2, g=1, b=3) #cambiamo i colori delle bande
#rosso = banda 1
#nir = banda 2
#verde = banda 3

#Proviamo a valutare la VARIABILITÀ, con il metodo "Moving Window", usando una finestra esterna di calcolo della deviazione standard di cui sceglieremo la dimensione in pixel, solitamente 3 x 3 pixel
#La dev standard lavora su un'unica variabile, quindi dobbiamo scegliere un'unica banda, quella dell'infrarosso. Si calcola la deviazione standard di ogni pixel e la si riporta sul pixel centrale
#Così facendo si ottiene una mappa completa con tutte le deviazioni standard degli intervalli dati dalla grandezza della moving window

#Associamo la prima banda dell'immagine satellitare all'oggetto "nir"
nir <- sent[[1]]
plot(nir) #plottiamola

#modifichiamo i colori
cl <- colorRampPalette(c("red", "orange", "yellow"))(100) #100 è il numero di intervalli delle 3 sfumature
plot(nir, col=cl) #plottiamola con i nuovi colori

#Useremo la nuova funzione "focal" che permette di estarre valori focali, ossia statistiche, in un gruppo di valori: qui la dev standard.
focal(nir, matrix (1/9, 3, 3), fun=sd)
# nir è l'immagine usata
# matrix: matrice, 1/9 perchè useremo un unico pixel su 9, la matrice è di 3x3 pixel. È l'unità di misura. 
# funzione usata è sd (="standard deviation") N.B. non nominare con sd perchè corrisponde al nome della funzione

#rinominiamo l'oggetto e plottiamo l'immagine
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

#installiamo un nuovo pachetto che ci permetterà di modificare i colori: è un pacchetto che ha combinazioni di colori visibili anche ai daltonici
install.packages("viridis")
library(viridis) #riprendiamo il pacchetto

# in viridis esistono delle palette già formate, posso scegliere direttamente quelle: noi usiamo quella viridis
viridisc <- colorRampPalette(viridis(7))(100) 
# il 7 vuol dire che è la settima di una serie di palette, qui assegniamo la palette viridis(7) all'oggetto viridisc

#plottiamo l'immagine con i nuovi colori del pacchetto viridis
plot(sd3, col=viridisc)
#alta variabilità a livello morfologico nelle zone di passaggio tra neve e non neve

# la variabilità viene indicata con la differenza di colore: dove è stato rimarcato il giallo vi è maggiore variabilità. Vengono risaltati molto di più i bordi.
# più è piccola la finestra, maggiore sarà la misura di dettaglio della deviazione standard. 

# calcoliamo la sd di una moving window di 7x7 pixel
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)

#plottiamola
plot(sd7, col=viridisc)
#essendoci più pixel nel calcolo, la sd risulta più alta in zone più ampie. Il valore massimo è inferiore a quello di prima perchè abbiamo più pixel simili, quindi minor metri quadrati

#Calcola la sd di una moving window di 13x13 pixel:
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)
plot(sd13, col=viridisc) # plottiamola: ho un effetto iper sfocato, ma perchè??

#facciamo uno stack delle 3 immagini della sd
sdstack <- c(sd3, sd7, sd13)

#plottiamolo con i colori di viridis
plot(sdstack, col=viridisc)

# La banda che più viene scelta per eseguire questi calcoli è quella del NIR perché è più discriminante. Se non ci fosse il nir, allora si potrebbe ovviare
# con le componenti principali, delle quali la prima componente comprenderà la più ampia variabilità. Essendo le bande originali molto correlate tra loro si 
# esegue l'analisi delle componenti principali così da avere la componente con la più alta variabilità. 

# Per vedere la correlazione:
pairs(sent)
