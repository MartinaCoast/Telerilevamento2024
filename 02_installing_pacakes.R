# Install new packages in R: per vedere i pacchetti disponibili posso cercare su CRAN, ogni pacchetto ha la sua descrizione, oppure posso installare pacchetti anche da GitHub

# Per installare un pacchetto dal CRAN uso la funzione install.packages()
install.packages("terra") #il nome del pacchetto è tra virgolette perchè sto uscendo da R per ottenere il pacchetto
library(terra) # or require(): questa funzione mi serve per richiamare il pacchetto e verificare che sia stato installato, mi dice anche che versione ho installato

# Per installare un pacchetto esterno al CRAN ma presente su GitHub: mi serve la funzone devtools (presente sul CRAN) 
install.packages("devtools") #questo pacchetto mi serve per poter scaricare il prossimo pacchetto esterno dal CRAN
library(devtools)

# Installo il pacchetto imageRy, presente su GitHub: è un pacchetto che serve per scaricare più velocemente le immagini
# Installo la repository imageRy da GitHub:
install_github("ducciorocchini/imageRy")
library(imageRy) #richiamo il pacchetto per vedere che sia stato installato correttamente

#se volessi rimuovere un pacchetto dovrei usare la funzione remove.packages("")
