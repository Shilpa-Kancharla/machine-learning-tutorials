---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
X1 <- c(3,2,4,1,2,4,4)
X2 <- c(4,2,4,4,1,3,1)
Y <- c(rep("RED", 4), rep("BLUE", 3))
mydf <- data.frame(X1, X2, Y)
plot(X1, X2, col=Y, pch=19, data=mydf)
```
```{r}
library(e1071)
fit.svm = svm(Y~., data=mydf, kernel="linear", cost=10, scale=FALSE)
#Extract beta0 and beta1
beta0 = fit.svm$rho
beta = drop(t(fit.svm$coefs) %*% as.matrix(mydf[fit.svm$index, 1:2]))
#Replot, this time with the solid line representing the maximal margin plane
plot(X1, X2, col=Y, pch=19, data=mydf)
abline(beta0/beta[2], -beta[1]/beta[2])
paste("Intercept:", round(beta0/beta[2],1), ", Slope:", round(-beta[1]/beta[2],1), sep="")
```
```{r}
#Replot, this time with the dashed lines representing the margins for this maximal margin hyperplane.
plot(X1, X2, col=Y, pch=19, data=mydf)
abline(beta0/beta[2], -beta[1]/beta[2])
abline((beta0 - 1)/beta[2], -beta[1]/beta[2], lty = 2)
abline((beta0 + 1)/beta[2], -beta[1]/beta[2], lty = 2)
```
```{r}
#Replot, this time indicating the support vectors for the maximal margin classifier
plot(X1, X2, col=Y, pch=19, data=mydf, main="All Support Vectors")
abline(beta0/beta[2], -beta[1]/beta[2])
abline((beta0 - 1)/beta[2], -beta[1]/beta[2], lty = 2)
abline((beta0 + 1)/beta[2], -beta[1]/beta[2], lty = 2)
points(mydf[fit.svm$index,], pch = 5, cex = 2)
points(2,1, pch = 5, cex = 2)
```
```{r}
#Replot, this time with random separating hyperplane.
plot(X1, X2, col=Y, pch=19, data=mydf)
abline(-1.5, 1.3, col="blue",lwd=2)
```
```{r}
# Replot, this time indicating the support vectors for the maximal margin classifier.
plot(X1, X2, col=Y, pch=19, data=mydf)
points(2.5, 3, col="blue", pch=19)
points(2.5, 3, col="blue", pch=5, cex=2)
abline(0,1, col="grey", lty=2)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

