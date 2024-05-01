
#PCA for Covid-19

#load required packages

library("readxl")
library(ggplot2)
library(FactoMineR)
library(factoextra)

#read data

df <- data.frame(read_excel("I:/Data-Science-2024/PCA/Covid19.xls", sheet = 2))
df <- subset (df, select = -Death)
ID<-df$ID
df1<-as.data.frame(ID)
df <- df[,!colnames(df) %in% 'ID']
#Conduct PCA
df<-scale(df)
pca3 <- PCA(df)
pca3$eig
pca3$var$coord


#visualizing the result

fviz_pca_biplot(pca3, ylab = paste0("Component 1 (", 70.98, "% )" ),xlab = paste0("Component 2 (", 29.01, "% )" ))

#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## K-means clustring


# Elbow method
fviz_nbclust(df, kmeans, method = "wss") +
  geom_vline(xintercept = 3, linetype = 2)+
  labs(subtitle = "Elbow method")

# Perform k-means clustring

library(ggpubr)
res.km <- kmeans(df, 3, nstart = 25)
res.pca <- PCA(df)
ind.coord <- as.data.frame(get_pca_ind(res.pca)$coord)
df1$cluster<-factor(res.km$cluster)
# Add clusters obtained using the K-means algorithm

ind.coord$cluster <- factor(res.km$cluster)
km.res <- kmeans(ind.coord, 3, nstart = 25)
km.res$cluster
data1 <- get_pca_ind(res.pca)$coord

fviz_cluster(km.res, data1, ellipse.type = "norm")
