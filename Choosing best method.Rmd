---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
#Choosing among models using validation set approach and cross validation
library(ISLR)
library(leaps)
#Splitting into training and test sets. Create a random vector, train, of elements equal to TRUE if the corresponding observation is in the training set, and FALSE otherwise. 
set.seed(1)
train=sample(c(TRUE, FALSE), nrow(Hitters), rep=TRUE)
test=(!train)
regfit.best=regsubsets(Salary~., data=Hitters[train,], nvmax=19) #access data only in training set
test.mat=model.matrix(Salary~., data=Hitters[test,]) #model.matrix() function is used in many regression packages for building an "X" matrix from data. Now we run a loop, and for each size i, we extract the coefficienets from regfit.best for the best model of that size, multiply them into the appropriate columsn of the test model matrix to form the predictions, and compute the test MSE.
val.errors=rep(NA, 19)
for(i in 1:19){
  coefi=coef(regfit.best, id=i)
  pred=test.mat[,names(coefi)]%*%coefi
  val.errors[i]=mean((Hitters$Salary[test]-pred)^2)
}
val.errors
which.min(val.errors) #Best model that contains 10 variables
coef(regfit.best, 10)
```
```{r}
#writing our own predict method
predict.regsubsets=function(object,newdata,id,...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form, newdata)
  coefi=coef(object, id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}
regfit.best=regsubsets(Salary~., data=Hitters, nvmax=19)
coef(regfit.best,10)
```
```{r}
#cross validation within each of the k training sets
k=10
set.seed(1)
folds=sample(1:k,nrow(Hitters), replace=TRUE)
cv.errors=matrix(NA, k, 19, dimnames=list(NULL, paste(1:19)))
for(j in 1:k){
  best.fit=regsubsets(Salary~.,data=Hitters[folds != j,], nvmax=19)
  for(i in 1:19){
    pred=predict(best.fit, Hitters[folds==j,], id=i)
    cv.errors[j,i]=mean((Hitters$Salary[folds==j]-pred)^2)
  }
}
mean.cv.errors=apply(cv.errors,2,mean)
mean.cv.errors
par(mfrow=c(1,1))
plot(mean.cv.errors, type="b")
```
```{r}
reg.best=regsubsets(Salary~.,data=Hitters, nvmax=19)
coef(reg.best,11)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

