library("MASS")
library("lattice")
library("EBImage")

source("imageUtils.R")

# Chargement d'une image
nomint <- "rdf-2-classes-texture-1.png"
nomtex <- "rdf-2-classes-texture-1-text.png"
imgint <- rdfReadGreyImage(nomint)
imgtex <- rdfReadGreyImage(nomtex)

if (interactive()) {
    #display(imgint, "image intensité")
    #display(imgtex, "image texture")
}



# Histogramme 2D
#nbins <- 256
#h2d <- rdfCalculeHistogramme2D(imgint, nbins, imgtex, nbins);
#if (interactive ()) {
    #display (h2d, "histogramme 2D")
#}

#nbcol = length(h2d[,1])
#nbrow = length(h2d[1,])

#listx <- c()
#listy <- c()

#for (y in 1:nbrow) {
#    for (x in 1:nbcol) {
#        if (h2d[x,y] != 0) {
#            listx <- c(listx,x)
#            listy <- c(listy,y)
#        }
#   }
#    print(paste((y/nbins)*100, '%', sep=" "));
#}

#points = cbind(listx,listy)

# K Means
#points <- cbind(as.vector(imgint),as.vector(imgtex))
#km <- kmeans(points, 2, 30)

# K Means solution alternative
points <- cbind(as.vector(imgint),as.vector(imgtex))
km <- kmeans(points, 2, 30)

# Affiche plot
couleur<-rep('cyan',length(points))
couleur[km$cluster==2]='orange'
plot(points, col=couleur)

# Plot centers
centers_aff <- cbind(km$centers[,1],km$centers[,2])
points(centers_aff, col ='black', pch = 8)

# Centres
c1 <- km$center[1,]
c2 <- km$center[2,]

# Distances pts centres
dc1 <- sqrt( (points[,1]- c1[1])*(points[,1]- c1[1]) + (points[,2]- c1[2])*(points[,2]- c1[2]))
dc2 <- sqrt( (points[,1]- c2[1])*(points[,1]- c2[1]) + (points[,2]- c2[2])*(points[,2]- c2[2]))

imgbin <- dc1 > dc2
imgbin <- matrix(imgbin,ncol=128)
if (interactive()) {
    display(imgbin, "image bin")
}

