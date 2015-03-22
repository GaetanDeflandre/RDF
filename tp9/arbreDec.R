# --------------------------------------
# Chargement de la base de noms d'animaux
# --------------------------------------
source ("rdfAnimaux.txt")
# --------------------------------------


# --------------------------------------
# Fonctions
# --------------------------------------
str2int <- function(x) { strtoi(charToRaw(x),16L)-96 }


int2str <- function(x) {
    x <- x+96
    mode(x) <- "raw"
    return (rawToChar(x))
}


findBestLetter <- function(mat, n) {
    h <- numeric(26)

    for(i in 1:26){
        h[i] = sum(mat[i,])
    }

    # Passage entre 0 et 1 (probabilité)
    h <- (h/n)

    hinv = 1-h
    entropie = - (log2(h^h) + log2(hinv^hinv))

    return (which.max(entropie))
}


findWord <- function(mat, n) {

    # condition de fin de récursion
    if(n==1){
        return (mat[27,1])
    }

    best = findBestLetter(mat,n)
 
    print(paste("Ce mot contient-il la lettre '", int2str(best), "' ? (oui/non)", sep=""))
    res <- readline()

    n_oui <- sum(mat[best,])
    n_non <- n - n_oui

    mat_oui <- matrix(rep(0,27*n_oui),nrow=27, ncol=n_oui);
    mat_non <- matrix(rep(0,27*n_non),nrow=27, ncol=n_non);

    cpt_oui <- 1
    cpt_non <- 1

    for(i in 1:n){
        if(mat[best,i]==1){

            mat_oui[,cpt_oui] = mat[,i]
            cpt_oui <- cpt_oui+1

        } else if(mat[best,i]==0){

            mat_non[,cpt_non] = mat[,i]
            cpt_non <- cpt_non+1

        }
    }

    if(res == "oui") {
        return (findWord(mat_oui, n_oui))
    } else if(res == "non") {
        return (findWord(mat_non, n_non))
    }
}

traceArbre <- function(vnom, mat, n, depth) {

    # condition de fin de récursion
    if(n==1){
        return (depth-1)
    }

    best = findBestLetter(mat,n)
 
    if(is.element(int2str(best), vnom)){
        print(paste("Lettre '", int2str(best), "' n° ", depth, " est présente", sep=""))
        res <- "oui"
    } else {
        print(paste("Lettre '", int2str(best), "' n° ", depth, " n'est pas présente", sep=""))
        res <- "non"
    } 


    n_oui <- sum(mat[best,])
    n_non <- n - n_oui

    mat_oui <- matrix(rep(0,27*n_oui),nrow=27, ncol=n_oui);
    mat_non <- matrix(rep(0,27*n_non),nrow=27, ncol=n_non);

    cpt_oui <- 1
    cpt_non <- 1

    for(i in 1:n){
        if(mat[best,i]==1){

            mat_oui[,cpt_oui] = mat[,i]
            cpt_oui <- cpt_oui+1

        } else if(mat[best,i]==0){

            mat_non[,cpt_non] = mat[,i]
            cpt_non <- cpt_non+1

        }
    }

    if(res == "oui") {
        return (traceArbre(vnom, mat_oui, n_oui, depth+1))
    } else if(res == "non") {
        return (traceArbre(vnom, mat_non, n_non, depth+1))
    }
}
# --------------------------------------


# --------------------------------------
# Début macro
# --------------------------------------


# INITIALISATION

# Nombre de mots
n = length(noms)

# `mat` est un tableau de bouléen, qui indique quelles
# lettres sont présente dans chacun des mots.

# Création du tableau
mat = matrix(rep(0,27*n),nrow=27, ncol=n);

# Construction du tableau
for (i in 1:n)
{
    c = str2int(noms[i])
    mat[c,i] <- 1
    mat[27,i] <- i
}


# CHOIX DU MODE

print("Choix du mode: (jeu/arbre/stat)")
mode <- readline()

stopifnot(is.element(mode,c("jeu","arbre","stat")))

if(mode=="jeu"){

    # JEU

    print("Pensez à un animal de la liste.")

    found_id = findWord(mat,n)
    print(noms[found_id])

} else if(mode=="arbre"){

    # ARBRE

    print("Animal à chercher:")
    nom <- readline()

    stopifnot(is.element(nom,noms))

    vnom <- strsplit(nom,'')[[1]]

    depth <- traceArbre(vnom, mat, n, 1)
    print(paste("La profondeur de l'arbre pour le mot \"", nom, "\" est ", depth ,sep=""))

} else if(mode=="stat"){

    # STAT

    depth_max = 0.0
    depth_tmp = 0.0
    depth_moy = 0.0
    id_d_max = 0.0

    for(i in 1:n){
        vnom <- strsplit(noms[i],'')[[1]]
        depth_tmp = traceArbre(vnom, mat, n, 1)
        depth_moy = depth_moy + depth_tmp
        if(depth_tmp>depth_max){
            depth_max = depth_tmp
            id_d_max = i
        }
    }

    depth_moy = depth_moy/n

    print(paste("Le nombre de question moyenne est", depth_moy, sep=" "))
    print(paste("Le not le plus dévaforable est", noms[id_d_max], "avec une profondeur de", depth_max, sep=" "))
}

# --------------------------------------
