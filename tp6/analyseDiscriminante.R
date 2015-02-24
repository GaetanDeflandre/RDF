library("MASS")
library("lattice")

(load(file='simul-2015.Rdata'))

couleur_app<-rep('red',n_app)
couleur_app[classe_app==2]='blue'
couleur_app[classe_app==3]='green'

plot(x_app, col = couleur_app)

couleur_test<-rep('red',n_test)
couleur_test[classe_test==2]='blue'
couleur_test[classe_test==3]='green'

plot(x_test, col = couleur_test, main="Les trois classes")

M1<-seq(1,2)
M2<-seq(1,2)
M3<-seq(1,2)

M1[1] = mean(x_app[classe_app==1,1])
M1[2] = mean(x_app[classe_app==1,2])

M2[1] = mean(x_app[classe_app==2,1])
M2[2] = mean(x_app[classe_app==2,2])

M3[1] = mean(x_app[classe_app==3,1])
M3[2] = mean(x_app[classe_app==3,2])

print("MOYENNE APPRENTISSAGE:")
print(paste("Rouge -> Moy att1: ", M1[1], ""))
print(paste("Rouge -> Moy att2: ", M1[2], ""))
print("")
print(paste("Bleu  -> Moy att1: ", M2[1], ""))
print(paste("Bleu  -> Moy att2: ", M2[2], ""))
print("")
print(paste("Vert  -> Moy att1: ", M3[1], ""))
print(paste("Vert  -> Moy att2: ", M3[2], ""))
print("")

M1<-seq(1,2)
M2<-seq(1,2)
M3<-seq(1,2)

M1[1] = mean(x_test[classe_test==1,1])
M1[2] = mean(x_test[classe_test==1,2])

M2[1] = mean(x_test[classe_test==2,1])
M2[2] = mean(x_test[classe_test==2,2])

M3[1] = mean(x_test[classe_test==3,1])
M3[2] = mean(x_test[classe_test==3,2])

print("MOYENNE TESTE:")
print(paste("Rouge -> Moy att1: ", M1[1], ""))
print(paste("Rouge -> Moy att2: ", M1[2], ""))
print("")
print(paste("Bleu  -> Moy att1: ", M2[1], ""))
print(paste("Bleu  -> Moy att2: ", M2[2], ""))
print("")
print(paste("Vert  -> Moy att1: ", M3[1], ""))
print(paste("Vert  -> Moy att2: ", M3[2], ""))
print("")


Sigma1<-matrix(1,2,2)
Sigma2<-matrix(1,2,2)
Sigma3<-matrix(1,2,2)
s<-matrix(1,2,2)

for(i in 1:2){
    for(j in 1:2){
        Sigma1[i,j]=cov(as.vector(x_app[classe_app==1,i]),as.vector(x_app[classe_app==1,j]))
        Sigma2[i,j]=cov(as.vector(x_app[classe_app==2,i]),as.vector(x_app[classe_app==2,j]))
        Sigma3[i,j]=cov(as.vector(x_app[classe_app==3,i]),as.vector(x_app[classe_app==3,j]))
        s[i,j]=cov(as.vector(x_app[classe_app,i]),as.vector(x_app[classe_app,j]))
    }
}

print("CO-VARIANCE APPRENTISSAGE:")
print("Co-variance 1: classe rouge")
print(Sigma1)
print("")
print("Co-variance 2: classe bleue")
print(Sigma2)
print("")
print("Co-variance 2: classe verte")
print(Sigma3)
print("")
print("Co-variance  : image")
print(s)
print("")


# LINEAURE

# Grille d'estimation de la densitée de probabilitée en 50 intervalles selon 1er attribut
xp1<-seq(min(x_app[,1]),max(x_app[,1]),length=50)

# Grille d'estimation de la densitée de probabilitée en 50 intervalles selon 2eme attribut
xp2<-seq(min(x_app[,2]),max(x_app[,2]),length=50)

grille<-expand.grid(x1=xp1,x2=xp2)

x_app.lda<-lda(x_app,classe_app)
grille = cbind(grille[,1], grille[,2])
Zp<-predict(x_app.lda,grille)
assigne_test<-predict(x_app.lda, newdata=x_test)

# Estimation des taux de bonnes classifications
table_classification_test <-table(classe_test, assigne_test$class)

# table of correct class vs. classification
diag(prop.table(table_classification_test, 1))

# total percent correct
taux_bonne_classif_test <-sum(diag(prop.table(table_classification_test)))
print(paste("LDA taux_bonne_classif_test: ", taux_bonne_classif_test, ""))


#########################

# Création du vecteur contenant le code de la forme des données test assignées aux classes # - code initialisé a 1
shape<-rep(1,n_test);
# forme des donnees assignees a la classe 2
shape[assigne_test$class==2]=2;
shape[assigne_test$class==3]=3;
# Affichage avec code couleur et forme adaptees
plot(x_test,col=couleur_test,pch=shape,xlab = "X1", ylab = "X2")

xp1<-seq(min(x_app[,1]),max(x_app[,1]),length=50)
xp2<-seq(min(x_app[,2]),max(x_app[,2]),length=50)
grille<-expand.grid(x1=xp1,x2=xp2)
grille=cbind(grille[,1],grille[,2])
Zp<-predict(x_app.lda,grille)
zp<-Zp$post[,3]-pmax(Zp$post[,2],Zp$post[,1])
contour(xp1,xp2,matrix(zp,50),add=TRUE,levels=0,drawlabels=FALSE)

zp2<-Zp$post[,2]-pmax(Zp$post[,3],Zp$post[,1])
contour(xp1,xp2,matrix(zp2,50),add=TRUE,levels=0,drawlabels=FALSE)

print("")



# QUADRATIQUE

# Grille d'estimation de la densitée de probabilitée en 50 intervalles selon 1er attribut
xp1<-seq(min(x_app[,1]),max(x_app[,1]),length=50)

# Grille d'estimation de la densitée de probabilitée en 50 intervalles selon 2eme attribut
xp2<-seq(min(x_app[,2]),max(x_app[,2]),length=50)

grille<-expand.grid(x1=xp1,x2=xp2)

x_app.qda<-qda(x_app,classe_app)
grille = cbind(grille[,1], grille[,2])
Zp<-predict(x_app.qda,grille)
assigne_test<-predict(x_app.qda, newdata=x_test)

# Estimation des taux de bonnes classifications
table_classification_test <-table(classe_test, assigne_test$class)

# table of correct class vs. classification
diag(prop.table(table_classification_test, 1))

# total percent correct
taux_bonne_classif_test <-sum(diag(prop.table(table_classification_test)))
print(paste("QDA taux_bonne_classif_test: ", taux_bonne_classif_test, ""))


#########################

# Création du vecteur contenant le code de la forme des données test assignées aux classes # - code initialisé a 1
shape<-rep(1,n_test);
# forme des donnees assignees a la classe 2
shape[assigne_test$class==2]=2;
shape[assigne_test$class==3]=3;
# Affichage avec code couleur et forme adaptees
plot(x_test,col=couleur_test,pch=shape,xlab = "X1", ylab = "X2")

xp1<-seq(min(x_app[,1]),max(x_app[,1]),length=50)
xp2<-seq(min(x_app[,2]),max(x_app[,2]),length=50)
grille<-expand.grid(x1=xp1,x2=xp2)
grille=cbind(grille[,1],grille[,2])
Zp<-predict(x_app.qda,grille)
zp<-Zp$post[,3]-pmax(Zp$post[,2],Zp$post[,1])
contour(xp1,xp2,matrix(zp,50),add=TRUE,levels=0,drawlabels=FALSE)

zp2<-Zp$post[,2]-pmax(Zp$post[,3],Zp$post[,1])
contour(xp1,xp2,matrix(zp2,50),add=TRUE,levels=0,drawlabels=FALSE)

print("")



