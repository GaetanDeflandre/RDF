# -----------------------------------------------------------------------
# Extraction d'attributs de contours,
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
source ("rdfContours.R")

# Chargement d'un contour
nom_ca <- "rdf-carre-80.txt"
nom_ce <- "rdf-cercle-80.txt"
nom_ratatac <- "rdf-patate.png"
nom_rec <- "rdf-rectangle-horizontal.png"
nom_tri <- "rdf-triangle-20.png"
nom_crx <- "rdf-croix.png"
cont_ca <- rdfChargeFichierContour (nom_ca)
cont_ce <- rdfChargeFichierContour (nom_ce)
cont_ratatac <- rdfLoadGreyImagetoComplexeBound (nom_ratatac)
cont_rec <- rdfLoadGreyImagetoComplexeBound (nom_rec)
cont_tri <- rdfLoadGreyImagetoComplexeBound (nom_tri)
cont_crx <- rdfLoadGreyImagetoComplexeBound (nom_crx)

nom  <- nom_crx
cont <- cont_crx

# Afficher le contour
plot (cont, main = nom, type = "o", asp = 1, col = "red", ylim = rev (range (Im (cont))))

# Descripteur de fourier
desc <- rdfDescFourierNormalized(cont)
descAnn <- rdfAnnuleDescFourier(desc, 0.5)
contAnn <- rdfDescFourierInverse(descAnn)

#plot (contAnn, main = nom, type = "o", asp = 1, col = "red", ylim = rev (range (Im (contAnn))))

# Algorithme de la courde
corde <- rdfAlgorithmeCorde(cont, 0.8)
plot (corde, main = nom, type = "o", asp = 1, col = "red", ylim = rev (range (Im (corde))))
