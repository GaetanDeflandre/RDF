# Chargement des fonctions externes
library ("EBImage")
library( abind );
source ("rdfTools.R")

# -----------------------------------------------
# Images des chiffres:
# width : 528px
# height: 544px
# colonne de chiffre: 32 complètes + 1 non complète
# ligne de chiffre: 34
# Soit 32col * 34row + 1col(12 chiffre)
#
# Les chiffres dans les images:
# width: 16px
# heigth: 16px
# -----------------------------------------------

# abind

filename <- "usps/usps_0.jpg"

image <- rdfReadGreyImage(filename)
image <- t( imageData( image ) );

#if (interactive ()) {
#    display (image, filename)
#}

rows <- 34
cols <- 33
nnumber <- 1100

# longeur des chiffres (largeur et hauteur identique)
numlen <- 16

#for(x in 1:cols){
#    for(y in 1:raws){
#        curx = 
#    }
#}

output <- readUSPSdata("usps")

data <- output[1]
labels <- output[2]

images <- splitImageArray( image, 34, 33, 16, 16 )
