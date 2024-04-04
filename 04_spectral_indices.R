# Spectral indicies

library (terra)
library (imageRy)

# list of files
im.list()

# importiamo l'immagine
m1992 <- im.import ("matogrosso_l5_1992219_lrg.jpg")

# bands
# band 1 = NIR
# band 2 = red
# band 3 = green

# facciamo dei plot  con la funzione im.plotRGB
im.plotRGB(m1992, r=1, g=2, b=3)  # posso anche non mettere lettera=, è la stessa cosa

# NIR on green
im.plotRGB(m1992, 2, 1, 3)

# NIR on blue
im.plotRGB(m1992, 2, 3, 1)

# 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

par(mfrow=c(1,2))
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m2006, 1, 2, 3)

dev.off()

# nir ontop of green
im.plotRGB(m2006, 2, 1, 3)

# nir ontop of blue
im.plotRGB(m2006, 2, 3, 1)

# mettiamo a confronto le due situazioni banda per banda
par(mfrow=c(2,3))
im.plotRGB(m1992, 1, 2, 3) # 1992 nir on red
im.plotRGB(m1992, 2, 1, 3) # 1992 NIR on green
im.plotRGB(m1992, 2, 3, 1) # 1992 NIR on blue

im.plotRGB(m2006, 1, 2, 3) # 2006 nir on red
im.plotRGB(m2006, 2, 1, 3) # 2006 nir on green
im.plotRGB(m2006, 2, 3, 1) # 2006 nir on blue


# calcolo indice DVI (Difference Vegetation Index)
# band 1 = NIR
# band 2 = red
dvi1992 = m1992[[1]] - m1992[[2]] # dichiariamo gli elementi che vogliamo utilizzare, quindi il primo elemento [1] e il secondo elemento [2]
dvi1992

# plotting the DVI
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

# rifacciamo la stessa operazione per calcolare il DVI del 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
# DVI 2006
dvi2006 = m2006[[1]] - m2006[[2]]
dvi2006

plot(dvi2006, col=cl)

# esercizio: plot the dvi1992 beside the dvi2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# Normalized Difference Vegetation Index
ndvi1992 = dvi1992/(m1992[[1]] + m1992[[2]])
ndvi2006 = dvi2006/(m2006[[1]] + m2006[[2]])

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# speediing up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2) # è la stessa cosa che ho appena fatto, semplicemente questa è una funzione dentro al pacchetto di imageRy, dove 1 e 2 rappresentano sempre le bande NIR e RED
plot(ndvi2006a, col=cl)
