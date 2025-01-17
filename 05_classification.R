# Quantifying land cover change: partendo da un'immagine satellitare, la importiamo, la classfichiamo e poi creereamo dei grafici 

# Installo di un nuovi pacchetti necessari
install.packages("ggplot2") 
install.packages("patchwork")

# Richiamo tutti i pacchetti che servono, compresi quelli nuovi
library(ggplot2)
library(patchwork)
library(terra)
library(imageRy)

# Listing images
im.list() # Elenco delle immagini presenti nel pacchetto imageRy

# Importing data: importo dell'immagine solar orbiter, rinominandola
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") # Nero è il livello energetico più basso, giallo livello energetico più alto

# Classificazione dell'immagine secondo 3 cluster randomici: classifichiamo i diversi livelli energetici del sole
sunc <- im.classify(sun, num_clusters=3) # raggruppo i pixel dell'immagine in soli 3 colori scelti da R in modo random in questo caso

# Mato Grosso images import: importiamo le due immagini rinominandole
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Classify images: classifico Mato Grosso 1992 secondo 2 cluster, bastano perchè l'immagine ha pochi colori, quindi aggiungo la c al nome
m1992c <- im.classify(m1992, num_cluster=2)
#class 1 = forest
#class 2 = river and human modification = suolo nudo

# Classifico Mato Grosso 2006 secondo 2 cluster
m2006c <- im.classify(m2006, num_cluster=2)
#class 1 = forest
#class 2 = human modification = suolo nudo
#ATTENZIONE: le classi potrebbero invertirsi tra 1992 e 2006, è random

# Controllo delle due immagini per avere conferma
plot(m1992c)
plot(m2006c)

# Calculating frequencies: calcolare i pixel relativi ai 2 cluster, per poter cosi calcolare la percentuale di pixel
# Mato Grosso 1992
f1992 <- freq(m1992c)
f1992 # visualizzo il conteggio (o numero) dei pixel relativi ai 2 cluster (o classi)

# Proporzione tra numero dei pixel dei cluster e il totale
tot1992 <- ncell(m1992c) # vedo totale dei pixel, che mi serve per poter fare la proporzione
tot1992

prop1992 = f1992 / tot1992 # proporzione tra i pixel dei due singoli cluster e i pixel totali
prop1992

# per ottenere la percentuale:
perc1992 = prop1992 * 100
perc1992 
# Risultato Percentages Mato Grosso 1992: forest = 83%, human = 17%

# Mato Grosso 2006: facciamo la stessa cosa di prima ma per l'immagine del 2006
f2006 <- freq(m2006c)
f2006
tot2006 <- ncell(m2006c) # Totale dei pixel dei cluster dell'immagine del 2006

# Proportions
prop2006 = f2006 / tot2006 
prop2006

# Percentuali
perc2006 = prop2006 * 100 
perc2006
# Percentages Mato Grosso 2006: forest = 45%, human = 55%

# RISULTATI
# 1992: 17% human, 83% forest
# 2006: 55% human, 45% forest

# Building the dataframe: costruiamo un dataset con la funzione data.frame che ci consente di creare tabelle
class <- c("forest","human")
y1992 <- c(83,17)
y2006 <- c(45,55)

tabout <- data.frame(class, y1992, y2006) # creazione del dataframe in cui inserire le percentuali
tabout # visualizzazione del dataframe

# Per vedere la tabella
view(tabout)

# Grafico: creazione grafico a barre che evidenzia le due percentuali
ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
#aes = aestethic riguarda la struttura del grafico, attribuiamo assi e colori classificati
#con la prima parte abbiamo un pezzo di funzione, per fare il grafico dobbiamo aggiungere + geom_bar: è un tipo di geometria cioè le barre dell'istogramma, con identity usiamo il valore così com'è

#Ripetiamo lo stesso per l'immagine del 2006
ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

# Patchwork: mettiamo insieme i due grafici ottenuti
# Installo e richiamo il pacchetto patchwork

# Assegniamo a p1 e p2 i due ggplot
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")

p1 + p2 # Visualizzo i due grafici affiancati, ma hanno scala diversa!

# Per aggiustare le scale diamo un intervallo di valori per la y con la funzione ylim:
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))

p1 + p2 # Adesso si vede bene il confronto tra le immagini 1992 e 2006
