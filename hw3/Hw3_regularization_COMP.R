---
title: "STOR 565 Spring 2018 Homework 3"
author: "Shilpa Kancharla"
output:
  pdf_document: default
  html_document: default
subtitle: \textbf{Due on 02/09/2018 in Class}
header-includes: \usepackage{amsgen,amsmath,amstext,amsbsy,amsopn,amssymb,mathabx,amsthm,bm,bbm}
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
if(!require(ISLR)) { install.packages("ISLR", repos = "http://cran.us.r-project.org"); library(ISLR) }
if(!require(leaps)) { install.packages("leaps", repos = "http://cran.us.r-project.org"); library(leaps) }
if(!require(glmnet)) { install.packages("glmnet", repos = "http://cran.us.r-project.org"); library(glmnet) }
if(!require(pls)) { install.packages("pls", repos = "http://cran.us.r-project.org"); library(pls) }
```
\theoremstyle{definition}
\newtheorem*{hint}{Hint}

\theoremstyle{remark}
\newtheorem*{rmk}{Remark}

*Remark.* This homework aims to help you further understand the model selection techniques in linear model. Credits for **Theoretical Part** and **Computational Part** are in total 100 pt. For **Computational Part** , please complete your answer in the **RMarkdown** file and summit your printed PDF homework created by it.

## Computational Part

**Hint.** Before starting your work, carefully read Textbook Chapter 6.5-6.7 (Lab 1-3). Mimic the related analyses you learn from it. Related packages have been loaded in setup.

1. (Model Selection, Textbook 6.8, *25 pt*) In this exercise, we will generate simulated data, and will then use this data to perform model selection.

    (a) Use the `rnorm` function to generate a predictor $\bm{X}$ of length $n = 100$, as well as a noise vector $\bm{\epsilon}$ of length $n = 100$.
```{r}
set.seed(1)
X <- rnorm(100)
eps <- rnorm(100)
X
eps
```

    (b) Generate a response vector $\bm{Y}$ of length $n = 100$ according to the model $$ Y = \beta_0 + \beta_1 X + \beta_2 X^2 + \beta_3 X^3 + \epsilon, $$ where $\beta_0 = 3$, $\beta_1 = 2$, $\beta_2 = -3$, $\beta_3 = 0.3$.
```{r}
beta_0 <- 3
beta_1 <- 2
beta_2 <- -3
beta_3 <- 0.3
Y <- matrix(beta_0 + beta_1*X + beta_2*(X^2) + beta_3*(X^3) + eps)
Y
```
    (c) Use the `regsubsets` function from `leaps` package to perform best subset selection in order to choose the best model containing the predictors $(X, X^2, \cdots, X^{10})$. What is the best model obtained according to $C_p$, BIC, and adjusted $R^2$? Show some plots to provide evidence for your answer, and report the coefficients of the best model obtained.
```{r}
library(leaps)
data.full <- data.frame(Y, X)
regfit.full <- regsubsets(Y ~ X + I(X^2) + I(X^3) + I(X^4) + I(X^5) 
                          + I(X^6) + I(X^7) + I(X^8)+ I(X^9)+ I(X^10)
                          , data = data.full, nvmax=10)
reg.summary <- summary(regfit.full)
par(mfrow = c(2,2))
plot.default(reg.summary$cp, xlab = "Number of variables", ylab = "C_p", type = "l")
points(which.min(reg.summary$cp), reg.summary$cp[which.min(reg.summary$cp)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary$bic, xlab="Number of Variables", ylab = "BIC", type = "l")
points(which.min(reg.summary$bic), reg.summary$bic[which.min(reg.summary$bic)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary$adjr2, xlab="Number of Variables", ylab = "Adjusted R^2", type = "l")
points(which.max(reg.summary$adjr2), reg.summary$adjr2[which.max(reg.summary$adjr2)], 
       col = "red", cex = 2, pch = 20)
coef(regfit.full, which.max(reg.summary$adjr2))

#We find that, with C_p we pick the 3-variables model,
#with BIC we pick the 3-variables model, and with 
#adjusted R-squared statistic we pick the 3-variables model.

```
    (d) Repeat (c), using forward stepwise selection and also using backwards stepwise selection. How does your answer compare to the results in (c)?
```{r}
regfit.fwd <- regsubsets(Y ~ X + I(X^2) + I(X^3) + I(X^4) + I(X^5) 
                         + I(X^6) + I(X^7) + I(X^8) + I(X^9) + I(X^10), 
                         data=data.full, nvmax=10, method ="forward")
reg.summary.fwd <- summary(regfit.fwd)
par(mfrow = c(2,2))
plot(reg.summary.fwd$cp, xlab="Number of Variables", ylab= "C_p", type = "l")
points(which.min(reg.summary.fwd$cp), reg.summary.fwd$cp[which.min(reg.summary.fwd$cp)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary.fwd$bic, xlab = "Number of variables", ylab = "BIC", type = "l")
points(which.min(reg.summary.fwd$bic), reg.summary.fwd$bic[which.min(reg.summary.fwd$bic)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary.fwd$adjr2, xlab = "Number of variables", ylab = "Adjusted R^2", type = "l")
points(which.max(reg.summary.fwd$adjr2), 
       reg.summary.fwd$adjr2[which.max(reg.summary.fwd$adjr2)], col = "red", cex = 2, pch = 20)
coef(regfit.fwd, which.max(reg.summary.fwd$adjr2))
mtext("Plots of C_p, BIC and adjusted R^2 for forward stepwise selection", 
      side = 3, line = -2, outer = TRUE)

regfit.bwd <- regsubsets(Y ~ X + I(X^2) + I(X^3) + I(X^4) + I(X^5) 
                         + I(X^6) + I(X^7) + I(X^8) + I(X^9) + I(X^10), 
                         data = data.full, nvmax = 10, method = "backward")
reg.summary.bwd <- summary(regfit.bwd)
par(mfrow = c(2, 2))
plot(reg.summary.bwd$cp, xlab = "Number of variables", ylab = "C_p", type = "l")
points(which.min(reg.summary.bwd$cp), reg.summary.bwd$cp[which.min(reg.summary.bwd$cp)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary.bwd$bic, xlab = "Number of variables", ylab = "BIC", type = "l")
points(which.min(reg.summary.bwd$bic), reg.summary.bwd$bic[which.min(reg.summary.bwd$bic)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary.bwd$adjr2, xlab = "Number of variables", ylab = "Adjusted R^2", type = "l")
points(which.max(reg.summary.bwd$adjr2), 
       reg.summary.bwd$adjr2[which.max(reg.summary.bwd$adjr2)], 
       col = "red", cex = 2, pch = 20)
mtext("Plots of C_p, BIC and adjusted R^2 for backward stepwise selection", 
      side = 3, line = -2, outer = TRUE)

#We find that, for backward stepwise selection, with C_p
#we pick the 3-variables model, with BIC we pick the 3-variables model, 
#and with adjusted R-squared statistic we pick the 3-variables model.

#We find that, for forward stepwise selection, with C_p
#we pick the 3-variables model, with BIC we pick the 3-variables model, 
#and with adjusted R-squared statistic we pick the 3-variables model.

#Here forward stepwise, backward stepwise and best subset all select 
#the three variables model with X, X^2 and X^5.
```
    (e) Now fit a LASSO model with `glmnet` function from `glmnet` package to the simulated data, again using $(X,X^2,\cdots,X^{10})$ as predictors. Use cross-validation to select the optimal value of $\lambda$. Create plots of the cross-validation error as a function of $\lambda$. Report the resulting coefficient estimates, and discuss the results obtained.
```{r}
library(glmnet)
Xmat <- model.matrix(Y ~ X + I(X^2) + I(X^3) + I(X^4) + I(X^5) 
                     + I(X^6) + I(X^7) + I(X^8) + I(X^9) + I(X^10), data = data.full)[, -1]
cv.lasso <- cv.glmnet(Xmat, Y, alpha = 1)
plot(cv.lasso)
bestlam <- cv.lasso$lambda.min
bestlam
#We refit the lasso model using the lambda value acquired chosen
#cross validation. 
fit.lasso <- glmnet(Xmat, Y, alpha = 1)
predict(fit.lasso, s = bestlam, type = "coefficients")[1:11, ]
#The lasso method picks X, X^2, X^3 and X^5 as variables for the model
```
    (f) Now generate a response vector $Y$ according to the model $$Y = \beta_0 + \beta_7 X^7 + \epsilon,$$ where $\beta_7 = 7$, and perform best subset selection and the LASSO. Discuss the results obtained.
```{r}
beta_7 <- 7
Y <- beta_0 + beta_7 + X^7 + eps
data.full <- data.frame(Y, X)
regfit.full <- regsubsets(Y ~ X + I(X^2) + I(X^3) + I(X^4) + I(X^5) 
                          + I(X^6) + I(X^7) + I(X^8) + I(X^9) + I(X^10), 
                          data = data.full, nvmax = 10)
reg.summary <- summary(regfit.full)
par(mfrow = c(2, 2))
plot(reg.summary$cp, xlab = "Number of variables", ylab = "C_p", type = "l")
points(which.min(reg.summary$cp), reg.summary$cp[which.min(reg.summary$cp)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary$bic, xlab = "Number of variables", ylab = "BIC", type = "l")
points(which.min(reg.summary$bic), reg.summary$bic[which.min(reg.summary$bic)], 
       col = "red", cex = 2, pch = 20)
plot(reg.summary$adjr2, xlab = "Number of variables", ylab = "Adjusted R^2", type = "l")
points(which.max(reg.summary$adjr2), reg.summary$adjr2[which.max(reg.summary$adjr2)], 
       col = "red", cex = 2, pch = 20)
#We find that, with C_p we pick the 2-variables model, with BIC 
#we pick the 1-variables model, and with adjusted R-squared statistics
#we pick the 4-variables model.
coef(regfit.full, 1)
coef(regfit.full, 2)
coef(regfit.full, 4)
#Best subset selection with BIC picks the most accurate
#1-variable model with matching coefficients.
Xmat <- model.matrix(Y ~ X + I(X^2) + I(X^3) + I(X^4) + I(X^5) 
                     + I(X^6) + I(X^7) + I(X^8) + I(X^9) + I(X^10), 
                     data = data.full)[, -1]
cv.lasso <- cv.glmnet(Xmat, Y, alpha = 1)
bestlam <- cv.lasso$lambda.min
bestlam
fit.lasso <- glmnet(Xmat, Y, alpha = 1)
predict(fit.lasso, s = bestlam, type = "coefficients")[1:11, ]
#Here the lasso also picks the most accurate 1-variable model, but the intercept is off.
```
2. (Prediction, Textbook 6.9, *25 pt*) In this exercise, we will predict the number of applications received using the other variables in the `College` data set from `ISLR` package.

    (a) Randomly split the data set into a training set and a test set (1:1).
```{r}
library(ISLR)
data(College)
set.seed(11)
train = sample(1:dim(College)[1], dim(College)[1] / 2)
test <- -train
College.train <- College[train, ]
College.test <- College[test, ]
```
    (b) Fit a linear model using least squares on the training set, and report the test error obtained.
```{r}
fit.lm <- lm(Apps ~ ., data = College.train)
pred.lm <- predict(fit.lm, College.test)
mean((pred.lm - College.test$Apps)^2)
#Test MSE = 1538442
```
    (c) Fit a ridge regression model on the training set, with $\lambda$ chosen by 5-fold cross-validation. Report the test error obtained.
```{r}
train.mat <- model.matrix(Apps ~ ., data = College.train)
test.mat <- model.matrix(Apps ~ ., data = College.test)
grid <- 10 ^ seq(4, -2, length = 100)
fit.ridge <- glmnet(train.mat, College.train$Apps, alpha = 0, 
                    lambda = grid, thresh = 1e-12)
cv.ridge <- cv.glmnet(train.mat, College.train$Apps, alpha = 0, 
                      lambda = grid, thresh = 1e-12)
bestlam.ridge <- cv.ridge$lambda.min
bestlam.ridge
pred.ridge <- predict(fit.ridge, s = bestlam.ridge, newx = test.mat)
mean((pred.ridge - College.test$Apps)^2)
#The test MSE is higher for ridge regression than for least squares.
```
    (d) Fit a LASSO model on the training set, with $\lambda$ chosen by 5-fold cross-validation. Report the test error obtained, along with the number of non-zero coefficient estimates.
```{r}
fit.lasso <- glmnet(train.mat, College.train$Apps, alpha = 1, 
                    lambda = grid, thresh = 1e-12)
cv.lasso <- cv.glmnet(train.mat, College.train$Apps, alpha = 1, 
                      lambda = grid, thresh = 1e-12)
bestlam.lasso <- cv.lasso$lambda.min
bestlam.lasso
pred.lasso <- predict(fit.lasso, s = bestlam.lasso, newx = test.mat)
mean((pred.lasso - College.test$Apps)^2)
predict(fit.lasso, s = bestlam.lasso, type = "coefficients")
#The test MSE is also higher for ridge regression than for least squares.
```
    (e) Fit a PCR model on the training set, with $M$ chosen by 5-fold cross-validation. Report the test error obtained, along with the value of $M$ selected by cross-validation.
```{r}
library(pls)
fit.pcr <- pcr(Apps ~ ., data = College.train, 
               scale = TRUE, validation = "CV")
validationplot(fit.pcr, val.type = "MSEP")
pred.pcr <- predict(fit.pcr, College.test, ncomp = 10)
mean((pred.pcr - College.test$Apps)^2)
#The test MSE is also higher for PCR than least squares.
```
    
    
    (f) Comment on the results obtained. How accurately can we predict the number of college applications received? Is there much difference among the test errors resulting from these four approaches?
```{r}
test.avg <- mean(College.test$Apps)
lm.r2 <- 1 - mean((pred.lm - College.test$Apps)^2) / mean((test.avg - College.test$Apps)^2)
ridge.r2 <- 1 - mean((pred.ridge - College.test$Apps)^2) / mean((test.avg - College.test$Apps)^2)
lasso.r2 <- 1 - mean((pred.lasso - College.test$Apps)^2) / mean((test.avg - College.test$Apps)^2)
pcr.r2 <- 1 - mean((pred.pcr - College.test$Apps)^2) / mean((test.avg - College.test$Apps)^2)
lm.r2
ridge.r2
lasso.r2
pcr.r2
#We perform the test for the R-squared statistics and obtain the values listed below. 
#The R-squared statistic for the least squares regression is 0.9044281, 
#the R-squared statistic for the ridge regression is 0.900641, 
#R-squared statistic for LASSO is 0.8984123,  
#the R-squared statistic for PCR is 0.8127319 and 
#Based on these results, all the models seem to explain the variability seen around 90%, 
#with the exception of PCR being the worst at prediciting college applications 
#with high accuracy.
```
    
    