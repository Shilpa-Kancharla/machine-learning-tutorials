---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
#QUESTION 3, PART A
set.seed(12)
X0 <- matrix(c(1, 2, -1, 2, 2, -1, 2, 1), nrow=4, ncol=2, byrow = TRUE)
center_operator <- function(x) {
  n = nrow(x)
  ones = rep(1, n)
  H = diag(n) - (1/n)*(ones %*% t(ones))
  H %*% x
}

X <- center_operator(X0)
X
```
```{r}
#QUESTION 3, PART B
svd(X)
#Calculating PCs
V <- matrix(c(-0.7071068, 0.7071068, -0.7071068, -0.7071068), nrow = 2, ncol = 2, byrow = TRUE)
Z <- X %*% V
Z
#Getting PC Loadings
V
```
```{r}
#QUESTION 3, PART C
X1 <- t(X) %*% X
ev <- eigen(X1)
values <- ev$values
vectors <- ev$vectors
values 
vectors
#Calculating eigenvectors and eigenvalues
D <- c(3.162278, 1.414214)
D^2 #eigenvalues
```
```{r}
#QUESTION 3, PART D
require(graphics)
pairs(X0, panel = panel.smooth)
pc.out <- prcomp(X0, scale = TRUE, retx = TRUE)
pc.out$x
plot(pc.out$x[,1], pc.out$x[,2], type = "n", xlab = "1st PC", ylab = "2nd PC")
text(pc.out$x[,1], pc.out$x[,2])
pc.out$center #means of PC loadings
pc.out$scale #standard deviations of PC loadings
dim(pc.out$x)
pc.out$sdev
pc.var <- pc.out$sdev^2
pc.var
pve <- pc.var/sum(pc.var)
pve
plot(pve, xlab = "Principal Component", ylab = "Proportion of Variance Explained", ylim = c(0,1), type = 'b')
```
```{r}
#QUESTION 3, PART E
pc.out$rotation #provides PC loadings
biplot(pc.out, scale = 0)
U <- matrix(c(0.2236068, -0.5, 0.6708204,  0.5, -0.6708204,  0.5, -0.2236068, -0.5), nrow=4, ncol=2, byrow = TRUE)
plot(U[,1], U[,2])
```
```{r}
#QUESTION 3, PART F
D <- matrix(c(3.162278, 1.414214), nrow = 2, ncol = 1, byrow = TRUE)
D^2
D^2/sum(D^2)
```
```{r}
#QUESTION 3, PART G
X0_1 <- matrix(c(1, 20, -1, 20, 2, -10, 2, 10), nrow=4, ncol=2, byrow = TRUE)
center_operator <- function(x) {
  n = nrow(x)
  ones = rep(1, n)
  H = diag(n) - (1/n)*(ones %*% t(ones))
  H %*% x
}

X2 <- center_operator(X0_1)
X2
svd(X2)
X_2 <- t(X2) %*% X2
eigen(X_2)
pc.out1 <- prcomp(X0_1, scale = TRUE, retx = TRUE)
pc.out1
pc.out1$sdev
pc.var1 <- pc.out$sdev^2
pc.var1
pve1 <- pc.var1/sum(pc.var1)
pve1
plot(pve1, xlab = "Principal Component", ylab = "Proportion of Variance Explained", ylim = c(0,1), type = 'b')
biplot(pc.out1)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

