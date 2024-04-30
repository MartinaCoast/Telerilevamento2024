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
