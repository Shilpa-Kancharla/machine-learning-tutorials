---
title: "STOR 565 Spring 2018 Homework 6"
author: "Shilpa Kancharla"
output:
  pdf_document: default
  html_document: default
subtitle: \textbf{Due on 04/04/2018 in Class}
header-includes: \usepackage{amsgen,amsmath,amstext,amsbsy,amsopn,amssymb,mathabx,amsthm,bm,bbm}
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
\theoremstyle{definition}
\newtheorem*{hint}{Hint}

\theoremstyle{remark}
\newtheorem*{rmk}{Remark}

*Remark.* Credits for **Theoretical Part** and **Computational Part** are in total *105 pt*. At most *100 pt* can be earned. For **Computational Part**, please complete your report in the **RMarkdown** file and submit your printed PDF homework created by it.

## Computational Part

>> **You are supposed to finish the Computational Part in a readable report manner for each dataset-based analysis problem. Other than what you are asked to do, you can decide any details on your own discretion.**

**Note.** Read Section 7.8 and 8.3 in Textbook before getting started.

1. (GAM, Textbook 7.11 \& 7.12, *20 pt*) The approach to fit a generalized additive model (GAM) is called *backfitting*, which follows a quite simple idea. We will now explore backfitting in the context of multiple linear regression. Suppose that we would like to perform multiple linear regression, but we do not have software to do so. Instead, we only have software to perform simple linear regression. Therefore, we take the following iterative approach: we repeatedly hold all but one coefficient estimate fixed at its current value, and update only that coefficient estimate using a simple linear regression. The process is continued until convergence, *i.e.* until the coefficient estimates stop changing. We now try this out on a toy example. Write a report on the following scheme.

    (a) Generate a response $Y$ and two predictors $X_1$ and $X_2$, with $n = 100$.
    
```{r}
set.seed(1)
X1 <- rnorm(100)
X2 <- rnorm(100)
beta_0 <- 4
beta_1 <- 7
beta_2 <- 5
eps <- rnorm(100, sd = 1)
Y <- beta_0 + beta_1*X1 + beta_2*X2 + eps
par(mfrow=c(1,1))
plot(Y)
```
    
    (b) Initialize $\hat{\beta}_1$ to take on a value of your choice. It does not matter what value you choose.
```{r}
bhat_1 <- 1
```
    
    (c) Keeping $\hat{\beta}_1$ fixed, fit the model
    $$Y - \hat{\beta}_1 X_1 = \beta_0 + \beta_2 X_2 + \epsilon.$$
```{r}
a = Y - bhat_1*X1
bhat_2 =lm(a~X2)$coef[2]
```
    
    (d) Keeping $\hat{\beta}_2$ fixed, fit the model
    $$Y - \hat{\beta}_2 X_2 = \beta_0 + \beta_1 X_1 + \epsilon.$$
```{r}
a = Y - bhat_2*X2
bhat_1 = lm(a~X1)$coef[2]
```
    
    (e) Write a `for` loop to repeat (c) and (d) 1000 times. Report the estimates of $\hat{\beta}_0$, $\hat{\beta}_1$, and $\hat{\beta}_2$ at each iteration of the `for` loop. Create a plot in which each of these values is displayed, with $\hat{\beta}_0$, $\hat{\beta}_1$, and $\hat{\beta}_2$ each shown in a different color.
```{r}
bhat_0 <- bhat_1 <- bhat_2 <- rep(0,1000)
for (i in 1:1000) {
  a <- Y - bhat_1[i]*X1
  bhat_2[i] <- lm(a ~ X2)$coef[2]
  a <- Y - bhat_2[i]*X2
  bhat_0[i] <- lm(a ~ X1)$coef[1] #bhat will have 1001 terms
  bhat_1[i+1] <- lm(a ~ X1)$coef[2]
}
require(ggplot2)
require(reshape2)

mydf <- data.frame(Iteration=1:1000, bhat_0, bhat_1=bhat_1[-1], bhat_2)
mmydf <- melt(mydf, id.vars="Iteration")
ggplot(mmydf, aes(x=Iteration, y=value, group=variable, col=variable)) + 
  geom_line(size=1) + ggtitle("Plot of beta estimates by Iteration")
```
    
    (f) Compare your answer in (e) to the results of simply performing multiple linear regression to predict $Y$ using $X_1$ and $X_2$. Use the `abline()` function to overlay those multiple linear regression coefficient estimates on the plot obtained in (e).
```{r}
fit.lm <- lm(Y ~ X1 + X2)
coef(fit.lm)
plot(bhat_0, type="l", col="red", lwd=2, xlab="Iterations", ylab="Beta Estimates",
     ylim=c(-5,10))
lines(bhat_1[-1], col="green", lwd=2)
lines(bhat_2, col="blue", lwd=2)
abline(h=coef(fit.lm)[1], lty = "dashed", lwd=3, col="beige")
abline(h=coef(fit.lm)[2], lty="dashed", lwd=3, col="cornflowerblue")
abline(h=coef(fit.lm)[3], lty="dashed", lwd=3, col="darkturquoise")
legend(x=600, y=9.7, c("bhat_0", "bhat_1", "bhat_2", "Multiple Regression"),
       lty = c(1,1,1,2), col = c("red", "green", "blue", "gray"))
```
    
    (g) On this data set, how many backfitting iterations were required in order to obtain a “good” approximation to the multiple regression coefficient estimates?
```{r}
head(mydf)
```
 It seems here that two iterations was enough to acquire a fit, and after the second iteration none of the beta hat values change (the values have converged).
 
    (h) In a toy example with $p = 100$, show that one can approximate the multiple linear regression coefficient estimates by repeatedly performing simple linear regression in a backfitting procedure. How many backfitting iterations are required in order to obtain a “good” approximation to the multiple regression coefficient estimates? Create a plot to justify your answer.
```{r}
set.seed(1)
#Toy example with 100 predictors
p <- 100 #number of true predictors
n <- 1000 # number of observations
betas <- rnorm(p+1)*5 #includes beta_0
X <- matrix(rnorm(n*p), ncol=p, nrow=n)
eps <- rnorm(n, sd=0.5)
Y <- betas[1] + (X %*% betas[-1]) + eps #betas will repeat n times
par(mfrow=c(1,1))
plot(Y)
```
```{r}
#Find coefficient estimates with multiple regression
fit.lm <- lm(Y~X)
bhats.lm <- coef(fit.lm)

#Run backfitting with 100 iterations
bhats <- matrix(0, ncol=p, nrow=100)
mse.error <- rep(0,100)
for (i in 1:100) {
  for (k in 1:p) {
    a = Y - (X[,-k] %*% bhats[i,-k])
    bhats[i:100, k] = lm(a ~ X[,k])$coef[2]
  }
  mse.error[i] <- mean((Y-(X %*% bhats[i,]))^2)
}
plot(1:100, mse.error)
```
```{r}
plot(1:5, mse.error[1:5], type="b")
```
We see that the second iteration results were very close to multiple regression.    
***

2. (Regression Tree, Boosting, Bagging and Random Forest, Textbook 8.9, *40 pt*) This problem involves the `OJ` data set which is part of the `ISLR` package. Write a report to address the following problems.

    (a) Create a training set containing a random sample of 800 observations, and a test set containing the remaining observations.
```{r}
set.seed(1)
library(ISLR)
train <- sample(1:nrow(OJ), 800)
OJ.train <- OJ[train, ]
OJ.test <- OJ[-train, ]
```
    
    (b) Fit a tree to the training data, with `Purchase` as the response and the other variables except for Buy as predictors. Use the `summary()` function to produce summary statistics about the tree, and describe the results obtained. What is the training error rate? How many terminal nodes does the tree have?
```{r}
library(tree)
tree.OJ <- tree(Purchase ~ ., data=OJ.train)
summary(tree.OJ)
plot(tree.OJ)
text(tree.OJ, pretty=0)
yhat <- predict(tree.OJ, newdata = OJ.test)
mean((yhat - OJ.test$Purchase)^2)
```
The fitted tree has 8 terminal nodes and a training error rate of 0.165.

    (c) Type in the name of the tree object in order to get a detailed text output. Pick one of the terminal nodes, and interpret the information displayed.
```{r}
tree.OJ
```
We choose the node labeled 8, which is a terminal node because of the asterisk. The split criterion is LoyalCH < 0.035, the number of observations in that branch is 57 with a deviance of 10.07, and an overall prediction for the branch of MM. Less than 2% of the observations in that branch take the value of CH, and the remaining 98% take the value of MM.    

    (d) Create a plot of the tree, and interpret the results.
```{r}
plot(tree.OJ)
text(tree.OJ, pretty=0)
```
The most important indicator for "Purchase" appears to be "LoyalCH", since the first branch differentiates the intensity of customer branch loyalty to CH. This is further supported because the first three nodes contain "LoyalCH."    
    
    (e) Predict the response on the test data, and produce a confusion matrix comparing the test labels to the predicted test labels. What is the test error rate?
```{r}
tree.pred <- predict(tree.OJ, OJ.test, type="class")
table(tree.pred, OJ.test$Purchase)

```
```{r}
1 - (147 + 62)/270
```
The test error rate is about 22.6%.

    (f) Apply the `cv.tree()` function to the training set in order to determine the optimal tree size.
```{r}
cv.OJ <- cv.tree(tree.OJ, FUN = prune.misclass)
cv.OJ
```

    (g) Produce a plot with tree size on the $x$-axis and cross-validated classification error rate on the $y$-axis.
```{r}
plot(cv.OJ$size, cv.OJ$dev, type="b", xlab="Tree size", ylab = "Deviance")
```
    
    (h) Which tree size corresponds to the lowest cross-validated classification error rate?

We see that the 2-node tree is the smallest tree with the lowest classification error rate.
    
    (i) Produce a pruned tree corresponding to the optimal tree size obtained using cross-validation. If cross-validation does not lead to selection of a pruned tree, then create a pruned tree with five terminal nodes.
```{r}
prune.OJ <- prune.misclass(tree.OJ, best = 2)
plot(prune.OJ)
text(prune.OJ, pretty=0)
```
    
    (j) Compare the training error rates between the pruned and unpruned trees. Which is higher?
```{r}
summary(tree.OJ)
summary(prune.OJ)
```
Misclassification error rate is slightly higher for the pruned tree.

    (k) Compare the test error rates between the pruned and unpruned trees. Which is higher?
```{r}
prune.pred <- predict(prune.OJ, OJ.test, type="class")
table(prune.pred, OJ.test$Purchase)
```
```{r}
1 - (119 + 81) / 270
```
We see that the pruning process incrrease the test error to almost 26%, but it produced a more interpretable tree.

    (l) Perform  boosting on the training set with 1,000 trees for a range of values of the shrinkage parameter $\lambda$. Produce a plot with different shrinkage values on the $x$-axis and the corresponding training error and test error on the $y$-axis. Which variables appear to be the important predictors in the boosted model?
```{r}
library(gbm)
set.seed(1)
powers <- seq(-10, -0.2, by = 0.1)
lambdas <- 10^powers
train.err <- rep(NA, length(lambdas))
for (i in 1:length(lambdas)) {
  boost.OJ <- gbm(LoyalCH ~ ., data= OJ.train, distribution="gaussian", 
                  n.trees = 1000, shrinkage = lambdas[i])
  pred.train <- predict(boost.OJ, OJ.train, n.trees = 1000)
  train.err[i] <- mean((pred.train - OJ.train$LoyalCH)^2)
}
plot(lambdas, train.err, type="b", xlab="Shrinkage values", ylab="Training MSE")
```
```{r}
set.seed(1)
test.err <- rep(NA, length(lambdas))
for (i in 1:length(lambdas)) {
  boost.OJ <- gbm(LoyalCH ~ ., data=OJ.train, distribution="gaussian",
                  n.trees=1000, shrinkage=lambdas[i])
  yhat <- predict(boost.OJ, OJ.test, n.trees=1000)
  test.err[i] <- mean((yhat - OJ.test$LoyalCH)^2)
}
plot(lambdas, test.err, type="b", xlab = "Shrinkage Values", ylab = "Test MSE")
```
```{r}
min(test.err)
lambdas[which.min(test.err)]
```
The minimum test MSE is 0.048 and is obtained for the lambda value of about 0.02512.
```{r}
boost.OJ <- gbm(LoyalCH ~ ., data = OJ.train, distribution = "gaussian",
                n.trees = 1000, shrinkage = lambdas[which.min(test.err)])
summary(boost.OJ)
```
We see that Purchase is the most important variable. 
 
    (m) Perform bagging on the training set and report the prediction performance on the test set. Which variables are identified to be important predictors?
```{r}
#install.packages("randomForest")
.libPaths("shilpakancharla/STOR 565/Hw6")
library(randomForest)
set.seed(1)
bag.OJ <- randomForest(LoyalCH ~ ., data = OJ.train, mtry = 19, ntree = 500)
yhat.bag <- predict(bag.OJ, newdata = OJ.test)
mean((yhat.bag - OJ.test$LoyalCH)^2)
```
The test MSE for bagging is 0.055, which is slightly higher than the test MSE for boosting.  
```{r}
varImpPlot(bag.OJ) #varImpPlot is only used for randomForest functions
```
From this plot, we could say that the Purchase is the most relevant predictor because it has the highest node purity.
    
    (n) Perform random forest on the training set with $\sqrt{p}$ and $p/3$ predictors respectively and report the prediction performance on the test set. Which variables are identified to be important predictors?
    
```{r}
set.seed(1)
bag.OJ1 <- randomForest(LoyalCH ~ ., data = OJ.train, mtry = sqrt(19), ntree = 500)
bag.OJ1
bag.OJ2 <- randomForest(LoyalCH ~ ., data = OJ.train, mtry = 19/3, ntree = 500)
bag.OJ2
varImpPlot(bag.OJ1)
varImpPlot(bag.OJ2)
```
In both models, we see that Purchase is still the most important predictor. However, towards the less important variables, the order of variables changes. For instance, SpecialCH is more important in bag.OJ2 with p/3 than in bag.OJ1 where we have sqrt(p). 
    
    (o) Compare the above models.
```{r}
yhat.bag1 <- predict(bag.OJ1, newdata = OJ.test)
mean((yhat.bag1 - OJ.test$LoyalCH)^2)

yhat.bag2 <- predict(bag.OJ2, newdata = OJ.test)
mean((yhat.bag2 - OJ.test$LoyalCH)^2)
```
It seems that the model with sqrt(p) predictors has a lower test MSE than the model with p/3 predictors.
