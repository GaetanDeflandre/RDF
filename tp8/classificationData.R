library("MASS")
library("lattice")
citation("mclust")


file='iris-tp8.RData'
load(file)

n_data <- 150

couleur<-rep('red',n_data)
couleur[iris2$species=='c']='blue'
couleur[iris2$species=='v']='green'

centre_init <- rbind(x[1,], x[51,], x[101,])

# run K-Means
it <- 5
for(i in 1:it) {
  
  print(paste("Iteration", i, sep = " "))
  
  km <- kmeans(x, 3, 15, centers=centre_init)

  shape<-rep(1,n_data)
  shape[km$cluster==2]=2
  shape[km$cluster==3]=3
  
  # Affiche plot
  plot(x_aff, col=couleur, pch=shape)
  
  # plot centers
  centers_aff <- cbind(km$centers[,2],km$centers[,4])
  points(centers_aff, col ='black', pch = 8)
  
  print("Centres des classes:")
  print(km$centers)
  
  error <- classError(km$cluster,iris2$species)
  print(paste("Taux d'erreur:", error$errorRate, sep = " "))
  
  print("--------------------------------")


  # moyennes des classes
  mean <- colMeans(x)
  mean1 <- colMeans(x[km$cluster==1,])
  mean2 <- colMeans(x[km$cluster==2,])
  mean3 <- colMeans(x[km$cluster==3,])
  
  # covariance intra-classe classe 1
  S1 <- cov(x[km$cluster==1,])
  S2 <- cov(x[km$cluster==2,])
  S3 <- cov(x[km$cluster==3,])
  
  Sw=S1+S2+S3
  # covariance inter-classe
  Sb=(mean1-mean)%*%t(mean1-mean)+
    (mean2-mean)%*%t(mean2-mean)+
    (mean3-mean)%*%t(mean3-mean)
  
  # Resolution equation
  invSw= solve(Sw)
  invSw_by_Sb= invSw %*% Sb
  Vp<- eigen(invSw_by_Sb)
  
  # Affichage de la droite correspondant au vecteur propre
  # dont la valeur propre la plus elevee
  pente <- Vp$vectors[2,1]/Vp$vectors[1,1]
  abline(a = 0, b = pente, col = "blue")
  
  #produit scalaire
  ScalarProduct <- x
  ScalarProduct <- x %*% (Vp$vectors[,1] / sqrt(sum(Vp$vectors[,1]*Vp$vectors[,1])))
  
  #projection des points
  x_ACP <- x
  x_ACP[,1] = ScalarProduct * Vp$vectors[1,1]
  x_ACP[,2] = ScalarProduct * Vp$vectors[2,1]
  
  #affichage des points projetes
  points(x_ACP[km$cluster==1,], col="red")
  points(x_ACP[km$cluster==2,], col="green")
  points(x_ACP[km$cluster==3,], col="blue")
}