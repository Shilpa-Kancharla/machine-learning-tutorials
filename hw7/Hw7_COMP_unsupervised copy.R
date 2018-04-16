---
title: "STOR 565 Spring 2018 Homework 7"
author: "Shilpa Kancharla"
output:
  pdf_document: default
  html_document: default
subtitle: \textbf{Due on 04/16/2018 in Class}
header-includes: \usepackage{amsgen,amsmath,amstext,amsbsy,amsopn,amssymb,mathabx,amsthm,bm,bbm}
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
\theoremstyle{definition}
\newtheorem*{hint}{Hint}

\theoremstyle{remark}
\newtheorem*{rmk}{Remark}

*Remark.* Credits for **Theoretical Part** and **Computational Part** are in total *105 pt*. At most *100 pt* can be earned. For **Computational Part**, please complete your report in the **RMarkdown** file and submit your printed PDF homework created by it.

## Computational Part

>> **You are supposed to finish the Computational Part in a readable report manner for each dataset-based analysis problem. Other than what you are asked to do, you can decide any details on your own discretion.**

**Note.** Read Section 10.4-10.6 in Textbook before getting started.

1. (Hierarchical Clustering, Textbook 10.9, *15 pt*) Consider the `USArrests` data. We will now perform hierarchical clustering on the states. Write a data analysis report to address the following problems.

    (a) Using hierarchical clustering with complete linkage and Euclidean distance, cluster the states.
```{r}
library(ISLR)
set.seed(1)
hc.states <- hclust(dist(USArrests), method="complete")
plot(hc.states)
```
    
    (b) Cut the dendrogram at a height that results in three distinct clusters. Which states belong to which clusters?
```{r}
cutree(hc.states, 3)
table(cutree(hc.states, 3))
```
In Cluster 1, we have Alabama, Alaska, Arizona, California, Delaware, Florida, Illinois, Louisiana, Maryland, Michigan, Mississippi, Nevada, New Mexico, New York, North Carolina and South Carolina. Cluster 2 contains Arkansas, Colorado, Georgia, Massechusetts, Missouri, New Jersey, Oklahoma, Oregon, Rhode Island, Tennessee, Texas, Virginia, Washington and Wyoming. Cluster 3 has Connecticut, Hawaii, Idaho, Indiana, Iowa, Kansas, Kentucky, Maine, Minnesota, Montana, Nebraska, New Hampshire, North Dakota, Ohio, Pennsylvania, South Dakota, Utah, Vermont, West Virginia and Wisconsin.

    (c) Hierarchically cluster the states using complete linkage and Euclidean distance, after scaling the variables to have standard deviation one.
```{r}
cluster.scale <- scale(USArrests)
hc.scale.states <- hclust(dist(cluster.scale), method="complete")
plot(hc.scale.states)
```

    (d) What effect does scaling the variables have on the hierarchical clustering obtained? In your opinion, should the variables be scaled before the inter-observation dissimilarities are computed? Provide a justification for your answer.
```{r}
cutree(hc.scale.states, 3)
table(cutree(hc.scale.states, 3))
table(cutree(hc.scale.states, 3), cutree(hc.states, 3))
```
Scaling the variables will affect the maximum height of the dendrogram obtained from hierarchical clustering. From an initial glance, it does not seem to affect the bushiness of the tree obtained. However, it does affect the clusters obtained from cutting the dendrogram into 3 clusters. For this data set specifically, I believe that the data should be standardized because some of the data components have different units.
***

2. ($K$-Means Clustering, PCA and MDS, *35 pt*) The following codes read in a gene expression data from the TCGA project, which contains the expression of a random sample of 2000 genes for 563 patients from three cancer subtypes: Basal (`Basal`), Luminal A (`LumA`), and Luminal B (`LumB`). Suppose we are only interested in distinguishing Luminal A samples from Luminal B - but alas, we also have Basal samples, and we don't know which is which. Write a data analysis report to address the following problems.

    ```{r}
    TCGA <- read.csv("TCGA_sample_2.txt", header = TRUE)
    
    # Store the subtypes of tissue and the gene expression data
    Subtypes <- TCGA[ ,1]
    Gene <- as.matrix(TCGA[,-1])
    ```

    (a) Run $K$-means for $K$ from 1 to 20 and plot the associated within cluster sum of squares (WSSs). Comment the WSS at $K=3$.
```{r}
set.seed(2)
#tcga.drop <- subset(TCGA, select = -c(subs))
#tcga.fixed <- na.omit(tcga.drop)

wssplot <- function(Gene, nc=20, seed=1234){
  wss <- (nrow(Gene) - 1)*sum(apply(Gene, 2, var))
  for (i in 1:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(Gene, centers = i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Numer of Clusters", ylab="Within groups sum of squares")
}

wssplot(Gene, nc=20)
```
When K=3, that is the optimal K value.

    (b) Apply $K$-means with $K=3$ to the `Gene` dataset. What percentage of `Basal`, `LumA`, and `LumB` type samples are in each of the 3 resulting clusters? Did we do a good job distinguishing `LumA` from `LumB`? Confusion matrix of clusters versus subtypes might be helpful.
```{r}
km.out <- kmeans(Gene, 3, nstart = 20)
plot(Gene, col = (km.out$cluster+1), main = "K-Means Clustering Results with K=3", xlab = "", ylab = "", pch = 20, cex = 2)
table(Subtypes, km.out$cluster)
```
We did not do a good job distinguishing between LumA and LumB. Basal has an accuracy of 99.02%, LumA has an accuracy of 37.86%, and finally LumB has an accuracy of 17.76%. The overall accuracy is 43.52%.    

    (c) Now apply PCA to the `Gene` dataset. Plot the data in the first two PCs colored by `Subtypes`. Does this plot appear to separate the cancer subtypes well?
```{r}
which(apply(Gene, 2, var)==0)
Gene <- Gene[ , apply(Gene, 2, var) != 0]
pc.out <- prcomp(Gene, scale. = TRUE, retx = TRUE) #applying PCA to the `Gene` dataset
PC1 <- pc.out$rotation[,1]
PC2 <- pc.out$rotation[,2]
plot(PC1, PC2)
```
This plot does not seem to separate the cancer subtypes well. 
    
    (d) Try plotting some more PC combinations. Can you find a pair of PCs that appear to separate all three subtypes well? Report the scatterplot of the data for pair of PCs that you think best separates all three types.
```{r}
library(ggfortify)
autoplot(prcomp(Gene), data = TCGA, colour = "subs", label = TRUE)
```
    
    (e) Perform $K$-means with $K=3$ on the pair of PCs identified in (d). Report the confusion matrix and make some comments.
    
    (f) Create two plots colored by the clusters found in (b) and in (d) respectively. Do they look similarly or differently? Explain why using PCA to reduce the number of dimensions from 2000 to 2 did not significantly change the results of $K$-means.
```{r}
```
    
    (g) Now apply MDS with various metrics and non-metric MDS to `Gene` to obtain 2-dimensional representations. Does any of them provide better separated scatterplot as compared to that from (d)? Notice that the Euclidean metric in MDS gives the same representation as PCA does.
```{r}
```
    
    
    (h) Perform $K$-means with $K=3$ on the new representations from (g) and report the confusion matrices. Compare them with that from (e).
    
    (i) Suppose we might know that the first PC contains information we aren't interested in.  Apply $K$-means with $K=3$ to `Gene` dataset **subtracting the approximation from the first PC**. Report the confusion matrix and make some comments.