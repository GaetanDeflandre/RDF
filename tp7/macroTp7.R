library("MASS")
library("lattice")

(load(file='x_app.data'))
(load(file='x_test.data'))
(load(file='classe_app.data'))
(load(file='classe_test.data'))

n_app  <- 300
n_test <- 300

couleur_app<-rep('red',n_app)
couleur_app[classe_app==2]='green'
couleur_app[classe_app==3]='blue'

couleur_test<-rep('red',n_test)
couleur_test[classe_test==2]='green'
couleur_test[classe_test==3]='blue'


# Affichage des donnees

plot(x_app, col = couleur_app, main="Donnees d apprentissage")
plot(x_test, col = couleur_test, main="Donnees de teste")


# Calcul de la co-variance
S <- cov(x_app)

# Valeur et vecteur propre
Vp <- eigen(S)

# Affichage de la droite correspondant au vecteur propre 
# dont la valeur propre et la plus elevee
pente <- Vp$vectors[2,1]/Vp$vectors[1,1]
abline(a=0, b=pente, col="orange")


# Scalar app
ScalarProduct_app <- x_app
ScalarProduct_app <- x_app %*% (Vp$vectors[,1]) / sqrt(sum(Vp$vectors[,1]*Vp$vectors[,1]))
x_app_ACP <- x_app

# Projection
x_app_ACP[,1] = ScalarProduct_app * Vp$vectors[1,1]
x_app_ACP[,2] = ScalarProduct_app * Vp$vectors[2,1]


# Scalar test
ScalarProduct_test <- x_test
ScalarProduct_test <- x_test %*% (Vp$vectors[,1]) / sqrt(sum(Vp$vectors[,1]*Vp$vectors[,1]))
x_test_ACP <- x_test

# Projection
x_test_ACP[,1] = ScalarProduct_test * Vp$vectors[1,1]
x_test_ACP[,2] = ScalarProduct_test * Vp$vectors[2,1]

# Affichage des points test sur la projection app
points(x_test_ACP[classe_test==1,], col="red")
points(x_test_ACP[classe_test==2,], col="green")
points(x_test_ACP[classe_test==3,], col="blue")


# Analyse linéaire discriminante

x_app_ACP.lda<-lda(ScalarProduct_app,classe_app)
assigne_app<-predict(x_test_ACP.lda, newdata=ScalarProduct_test)
# Estimation des taux de bonnes classifications
table_classification_app <-table(classe_test, assigne_app$class)
# table of correct class vs. classification
diag(prop.table(table_classification_app, 1))
# total percent correct
taux_bonne_classif_app<-sum(diag(prop.table(table_classification_app)))

# couleur: les classes originales 
couleur_test<-rep("red",n_test) ;
couleur_test[classe_test==2]='green'
couleur_test[classe_test==3]='blue'

# forme: les classes d'assignation fournie par l'ALD
shape<-rep(1,n_test) ;
shape[assigne_test$class==2]=2;
shape[assigne_test$class==3]=3;


#plot(x_test,col=couleur_test,pch=shape,xlab = "X1", ylab = "X2")
