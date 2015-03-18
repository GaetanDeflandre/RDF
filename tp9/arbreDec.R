# Chargement de la base de noms d'animaux
source ("rdfAnimaux.txt")

# Fonctions
str2int <- function(x) { strtoi(charToRaw(x),16L)-96 }

int2str <- function(x) {
    x <- x+96
    mode(x) <- "raw"
    return (rawToChar(x))
}


# Nombre de mots
n = length(noms)

# `mat` est un tableau de bouléen, qui indique quelles
# lettres sont présente dans chacun des mots.

# Création du tableau
mat = matrix(rep(0,26*n),nrow=26, ncol=n);

# Construction du tableau
for (i in 1:n)
{
    c = str2int(noms[i]);
    mat[c,i] <- 1;
}

h <- numeric(26)

for(i in 1:26){
    h[i] = sum(mat[i,])
}

# Passage entre 0 et 1 (probabilité)
h <- (h/n)

hinv = 1-h
entropie = - (log2(h^h) + log2(hinv^hinv))

best = which.max(entropie)
