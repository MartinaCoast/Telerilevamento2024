# Measuring variability from satellite imagery

library(imageRy)
library(terra)

im.list()
sent <- im.import("sentinel.png")

im.plotRGB(sent, 1, 2, 3)

# NIR = band 1
# red = band 2
# green = band 3

im.plotRGB(sent, r=2, g=1, b=3)

nir <- sent[[1]] #assegno la prima banda della mia immagine satellitare all'oggetto nir
cl <- colorRampPalette(c("red", "orange", "yellow"))(100) #100 è il numero di intervalli delle sfumature
plot(nir, col=cl)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # con focal ...
plot(sd3)

install.packages("viridis")

# in viridis esistono delle palette già formate, posso scegliere direttamente quelle: noi usiamo quella viridis
viridisc <- colorRampPalette(viridis(7))(100) # il 7 vuol dire che è la settima di una serie di palette, qui assegniamo la palette viridis(7) all'oggetto viridisc
plot(sd3, col=viridisc)

# calculate the sd mw of 7 pixels
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd) # calcolo la deviazione standard 13x13
plot(sd13, col=viridisc) # ho un effetto iper sfocato ma non ho capito perche e cosa vuol dire questa roba

sdstack <- c(sd3, sd7, sd13)
plot(sdstack, col=viridisc)
