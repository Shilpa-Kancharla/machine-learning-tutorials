---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
#BEST SUBSET SELECTION

library(ISLR)
names(Hitters)
#Redefine vector with leaving out empty values
Hitters=na.omit(Hitters)
dim(Hitters)
sum(is.na(Hitters))
```
```{r}
library(leaps)
regfit.full = regsubsets(Salary~., Hitters)
summary(regfit.full) #An asterisks indicates that a given variable is included in the corresponding model. This output indicates that the best two variable models contains only Hits & CRBI. regsubsets() only reports results up to the best eight variable model. 
```
```{r}
regfit.full=regsubsets(Salary~.,data=Hitters, nvmax=19) #returns as many variables as are desired
reg.summary=summary(regfit.full)
names(reg.summary)
reg.summary$rsq
```
```{r}
par(mfrow=c(2,2))
plot(reg.summary$rss, xlab="Number of Variables", ylab="RSS", type="l")
plot(reg.summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq", type="l")
which.max(reg.summary$adjr2)
points(11, reg.summary$adjr2[11], col="red", cex=2, pch=20)
```
```{r}
par(mfrow=c(2,2))
plot(reg.summary$cp, xlab="Number of Variables", ylab="Cp", type="l")
which.min(reg.summary$cp)
points(10, reg.summary$cp[10], col="red", cex=2, pch=20)
which.min(reg.summary$bic)
plot(reg.summary$bic, xlab="Number of Variables", ylab="BIC", type="l")
points(6, reg.summary$bic[6], col="red", cex=2, pch=20)
```
```{r}
plot(regfit.full, scale="r2")
plot(regfit.full, scale="adjr2")
plot(regfit.full, scale="Cp")
plot(regfit.full, scale="bic")
coef(regfit.full,6)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

