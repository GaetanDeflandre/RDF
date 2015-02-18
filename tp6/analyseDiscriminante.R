(load(file='simul-2015.Rdata'))

couleur<-rep('red',n_app)
couleur[classe_app==2]='blue'
couleur[classe_app==3]='green'

plot(x_app, col = couleur)

couleur<-rep('red',n_test)
couleur[classe_test==2]='blue'
couleur[classe_test==3]='green'

plot(x_test, col = couleur, main="Les trois classes")

M1<-seq(1,2)
M2<-seq(1,2)
M3<-seq(1,2)

M1[1] = mean(x_app[classe_app==1,1])
M1[2] = mean(x_app[classe_app==1,2])

M2[1] = mean(x_app[classe_app==2,1])
M2[2] = mean(x_app[classe_app==2,2])

M3[1] = mean(x_app[classe_app==3,1])
M3[2] = mean(x_app[classe_app==3,2])

print("MOYENNE:")
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

print("CO-VARIANCE:")
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
