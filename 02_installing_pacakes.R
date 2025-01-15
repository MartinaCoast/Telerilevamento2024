# Install new packages in R: per vedere i pacchetti disponibili posso cercare su CRAN, ogni pacchetto ha la sua descrizione, oppure posso installare pacchetti anche da GitHub

install.packages("terra") #il nome del pacchetto è tra virgolette perchè sto uscendo da R per ottenere il pacchetto
library(terra) # or require(): questa funzione mi serve per richiamare il pacchetto e verificare che sia stato installato e mi dice che versione ho installato

install.packages("devtools") #questo pacchetto mi serve per poter scaricare il prossimo
library(devtools)

#se volessi rimuovere un pacchetto dovrei usare ala funzione remove.packages("")

# install the imageRy package from GitHub: è un pacchetto che serve per scaricare più velocemente le immagini
# a devtools function:
install_github("ducciorocchini/imageRy")
library(imageRy)

