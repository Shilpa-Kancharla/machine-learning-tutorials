---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
#RIDGE REGRESSION
library(ISLR)
library(leaps)
x=model.matrix(Salary~.,Hitters)[,-1]
y=Hitters$Salary
library(glmnet) #by default, this function performs ridge regression for an automatrically selected range for lambda values, however, we have chosen some of them below defined as grid. glmnet will also standardize all functions by default.
grid=10^seq(10, -2, length=100)
ridge.mod=glmnet(x,y,alpha=0, lambda=grid)
dim(coef(ridge.mod))
ridge.mod$lambda[50]
coef(ridge.mod)[,50]
sqrt(sum(coef(ridge.mod)[-1,50]^2))
```
```{r}
ridge.mod$lambda[60]
coef(ridge.mod)[,60]
sqrt(sum(coef(ridge.mod)[-1,60]^2))
```
```{r}
predict(ridge.mod, s=50, type="coefficients")[1:20,]
```
```{r}
set.seed(1)
train=sample(1:nrow(x), nrow(x)/2)
test=(-train)
y.test=y[test]
ridge.mod=glmnet(x[train,],y[train], alpha=0, lambda=grid, thresh=1e-12)
ridge.pred=predict(ridge.mod, s=4, newx=x[test,])
mean((ridge.pred-y.test)^2)
mean((mean(y[train])-y.test)^2)
ridge.pred=predict(ridge.mod,s=1e10, newx=x[test,])
mean((ridge.pred-y.test)^2)
ridge.pred=predict(ridge.mod,s=0, newx=x[test,])
mean((ridge.pred-y.test)^2)
lm(y~x, subset=train)
predict(ridge.mod, s=0, exact=T, type="coefficients")[1:20,]
```
```{r}
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train], alpha=0) #built-in cross validation function
plot(cv.out)
bestlam=cv.out$lambda.min
bestlam
```
```{r}
ridge.pred=predict(ridge.mod, s=bestlam, newx=x[test,])
mean((ridge.pred-y.test)^2)
out=glmnet(x,y,alpha=0)
predict(out, type="coefficients", s=bestlam)[1:20,]
```
```{r}
#LASSO
lasso.mod=glmnet(x[train,], y[train], alpha=1, lambda=grid)
plot(lasso.mod) #From the plot, depending on the choice of the tuning parameter, some coefficients may be exactly equal to zero
set.seed(1)
cv.out=cv.glmnet(x[train,],y[train], alpha=1)
plot(cv.out)
bestlam=cv.out$lambda.min
lasso.pred=predict(lasso.mod, s=bestlam, newx=x[test,])
mean((lasso.pred-y.test)^2)
```
```{r}
out=glmnet(x,y,alpha=1, lambda=grid)
lasso.coef=predict(out, type="coefficients", s=bestlam)[1:20,]
lasso.coef
lasso.coef[lasso.coef!=0]
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

