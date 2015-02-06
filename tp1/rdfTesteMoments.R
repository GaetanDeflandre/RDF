# -----------------------------------------------------------------------
# Extraction d'attributs de forme,
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
source ("rdfMoments.R")

# Chargement d'une image d'un seul objet
#rdf-carre-6.png
#rdf-carre-10.png
#rdf-carre-10-30deg.png
#rdf-carre-10-45deg.png
#rdf-rectangle-horizontal.png
#rdf-rectangle-vertical.png
#rdf-rectangle-diagonal-lisse.png
#rdf-rectangle-diagonal.png
#rdf-triangle-10.png
#rdf-triangle-10-15deg.png
#rdf-triangle-10-45deg.png
#rdf-chiffre-0.png
#rdf-chiffre-1.png
#rdf-chiffre-2.png
#rdf-chiffre-3.png
nom <- "img/rdf-rectangle-diagonal.png";
image <- rdfReadGreyImage (nom)
#if (interactive ()) {
#  display (image, nom)
#}

print("Barycentre:")

surface <- rdfSurface (image)
cx <- rdfMoment (image, 1, 0) / surface
cy <- rdfMoment (image, 0, 1) / surface

print(paste("x:", cx, sep=" "))
print(paste("y:", cy, sep=" "))
print("")

print("Tenseur d'inertie:")

tenseur <- rdfTenseurInertie(image)
print(tenseur)
print("")
print("Valeurs propres:")
print(rdfValeursPropres(tenseur))
print("")
print("Vecteurs propres:")
print(rdfVecteursPropres(tenseur))
print("Hu")
rdfMomentsInvariants(image)

