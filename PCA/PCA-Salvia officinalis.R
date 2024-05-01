#PCA for Salvia officinalis herb

#load required packages
library(extrafont) 
fonts()
library(pheatmap)
library("readxl")
library(ggplot2)
library(FactoMineR)
library(factoextra)
library(extrafont)
library(ggtext)

#read data
df<- read.table("I://Data-Science-2024//PCA//data3.txt")

#Conduct PCA
df<-scale(df)

pca3 <- PCA(df)
pca3$eig
pca3$var$coord
pca3$var

#visualizing the result

my.col.var <- c("#0099FF", "green", "#FF00FF", "#0099FF", "green", "green",
"#FF00FF", "#FF3300", "#0099FF", "#0099FF", "#FF00FF", "#FF00FF",
"#0099FF", "#FF00FF", "#FF00FF", "#FF00FF", "#FF00FF", "#FF00FF")

base_fig<- fviz_pca_biplot(pca3, repel = TRUE,  
ylab = paste0("PC2 (", 22.6, "% )" ),
xlab = paste0("PC1 (", 62.1, "% )" ),
geom = c("point", "text"),axes = c(1, 2), 
col.var = c("Ferulic","Caffeic","Hesperidin","Rosmarinic",
"Quercetin","Kaemferol", "Luteolin","Apigenin", 
"EL", "DPPH", "TFC", "TPC", 
"PAL gene", "PAL activity", "Chla", "Chlb", "Car", "Biomass"
),  title = "", palette = my.col.var
)

windowsFonts(Times=windowsFont("Times New Roman"))

base_fig<- base_fig +
  theme(text = element_text(size=14))

base_fig<- base_fig +
            theme(text=element_text(family="Times", size=16))

base_fig<- base_fig+ theme(plot.background = element_rect(fill = "#f7f7f7"))


base_fig +  theme(panel.grid = element_blank(), 
          
           panel.border = element_rect(fill= "transparent"))


#heatmap

p <- pheatmap(df,scale = "column",clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean")



