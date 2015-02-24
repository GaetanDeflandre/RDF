TP3 : RdF Segmentation par binarisation
=======================================


## Code R

### Q1

*bins* correspond aux nombres de division sur l'axe horizontal de l'histogramme, 
càd les niveau de gris. On prend une valeur de 256 car il y a 256 niveaux de gris 
dans une image numérique.

### Q2

*seuil* correspond au moment où un pixel de fond devient pixel objet.

<<<<<<< HEAD
### Conclusion segmentation par binarisation

Conclure sur la possibilité ou pas de binariser toutes les images fournies 
en associant à chaque pixel son niveau de gris comme seul attribut pour la 
segmentation. 

Lorsque l'image à binariser est trop détériorer, avec un bruit de forte 
amplitude par exemple (bruit sur toute les nuances de gris). Il est 
difficile de déterminer les pixels du fond et ce de l'objet par un 
simple seuillage pixel par pixel.

### Histogramme des niveaux de texture

#### rdfMoyenneImage
=======

## Histogramme des niveaux de gris

### Taux d'erreurs

 - Texture 0: 0.1159668
 - Texture 1: 0.8850098
 - Texture 2: 15.58838
 - Texture 3: 19.6167
 - Texture 4: 45.89233

### Conclusion niveaux de gris

Lorsque les images sont de bonne qualité (texture 0 et 1) ont retrouve 
facilement sur l'histogramme deux pic et un creux entre les deux nous 
permettant dobtenir un seuil fiable.

Cependant quand les images à binariser sont trop détériorer (texutre 2, 
3), avec beaucoup de bruit. L'histogramme des niveaux de gris, ne nous 
permet pas de déterminer un seuil précisément. 

Pour la texture 4, en plus d'être fortement bruité, les niveaux de gris 
de l'image sont proches. Il est impossible de déterminer un seuil 
uniquement avec son histogramme.


## Histogramme des niveaux de texture

### rdfMoyenneImage
>>>>>>> 247647dd05bf763c8b92b85151534f294cb6058f

Cette fonction applique un filtre moyenneur avec un masque qui est une matrice 
N\*N où N vaut taille\*2+1.


<<<<<<< HEAD
#### rdfTextureEcartType
=======
### rdfTextureEcartType
>>>>>>> 247647dd05bf763c8b92b85151534f294cb6058f

Calcul de l'ecart type de la texture de l'image (la différence entre l'image 
et l'image moyenné).


<<<<<<< HEAD
#### Comment fixe-t-on la dimension du voisinage de calcul grâce à l'argument taille passé à la fonction?
=======
### Comment fixe-t-on la dimension du voisinage de calcul grâce à l'argument taille passé à la fonction?
>>>>>>> 247647dd05bf763c8b92b85151534f294cb6058f

On informe du voisinage qui nous intéresse grace au paramètre taille passé 
aux fonctions. Ce paramètre, tel un rayon, indique le nombre de pixel à prendre 
en compte autour du pixel cible. Si le taille = 2 alors masque sera une matrice 
de 5*5 pixels.
<<<<<<< HEAD
=======

### Taux d'erreurs

 - Texture 0: 0.1159668
 - Texture 1: 37.42065
 - Texture 2: 19.49463
 - Texture 3: 25.28076
 - Texture 4: 56.70776
 
### Conclusion niveau de texture

Il est plus facile de déterminer un seuil avec l'histoigramme de texture, 
pour les images qui sont plus détérioré par le bruit. Néanmoins, le taux 
d'erreur n'est pas forcement plus faible. On peut noter que, pour la 
texture 4, même si le taux d'erreurs est plus élevé avec cette technique 
les objects sont mieux segmenter. Tous les pixels des objects de premier 
plan sont reconnu, or le fond n'est pas correctement ignoré. Ceci est 
directement lié à la technique du seuillage et aux ton de gris  très 
proches entre les pixels des l'objects et ceux du fond. On ne peut pas 
faire mieux avec un seuillage. 
Par conséquent, la méthodes de ségmentation avec l'histogramme des textures, 
permet de retrouver un seuil pour segmenter une image quand l'histogramme de 
gris ne le permet pas, mais les résultat ne sont pas fiable dans tous les 
cas.


## Histogramme conjoint

### Approximation de droite

 - Texture 0: 
 - Texture 1: 
 - Texture 2: 
 - Texture 3: 
 - Texture 4: 
>>>>>>> 247647dd05bf763c8b92b85151534f294cb6058f
