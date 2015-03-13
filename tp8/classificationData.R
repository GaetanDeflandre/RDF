library("MASS")
library("lattice")


file='iris-tp8.RData'
load(file)

n_data <- 150

couleur<-rep('red',n_data)
couleur[iris2$species=='c']='blue'
couleur[iris2$species=='v']='green'

# run K-Means
km <- kmeans(x_aff, 3, 15)

shape<-rep(1,n_data)
shape[km$cluster==2]=2
shape[km$cluster==3]=3

# Affiche plot
plot(x_aff, col=couleur, pch=shape)

# plot centers
centers_aff <- cbind(km$centers[,2],km$centers[,4])
points(centers_aff, col ='black', pch = 8)
