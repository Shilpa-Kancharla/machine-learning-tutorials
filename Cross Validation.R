---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
#Validation Set Approach, using Auto dataset
library(ISLR)
set.seed(1) #random number generator
train = sample(392,196) #split the set of observations into two halves using sample(), select a random subset of 196 observations out of the original 392 observations
lm.fit = lm(mpg~horsepower, data=Auto, subset=train)
attach(Auto)
mean((mpg-predict(lm.fit, Auto))[-train]^2) #use predict() function to estimate the response for all 392 observations, and we use mean() function to calculate the MSE of the 196 observations in the validation set; -train index below selects only the observations that are in the training set
```
```{r}
#MSE is for linear regression is 26.14. Use poly() function to estimate the test error for the quadratic and cubic regressions
lm.fit2 = lm(mpg~poly(horsepower,2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2)
```
```{r}
lm.fit3 = lm(mpg~poly(horsepower,3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2)
```
```{r}
#These error rates are 19.82 and 19.78 respectively. If we choose a different training set instead, then we will obtain somewhat different errors on the validation set.
set.seed(2)
train = sample(392,196)
lm.fit = lm(mpg~horsepower, subset = train)
mean((mpg-predict(lm.fit,Auto))[-train]^2)
lm.fit2 = lm(mpg~poly(horsepower,2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2,Auto))[-train]^2)
lm.fit3 = lm(mpg~poly(horsepower,3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3,Auto))[-train]^2)
```
```{r}
#Results consistent with fitting using quadratic

#LOOCV
glm.fit=glm(mpg~horsepower, data=Auto)
coef(glm.fit)
```
```{r}
lm.fit=lm(mpg~horsepower, data=Auto)
coef(lm.fit)
```
```{r}
library(boot)
glm.fit=glm(mpg~horsepower, data=Auto)
cv.err=cv.glm(Auto, glm.fit)
cv.err$delta
```
```{r}
#K-fold CV
set.seed(17)
cv.error.10=rep(0,10)
for (i in 1:10){
  glm.fit=glm(mpg~poly(horsepower, i), data=Auto)
  cv.error.10[i]=cv.glm(Auto,glm.fit,K=10)$delta[1]
}
cv.error.10
```
```{r}
#Bootstrap
alpha.fn=function(data,index){
  X=data$X[index]
  Y=data$Y[index]
  return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
}
alpha.fn(Portfolio,1:100)
```
```{r}
set.seed(1)
alpha.fn(Portfolio,sample(100,100,replace=T))
```
```{r}
boot(Portfolio, alpha.fn,R=1000)
```
```{r}
#Estimating accuracy of linear regression model
boot.fn=function(data,index)
  return(coef(lm(mpg~horsepower, data=data, subset=index)))
boot.fn(Auto,1:392)
```
```{r}
set.seed(1)
boot.fn(Auto, sample(392, 392, replace=T))
boot.fn(Auto, sample(392, 392, replace=T))
```
```{r}
boot(Auto, boot.fn, 1000)
```
```{r}
summary(lm(mpg~horsepower, data=Auto))$coef
```
```{r}
boot.fn=function(data,index)
  coefficients(lm(mpg~horsepower+I(horsepower^2), data=data, subset=index))
set.seed(1)
boot(Auto, boot.fn, 1000)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

