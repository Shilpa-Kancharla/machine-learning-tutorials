---
title: "STOR 565 Spring 2018 Homework 5"
author: "Shilpa Kancharla"
output:
  pdf_document: default
  html_document: default
subtitle: \textbf{Due on 03/05/2018 in Class}
header-includes: \usepackage{amsgen,amsmath,amstext,amsbsy,amsopn,amssymb,mathabx,amsthm,bm,bbm}
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
if(!require(ISLR)) { install.packages("ISLR", repos = "http://cran.us.r-project.org"); library("ISLR") }
if(!require(class)) { install.packages("class", repos = "http://cran.us.r-project.org"); library("class") }
if(!require(e1071)) { install.packages("e1071", repos = "http://cran.us.r-project.org"); library("e1071") }
if(!require(splines)) { install.packages("splines", repos = "http://cran.us.r-project.org"); library("splines") }
```
\theoremstyle{definition}
\newtheorem*{hint}{Hint}

\theoremstyle{remark}
\newtheorem*{rmk}{Remark}

*Remark.* Credits for **Theoretical Part** and **Computational Part** are in total *105 pt*. At most *100 pt* can be earned. For **Computational Part**, please complete your report in the **RMarkdown** file and submit your printed PDF homework created by it.

## Computational Part

>> **You are supposed to finish the Computational Part in a readable report manner for each dataset-based analysis problem. Other than what you are asked to do, you can decide any details on your own discretion.**

**Note.** Read Section 9.6 and 7.8 in Textbook before getting started.

1. (KNN \& SVM, Textbook 9.7, *25 pt*) In Homework 4, we have performed serveral classification techniques to predict whether a given car gets high or low gas mileage based on the `Auto` data set. We will continue with KNN and SVM in this exercise. Write a data analysis report addressing the following problems.

    (a) Create a binary variable `mpg01` as in Homework 4, and regenerate the training set and test set from Homework 4.
```{r}
library(MASS)
library(ISLR)
Auto$mpg01 <- ifelse(Auto$mpg > median(Auto$mpg), 1, 0)
Auto$mpg01
pairs(Auto[,-9]) #Horsepower, displacement, weight and acceleration look like they have some association with mpg01.
set.seed(1)
rands <- rnorm(nrow(Auto))
test <- rands > quantile(rands, 0.75)
train <- !test
Auto.train <- Auto[train,]
Auto.test <- Auto[test,]
```

    (b) Perform KNN on the training data, with several values of $K$, in order to predict `mpg01`. Use only the variables that seemed most associated with `mpg01`. Report the cross-validation errors associated with different values of $K$. Comment on your results.
```{r}
set.seed(1)
train.Auto = Auto.train[,c("horsepower","weight","acceleration")]
test.Auto =  Auto.test[,c("horsepower","weight","acceleration")]
knn.pred=knn(train.Auto,test.Auto,Auto.train$mpg01,k=1)
table(knn.pred,Auto.test$mpg01)
mean(knn.pred==Auto.test$mpg01)

knn.pred=knn(train.Auto,test.Auto,Auto.train$mpg01,k=2)
table(knn.pred,Auto.test$mpg01)
mean(knn.pred==Auto.test$mpg01)

knn.pred=knn(train.Auto,test.Auto,Auto.train$mpg01,k=3)
table(knn.pred,Auto.test$mpg01)
mean(knn.pred==Auto.test$mpg01)

knn.pred=knn(train.Auto,test.Auto,Auto.train$mpg01,k=5)
table(knn.pred,Auto.test$mpg01)
mean(knn.pred==Auto.test$mpg01)

knn.pred=knn(train.Auto,test.Auto,Auto.train$mpg01,k=10)
table(knn.pred,Auto.test$mpg01)
mean(knn.pred==Auto.test$mpg01)

knn.pred=knn(train.Auto,test.Auto,Auto.train$mpg01,k=15)
table(knn.pred,Auto.test$mpg01)
mean(knn.pred==Auto.test$mpg01)


```
K = 3 performs the best out of all of these, with K = 10 being the second best. We can tell this becuause the mean is the highest for both of these. 
    
    (c) Fit a support vector classifier to the training data with various values of `cost`, in order to predict whether a car gets high or low gas mileage. Report the cross-validation errors associated with different values of this parameter. Comment on your results.
```{r}
var <- ifelse(Auto$mpg > median(Auto$mpg), 1, 0)
Auto$mpglevel <- as.factor(var)
set.seed(2)
tune.out <- tune(svm, mpglevel ~ ., data = Auto, kernel = "linear", ranges = list(cost = c(0.01, 0.1, 1, 5, 10, 100, 1000)))
summary(tune.out)
```
Cost at 1 performs the best. 

    (d) Now repeat (c), this time using SVMs with radial and polynomial basis kernels, with different values of `gamma` and   `degree` and cost. Comment on your results.
```{r}
set.seed(3)
tune.out <- tune(svm, mpglevel ~ ., data = Auto, kernel = "radial", ranges = list(cost = c(0.01, 0.1, 1, 5, 10, 100), gamma = c(0.01, 0.1, 1, 5, 10, 100)))
summary(tune.out)
```
For a radial kernel, the lowest CV error for gamma occurs at 0.01 and at a cost of 100.

    (e) Make some plots to back up your assertions in (b), (c) and (d).
```{r}
svm.linear <- svm(mpglevel ~ ., data = Auto, kernel = "linear", cost = 1)
svm.poly <- svm(mpglevel ~ ., data = Auto, kernel = "polynomial", cost = 100, degree = 2)
svm.radial <- svm(mpglevel ~ ., data = Auto, kernel = "radial", cost = 100, gamma = 0.01)
plotpairs = function(fit) {
    for (name in names(Auto)[!(names(Auto) %in% c("mpg", "mpglevel", "name"))]) {
        plot(fit, Auto, as.formula(paste("mpg~", name, sep = "")))
    }
}
plotpairs(svm.linear)
plotpairs(svm.poly)
plotpairs(svm.radial)
```
    
    (f) Compare the test errors of the best tuned models for KNN, linear SVM, SVM with radial basis kernel, and SVM with polynomial basis kernel.
```{r}
train.pred1 <- predict(svm.linear, Auto.train)
table(Auto.train$mpg01, train.pred1)
(0+0)/(152+0+0+142)
train.pred2 <- predict(svm.poly, Auto.train)
table(Auto.train$mpg01, train.pred2)
(1+89)/(63+89+1+141)
train.pred3 <- predict(svm.radial, Auto.train)
table(Auto.train$mpg01, train.pred3)
(0+0)/(152+0+0+142)
```
Linear and radial kernel models are best because they have zero training error.


***

2. (Polynomial Regression and Regression Spline, Textbook 7.9, *25 pt*) This question uses the variables `dis` (the weighted mean of distances to five Boston employment centers) and `nox` (nitrogen oxides concentration in parts per 10 million) from the `Boston` data. We will treat `dis` as the predictor and `nox` as the response. Write a data analysis report addressing the following problems.

    (a) Use the `poly()` function to fit a cubic polynomial regression to predict `nox` using `dis`. Report the regression output, and plot the resulting data and polynomial fits.
```{r}
library(MASS)
attach(Boston)
fit = lm(nox ~ poly(dis, 3, raw=TRUE))
summary(fit)
dislims = range(dis)
dis.grid = seq(from=dislims[1], to=dislims[2], by = .1)
preds=predict(fit, newdata=list(dis=dis.grid), se=TRUE)
plot(dis,nox, main="Polynomial fit of Boston data frame")
lines(dis.grid, preds$fit, lwd=2, col="deeppink")
```
We see that linear, quadratic and cubic terms are significant.    

    (b) Plot the polynomial fits for a range of different polynomial degrees (say, from 1 to 10), and report the associated residual sum of squares.
```{r}
par(mar = c(5, 5, 5, 5))
for(i in 1:10){
  fit = lm(nox ~ poly(dis ,i, raw =T))
  preds=predict(fit, newdata =list(dis=dis.grid), se=TRUE)
  plot(dis,nox, col="grey80",main= paste("Degree:", i, ", RSS:", round(sum(fit$residuals^2),3)), xlab="nox", ylab="dis")
  lines(dis.grid ,preds$fit ,lwd =2, col ="deeppink")
}
```
    
    (c) Perform cross-validation or another approach to select the optimal degree for the polynomial, and explain your results.
```{r}
par(mar=c(5,5,5,5))
par(mfrow = c(1, 1))
library(boot)
set.seed(800)
degree=1:10
cv.error=rep(0,10)
for (i in degree){
    fit = glm(nox ~ poly(dis ,i, raw =T),data=Boston)
    cv.error[i] = cv.glm(Boston,fit, K=10)$delta[1]
}
cv.error
plot(degree, cv.error, type="b", ylim=c(0, 0.012))
degree=1:10
cv.errormat = matrix(NA,nrow=10, ncol=10)
for(j in 1:10){
  set.seed(j)
  for (i in degree){    
      fit = glm(nox ~ poly(dis ,i, raw =T),data=Boston)
      cv.errormat[j,i] = cv.glm(Boston,fit, K=10)$delta[1]
  }
}
boxplot(cv.errormat)
# Create a function to calculate the std error of the errors for each degree.
std <- function(x) sd(x)/sqrt(length(x))
# make the upper and lower threshold for SE and plot it
se.upper <- colMeans(cv.errormat) + apply(cv.errormat, 2, std)
se.lower <- colMeans(cv.errormat) - apply(cv.errormat, 2, std)
polygon(c(degree, rev(degree)), c(se.lower, rev(se.upper)),col = adjustcolor("grey",alpha.f=0.5), border = NA)
# plot the minimum error point
degree.min <- which.min(colMeans(cv.errormat))
points(degree.min, colMeans(cv.errormat)[degree.min], pch = 20, col = "red")

```
The third degree has the minimum error minimal standard error. The second degree is also similar to the third degree in this nature, but not low enough to meet the rule of one standard error from the minimum. Therefore, we choose the third degree.

    (d) Use the `bs()` function to fit a regression spline to predict nox using dis. Report the output for the fit using four degrees of freedom. How did you choose the knots? Plot the resulting fit.
```{r}
library(splines)
median(dis) == attr(bs(dis,df=4), "knots")
fit1 = lm(nox ~ bs(dis,df=4),data=Boston)
summary(fit1)$fstatistic[2]
summary(fit1)
reds=predict(fit1, newdata =list(dis=dis.grid), se=TRUE)
plot(dis,nox, main = "Spline (4 degrees freedom) fit of Boston data frame", col="grey")
lines(dis.grid, preds$fit ,lwd =2, col =" blue")
lines(dis.grid,preds$fit +1.96 * preds$se ,lty = "dashed", col= adjustcolor("gold",alpha.f=0.5), lwd =1.5)
lines(dis.grid ,preds$fit -1.96 * preds$se ,lty = "dashed", col= adjustcolor("gold",alpha.f=0.5), lwd =1.5)
abline(v=attr(bs(dis,df=4), "knots"), lty=2, lwd=2, col="grey")
legend(5,.8, c("Cubic Spline with 4 df", "95% confidence interval of model", "Knot placement"), col=c("deeppink",adjustcolor("blue",alpha.f=0.5), "grey"), lwd=2, lty = c("solid","dashed", "dashed"), cex=.7)
```
4 degrees of freedom indicate that we should choose 1 knot in the spline. To choose the knot, a common practice is to place knots in a uniform fashion. A cubic spline with one knot would be at the median of "dis". This fit has a long tail and large confidence band at high values of "dis", this was expected given the small number of points in this range. Besides this quirk, it is a smooth fit with slight broadening of the confidence band at lower values of "dis".    
    
    (e) Now fit a regression spline for a range of degrees of freedom, and plot the resulting fits and report the resulting RSS. Describe the results obtained.
```{r}
degrees = 3:12
RSS <- rep(0,12)

par(mar = c(5, 5, 5, 5)) 
for(i in degrees){ 
  fit = glm(nox ~ bs(dis,df=i),data=Boston)
  preds=predict(fit, newdata =list(dis=dis.grid), se=F) 
  RSS[i] <- round(sum(fit$residuals^2),3)
  plot(dis, nox, col="grey80",main= paste("Degree: ", i, ", RSS: ", RSS[i], ", Knots: ", i-3, sep=""), xlab="nox", ylab="dis")   
  lines(dis.grid ,preds ,lwd =2, col ="deeppink") 
}

par(mfrow = c(1, 2))
plot(degrees,RSS[3:12],type="b", ylim=c(0,max(RSS)), xlab="Degree of freedom", ylab="RSS")
plot(degrees,RSS[3:12],type="b", xlab="Degree of freedom", ylab="RSS")
```
There is an initial drop in RSS from 4 degrees of freedom to 5 degrees of freedom, however, this drop is slower after that point, as the function gradually comes to fit the data better. The chart on the right shows a steady decline in RSS from 5 to 12 degrees of freedom.    
    
    (f) Perform cross-validation or another approach in order to select the best degrees of freedom for a regression spline on this data. Describe your results.
```{r}
cv.errormat = data.frame(matrix(NA,nrow=10, ncol=10))
degree.k <- 3:13
for(j in 1:10){
  set.seed(j)
  for (i in degree.k){    
      fit2 = glm(nox ~ bs(dis,df=i),data=Boston)
      cv.errormat[j,i-2] = cv.glm(Boston,fit2, K=10)$delta[1]
  }
}

colnames(cv.errormat) <- degree.k
boxplot(cv.errormat, xlab="Degrees of freedom", ylab="cross-validation error", main="Regression spline over different seeds")
plot(degree.k,colMeans(cv.errormat),xlab="Degrees of freedom", ylab="Average cv.error", main="Regression Spline with knots : Avg CV and one SE band")
```
```{r}
## plot the mean of the errors overs the 10 different seeds
plot(degree.k,colMeans(cv.errormat),xlab="Degrees of freedom", ylab="Average cv.error", main="Regression Spline with knots : Avg CV and one SE band")
## make the upper and lower threshold for SE and plot it
se.upper <- colMeans(cv.errormat) + apply(cv.errormat, 2, std)
se.lower <- colMeans(cv.errormat) - apply(cv.errormat, 2, std)
## plot the minimum error point
degree.min <- which.min(colMeans(cv.errormat))
points(degree.k[degree.min], colMeans(cv.errormat)[degree.min], pch = 20, col = "red")
arrows(degree.k, se.lower, degree.k, se.upper,length=0.05, angle=90, code=3)
abline(h=se.upper[degree.min] ,col="red",lty=2)
colMeans(cv.errormat) < se.upper[degree.min]
```
Some of the results at lower df meet the standard error rule of being within one standard error of the minimum. We validate this below. 6 is the lowest df to meet the one SE rule, therefore we choose 6 as the best df for a regression spline with this data.    
***