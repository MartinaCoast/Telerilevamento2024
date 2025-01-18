# Measuring variability from satellite imagery

#riprendiamo i soliti pacchetti
library(imageRy)
library(terra)

im.list() #visualizziamo i dati contenuti in imageRy
sent <- im.import("sentinel.png") #importiamo questa immagine del Satellite Sentinel

#plottiamo
im.plotRGB(sent, 1, 2, 3) #veg è rossa; suolo nudo è azzurro; acqua è nera perchè assorbe infrarosso
#nir = band 1
#red = band 2
#green = band 3

im.plotRGB(sent, r=2, g=1, b=3) #cambiamo i colori delle bande
#red = banda 1
#nir = banda 2
#green = banda 3

#Proviamo a valutare la VARIABILITÀ, con il metodo "Moving Window", usando una finestra esterna di calcolo della dev standard di cui sceglieremo la dimensione in pixel, solitamente 3 x 3 pixel
#La dev standard lavora su un'unica variabile, quindi dobbiamo scegliere un'unica banda, quella dell'infrarosso

#Associamo la prima banda dell'immagine satellitare all'oggetto "nir"
nir <- sent[[1]]
plot(nir) #plottiamola

#modifichiamo i colori
cl <- colorRampPalette(c("red", "orange", "yellow"))(100) #100 è il numero di intervalli delle sfumature
plot(nir, col=cl) #plottiamola con i nuovi colori

#Useremo la nuova funzione "focal" che permette di estarre valori focali, ossia statistiche, in un gruppo di valori: qui la dev standard.
focal(nir, matrix (1/9, 3, 3), fun=sd)
# nir è l'immagine usata
# matrix: 1/9 perchè useremo un unico pixel su 9, la matrice è di 3x3 pixel. È l'unità di misura. 
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
