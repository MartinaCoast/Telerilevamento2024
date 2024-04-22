# quantifying land cover change

# installo di un nuovo pacchetto
install.packages("ggplot2") 

# richiamo tutti i pacchetti che servono, compreso quello nuovo
library(ggplot2)
library(terra)
library(imageRy)

# listing images
im.list() # elenco delle immagini presenti nel pacchetto

# importing data: importo di matogrosso.1992 e solar orbiter
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# classificazione dell'immagine secondo 3 cluster randomici
sunc <- im.classify(sun,num_clusters=3) # raggruppo i pixel dell'immagine in soli 3 colori scelti da R in modo random in questo caso

# Mato Grosso images import
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Classify images, quindi metto lo stesso nome ma con la c
# classifico Mato Grosso 1992 secondo 2 cluster, bastano perchè l'immagine ha pochi colori
m1992c <- im.classify(m1992, num_cluster=2)

# class 1 = forest
# class 2 = river and human modification

# classifico Mato Grosso 2006 secondo 2 cluster
m2006c <- im.classify(m2006, num_cluster=2)

# class 1 = forest
# class 2 = human
# attenzione che le classi potrebbero invertirsi tra 1992 e 2006, è random

# controllo delle due immagini
plot(m1992c)
plot(m2006c)

# calculating frequencies Mato Grosso 1992
f1992 <- freq(m1992c)
f1992 # vedo il conteggio dei pixel relativi ai 2 cluster

# proportions dei pixel dei due cluster
tot1992 <- ncell(m1992c) # vedo totale dei pixel
prop1992 = f1992 / tot1992 # proporzione tra i pixel dei due singoli cluster e i pixel totali
prop1992

# percentages
perc1992 = prop1992 * 100
perc1992 
# percentages Mato Grosso 1992: forest = 83%, human = 17%

# calculating frequencies Mato Grosso 2006
f2006 <- freq(m2006c)
f2006
tot2006 <- ncell(m2006c)

# proportions
prop2006 = f2006 / tot2006 
prop2006

# percentages
perc2006 = prop2006 * 100 
perc2006
# percentages Mato Grosso 2006: forest = 45%, human = 55%

# 1992: 17% human, 83% forest
# 2006: 55% human, 45% forest

# building the dataframe
class<-c("forest","human")
p1992<-c(83,17)
p2006<-c(45,55)

tabout<-data.frame(class, p1992, p2006) # creazione del dataframe in cui inserire le percentuali
tabout # visualizzazione del dataframe

#ggplot2 graphs
# creazione grafico a barre che evidenzia le due percentuali
geom_bar(stat="identity",fill="white") # ???
ggplot(tabout,aes(x=class,y=p1992,color=class)) + geom_bar(stat="identity",fill="white")
#aes = aestethic riguarda la struttura del grafico
#con la prima parte abbiamo solo aggiunto un pezzo di funzione, per fare il grafico serve geom_bar

#facciamo lo stesso per 2006
ggplot(tabout,aes(x=class,y=p2006,color=class)) + geom_bar(stat="identity",fill="white")

# patchwork
install.packages("patchwork")
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity",fill="white")
p1 + p2
# NON MI PLOTTAAAAA
# POI MANCANO DUE RIGHE

