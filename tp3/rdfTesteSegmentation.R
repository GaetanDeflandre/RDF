# -----------------------------------------------------------------------
# Extraction d'attributs de pixels pour la classification,
# Module RdF, reconnaissance de formes
# Copyleft (C) 2014, Universite Lille 1
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# -----------------------------------------------------------------------

# Chargement des fonctions externes
library ("EBImage")
source ("rdfSegmentation.R")


# Chargement d'une image
nom <- "rdf-2-classes-texture-0.png"
nomref <- "rdf-masque-ronds.png"
image <- rdfReadGreyImage (nom)
ref <- rdfReadGreyImage (nomref)

o = rdfTextureEcartType(image, 2)



# Calcul et affichage de son histogramme
nbins <- 256
#h <- hist (as.vector (image), breaks = seq (0, 1, 1 / nbins))
h <- hist (as.vector (o), breaks = seq (0, 1, 1 / nbins))

# Segmentation par binarisation
seuil0 <- 0.5
seuil1 <- 0.6
seuil2 <- 0.28
seuil3 <- 0.37
seuil4 <- 0.41
seuil <- seuil0
binaire <- (image - seuil) >= 0
# image 2 image 3
#binaire <- (image - seuil) < 0


# Affichage des deux images
if (interactive ()) {
#  display (image, nom)
#  display (binaire, "image binaire")
}


imgerr <- imageErreur(binaire, ref)
tauxerr <- pourcentageErreur(imgerr)

print(tauxerr)
# taux img 0: 0.1159668
# taux img 1: 1.11084
# taux img 2: 15.29541
# taux img 3: 21.89941
# taux img 4: 49.21265



if (interactive ()) {
  #display (imgerr, "image binaire")
}
