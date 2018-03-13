---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
xtr <- matrix(rnorm(100*100), ncol=100)
xte <- matrix(rnorm(100000*100), ncol=100)
beta <- c(rep(1,10), rep(0,90))
ytr <- xtr%*%beta + rnorm(100)
yte <- xte%*%beta + rnorm(100000)
rsq <- trainerr <- testerr <- NULL
for(i in 2:100){
  mod <- lm(ytr~xtr[,1:i])
  rsq <- c(rsq, summary(mod)$r.squared)
  beta <- mod$coef[-1]
  intercept <- mod$coef[1]
  trainerr <- c(trainerr, mean((xtr[,1:i]%*%beta+intercept - ytr)^2))
  testerr <- c(testerr, mean((xte[,1:i]%*%beta+intercept - yte)^2))
}
par(mfrow=c(1,3))
plot(2:100, rsq, xlab="No of variables", ylab="R Squared", log="y")
abline(v=10, col="red")
plot(2:100, trainerr, xlab="No of variables", ylab="Training Error", log="y")
abline(v=10, col="red")
plot(2:100, testerr, xlab="No of variables", ylab="Test Error", log="y")
abline(v=10, col="red")
```
1st 10 variables are related to response; remaining 90 are not. R squared increases and training error decreases as more variables are added to the model. Test error is lowest when only signal varaibles in model.
```{r}
xtr <- matrix(rnorm(1000*20), ncol=20)
beta <- c(rep(1,10), rep(0,10))
ytr <- 1*((xtr%*%beta + .2*rnorm(1000)) >= 0)
mod <- glm(ytr~xtr, family="binomial")
print(summary(mod))
```
```{r}
library(glmnet)
#LASSO for Logistic Regression
xtr <- matrix(rnorm(1000*20), ncol=20)
beta <- c(rep(1,5), rep(0,15))
ytr <- 1*((xtr%*%beta + .5*rnorm(1000)) >= 0)
cv.out <- cv.glmnet(xtr, ytr, family="binomial", alpha=1)
plot(cv.out)
```


Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

