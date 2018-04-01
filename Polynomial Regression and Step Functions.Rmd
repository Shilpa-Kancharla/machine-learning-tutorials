---
title: "Polynomial Regression & Step Functions"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
library(ISLR)
attach(Wage)
```
```{r}
#fit the model using the following command
fit = lm(wage~poly(age,4), data=Wage)
coef(summary(fit))
```
```{r}
fit2=lm(wage~poly(age,4,raw=T), data=Wage)
coef(summary(fit2))
```
```{r}
#creating polynomial basis function
fit2a=lm(wage~age+I(age^2)+I(age^3)+I(age^4), data=Wage)
coef(fit2a)
```
```{r}
#building a matrix from a collection of vectors
fit2b = lm(wage~cbind(age, age^2, age^3, age^4), data=Wage)
fit2b
```
```{r}
#We can create a grid of values for age at which we want predictions, and then call the generic predict() function, specifying that we want standard errors as welll. 
agelims = range(age)
age.grid = seq(from = agelims[1], to=agelims[2])
preds = predict(fit, newdata=list(age=age.grid), se=TRUE)
se.bands = cbind(preds$fit + 2*preds$se.fit, preds$fit - 2*preds$se.fit)
#We plot the data and add the fit from the degree-4 polynomial:
par(mfrow=c(1,2), mar=c(4.5, 4.5, 1, 1), oma=c(0,0,4,0))
plot(age, xlim = agelims, cex = .5, col="darkgrey")
plot(wage, xlim = agelims, cex = .5, col="blue")
title("Degree-4 Polynomial", outer=T)
lines(age.grid, preds$fit, lwd=2, col="blue")
matlines(age.grid, se.bands, lwd=1, col="blue", lty=3)
```
```{r}
preds2 = predict(fit2, newdata=list(age=age.grid), se=TRUE)
max(abs(preds$fit - preds2$fit))
```
```{r}
fit.1 = lm(wage~age, data=Wage)
fit.2 = lm(wage~poly(age,2), data=Wage)
fit.3 = lm(wage~poly(age,3), data=Wage)
fit.4 = lm(wage~poly(age,4), data=Wage)
fit.5 = lm(wage~poly(age,5), data=Wage)
anova(fit.1, fit.2, fit.3, fit.4, fit.5)
```
```{r}
coef(summary(fit.5))
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

