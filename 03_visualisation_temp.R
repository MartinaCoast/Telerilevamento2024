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

# Importiamo la banda del rosso, la numero 4
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=clcyan)

# Importiamo la banda 8
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8, col=clcyan)




