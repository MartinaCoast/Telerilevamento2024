# First R script

# R as a calculator
a <- 6*7
b <- 5*8

a+b

# Arrays: per crearli devo inserire il simbolo di assegnazione <-c()

flowers <- c(3, 6, 8, 10, 15, 18)
flowers

insects <- c(10,16,25,42,61,73)
insects

plot(flowers, insects) #è una funzione, quindi è come se scrivessi che voglio il grafico della funzione f(x,y)

# changing plot parameters

#symbols: posso cambiare il simbolo, esiste un codice per ogni tipo di simbolo, pch = point character
plot(flowers, insects,pch=19)

#symbol dimensions: posso modificare anche le dimensioni dei punti del plot, cex = character exageration
plot(flowers, insects, pch=19, cex=2)  #se voglio rimpicciolire metto numeri più piccoli

# per cambiare il colore del simbolo aggiungo tra parentesi col="nome del colore"
plot(flowers, insects, pch=19, cex=2, cex=.5, col="chocolate1")

#se voglio cambiare i nomi di asse x e y aggiungo xlab="nuovo nome" e ylab="nuovo nome"
plot(flowers, insects, pch=19, cex=2, cex=.5, col="chocolate1", xlab="flora", ylab="fauna")
