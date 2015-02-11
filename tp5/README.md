TP5
===

## Q1

C'est valeur sont les niveaux de gris du creu entre les deux pire de
gris. Ce sont les niveau de gris entre les gris de la classe 1 et 2
qui sont le moins présent.

La valeur qui met de mieux classifier les pixels est le seuil 0.36,
avec encore quelques pixels d'erreur. Car certains pixels de omaga 1
sont au-dessus du seuil et certains pixels de omaga 2 sont en dessous
du seuil.


## Q2

P(omega1) = 56/100
P(omega2) = 44/100

    rdfProbabilite <-function(omegaSize, imageSize){
        omegaSize / imageSize
    }

    rdfProbabilite(length(omega1), length(image))
    [1] 0.56

