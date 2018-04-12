---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
#QUESTION 1, PART A
distance <- as.dist(matrix(c(0, 0.3, 0.4, 0.7, 0.3, 0, 0.5, 0.8, 
                             0.4, 0.5, 0, 0.45, 0.7, 0.8, 0.45, 0), nrow=4))
plot(hclust(distance, method="complete"), xlab="Observations", main="Complete Linkage")
arrows(1.8, .4, 1.55, .32, length=.1)
text(2.2, .42, "Fusion at 0.3", col="green")
arrows(3.2, .55, 3.45, .47, length=.1)
text(2.8, .57, "Fusion at 0.45", col="blue")
arrows(2.5, .7, 2.5, .79, length = .1)
text(2.5, .67, "Fusion at 0.8", col="red")
```
```{r}
#QUESTION 2, PART B
distance <- as.dist(matrix(c(0, 0.3, 0.4, 0.7, 0.3, 0, 0.5, 0.8,
                             0.4, 0.5, 0, 0.45, 0.7, 0.8, 0.45, 0), nrow =4))
plot(hclust(distance, method = "single"), xlab="Observations", main="Single Linkage")
arrows(3.05, .43, 2.8, .405, length=.1)
text(3.45, .44, "Fusion at 0.4", col="green")
arrows(3.2, .33, 3.45, .305, length=.1)
text(2.8, .34, "Fusion at 0.3", col="blue")
arrows(1.7, .42, 1.9, .445, length=.1)
text(1.5, .41, "Fusion at 0.45", col="red")
```
```{r}
#QUESTION 1, PART E
par(mfrow=c(1,2))
distance.1 <- as.dist(matrix(c(0, 0.3, 0.4, 0.7, 0.3, 0, 0.5, 0.8,
                               0.4, 0.5, 0, 0.45, 0.7, 0.8, 0.45, 0), nrow = 4))
plot(hclust(distance.1, method="complete"), xlab="Observations", main="Original (a)")

distance.2 <- matrix(c(0, 0.3, 0.4, 0.7, 0.3, 0, 0.5, 0.8,
                       0.4, 0.5, 0, 0.45, 0.7, 0.8, 0.45, 0), nrow = 4)
rownames(distance.2) <- c(2, 1, 4, 3)
distance.2 <- as.dist(distance.2)
plot(hclust(distance.2, method = "complete"), xlab="Observations", main="Repositioned Leaves")
```
```{r}
#QUESTION 2, PART A
X <- cbind(c(1, 1, 0, 5, 6, 4), c(4, 3, 4, 1, 2, 0))
plot(X[,1], X[,2])
```
```{r}
set.seed(1)
labels <- sample(2, nrow(X), replace=T)
labels
plot(X[,1], X[,2], col = (labels + 1), pch = 20, cex = 2)
```
```{r}
#QUESTION 2, PART C
centroid.1 <- c(mean(X[labels == 1, 1]), mean(X[labels == 1, 2]))
centroid.2 <- c(mean(X[labels == 2, 1]), mean(X[labels == 2, 2]))
plot(X[,1], X[,2], col=(labels + 1), pch = 20, cex = 2)
points(centroid.1[1], centroid.1[2], col = 2, pch = 4)
points(centroid.2[1], centroid.2[2], col = 3, pch = 4)
```
```{r}
#QUESTION 2, PART D
labels <- c(1, 1, 1, 2, 2, 2)
plot(X[,1], X[,2], col = (labels + 1), pch = 20, cex = 2)
points(centroid.1[1], centroid.1[2], col = 2, pch = 4)
points(centroid.2[1], centroid.2[2], col = 3, pch = 4)
```
```{r}
#QUESTION 2, PART E
centroid.1 <- c(mean(X[labels == 1, 1]), mean(X[labels == 1,2]))
centroid.2 <- c(mean(X[labels == 2, 1]), mean(X[labels == 2,2]))
plot(X[,1], X[,2], col=(labels + 1), pch = 20, cex = 2)
points(centroid.1[1], centroid.1[2], col = 2, pch = 4)
points(centroid.2[1], centroid.2[2], col = 3, pch = 4)
```
```{r}
#QUESTION 2, PART F
plot(X[,1], X[,2], col = (labels + 1), pch = 20, cex =2)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

