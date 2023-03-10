#My first code in Git Hub
#raster ci indica tutti gli indici di diversità per matrici numeriche

#i pacchetti si trovano nel CRAN, è il server dal quale abbiamo scaricato anche R. Andiamo nel CRAN per scaricare un pacchetto
install.packages("raster")
library(raster)

#import data, setting the working directory
setwd("C:/lab")
getwd()

#importiamo il dato e lo assegno ad una variabile
l2011 <- brick("p224r63_2011_masked.grd")

#plottiamo i data
plot(l2011)

#vediamo la riflettanza nella banda 1, in landsat era il blu. #banda 4, near infrared.
#cambiamo i colori

cl<- colorRampPalette(c("red", "orange", "yellow")) (100)

#fuori mettiamo il numero delle sfumature che vogliamo 

plot(l2011, col=cl)
#abbiamo rifatto il plot come prima ma il colore è nuovo, con cl
#abbiamo la possibilità di utilizzare una banda sola, prendiamo un elemento
#plottiamo il quarto elemento, con l'infrarosso

plot(l2011[[4]], col=cl)

#posso utilizzare anche il nome dell'elemento, leghiamo i due pezzi con il dollaro
l2011
plot(l2011$B4_sre, col=cl)

nir <- l2011[[4]] #or : nir <- l2011$B4_sre

plot(nir, col=cl)
