---
title: "STOR 565 Spring 2018 Homework 4"
author: "Shilpa Kancharla"
output:
  pdf_document: default
  html_document: default
subtitle: \textbf{Due on 02/21/2018 in Class}
header-includes: \usepackage{amsgen,amsmath,amstext,amsbsy,amsopn,amssymb,mathabx,amsthm,bm,bbm}
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
if(!require(ISLR)) { install.packages("ISLR", repos = "http://cran.us.r-project.org"); library(ISLR) }
```
\theoremstyle{definition}
\newtheorem*{hint}{Hint}

\theoremstyle{remark}
\newtheorem*{rmk}{Remark}

1. (Textbook 4.10, *25 pt*) This question should be answered using the `Weekly` data set, which is part of the `ISLR` package. This data is similar in nature to the `Smarket` data from this chapter's lab, except that it contains 1,089 weekly returns for 21 years, from the beginning of 1990 to the end of 2010. Write a data analysis report addressing the following problems.

    (a) Produce some numerical and graphical summaries of the `Weekly` data. Do there appear to any patterns?
```{r}
summary(Weekly)
cor(Weekly[,-9])
attach(Weekly)
plot(Volume)
```
The correlations between the "Lag" variables and today's returns are nearly zero. The only substantial correlation that occurs is between "Year" and "Volume." Upon plotting "Volume," we see that it is increasing over time.  

    (b) Use the full data set to perform a logistic regression with `Direction` as the response and the five lag variables plus `Volumn` as predictors. Use the summary function to print the results. Do any of the predictors appear to be statistically significant? If so, which ones?
```{r}
glm.fits = glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Weekly, family=binomial)
summary(glm.fits)
```
 "Lag2" seems to be the only predictor that has a statistically significant p-value at the 0.05 level.   

    (c) Compute the confusion matrix and overall fraction of correct predictions. Explain what the confusion matrix is telling you about the types of mistakes made by logistic regression.
```{r}
probs <- predict(glm.fits, type = "response")
pred.glm <- rep("Down", length(probs))
pred.glm[probs > 0.5] <- "Up"
table(pred.glm, Direction)
```
The percentage of correct predictions on the training data is (54+557)/1089 = 56.12%. Therfore, (48+430)/1089 = 43.89% is the training error rate, which is good. On the weeks when the market goes up, (557)/(48+557) = 92.07% of the time the model is accurate. When the market goes down, (54)/(54+530) = 11.16% of the time the model is accurate.   

    (d) Now fit the logistic regression model using a training data period from 1990 to 2008, with `Lag2` as the only predictor. Compute the confusion matrix and the overall fraction of correct predictions for the held out data (that is, the data from 2009 and 2010).
```{r}
train <- (Year < 2009)
Weekly0910 <- Weekly[!train, ]
Direction0910 <- Direction[!train]
glm.fits2 <- glm(Direction ~ Lag2, data = Weekly, family = binomial, subset = train)
summary(glm.fits2)
```
```{r}
probs2 <- predict(glm.fits2, Weekly0910, type = "response")
pred.glm2 <- rep("Down", length(probs2))
pred.glm2[probs2 > 0.5] <- "Up"
table(pred.glm2, Direction0910)
```
The percentage of correct predictions on the test data is given by (9+56)/104 = 62.5%. Therefore, 37.5% is the test error rate. On the weeks when the market goes up, the model is correct (56)/(56+5) = 91.80% of the time. On the weeks when the market goes down, (9)/(9+34) = 20.93% of the time the model is correct.     

    (e) Repeat (d) using LDA.
```{r}
library(MASS)
fit.lda <- lda(Direction ~ Lag2, data=Weekly, subset = train)
fit.lda
```
```{r}
pred.lda <- predict(fit.lda, Weekly0910)
table(pred.lda$class, Direction0910)
```
The percentage of correct predictions on the test data is given by (9+56)/104 = 62.5%. Therefore, 37.5% is the test error rate. On the weeks when the market goes up, the model is correct (56)/(56+5) = 91.80% of the time. On the weeks when the market goes down, (9)/(9+34) = 20.93% of the time the model is correct. These results are nearly identical to the logistic regression.

    (f) Repeat (d) using QDA.
    
```{r}
fit.qda <- qda(Direction ~ Lag2, data = Weekly, subset = train)
fit.qda
```
```{r}
pred.qda <- predict(fit.qda, Weekly0910)
table(pred.qda$class, Direction0910)
```
The percentage of correct predictions on the test data is (61)/(104) = 58.65%. Therefore, 41.35% is the test error rate. For the weeks when the market goes up, the model is (61)/(61+0) = 100%. For the weeks when the market goes down, the model is right (0)/(43 + 0) = 0% of the time.    

    (g) Which of these methods appears to provide the best results on this data?

By comparing the test error rates, the logistic regression and LDA have the minimum error rate, whereas QDA has a higher rate. Therefore, logistic regresion and LDA appear to be better.
   
    (h) Experiment with different combinations of predictors, including possible transformations and interactions, for each of the methods. Report the variables, method, and associated confusion matrix that appears to provide the best results on the held out data.
```{r}
#Logistic regression with Lag2:Lag1
glm.fits3 <- glm(Direction ~ Lag2:Lag1, data = Weekly, family = binomial, subset = train)
probs3 <- predict(glm.fits3, Weekly0910, type = "response")
pred.glm3 <- rep("Down", length(probs3))
pred.glm3[probs3 > 0.5] = "Up"
table(pred.glm3, Direction0910)
```
```{r}
mean(pred.glm3 == Direction0910)
```
```{r}
#LDA with Lag2 interaction with Lag1
fit.lda2 <- lda(Direction ~ Lag2:Lag1, data = Weekly, subset = train)
pred.lda2 <- predict(fit.lda2, Weekly0910)
mean(pred.lda2$class == Direction0910)
```
```{r}
fit.qda2 <- qda(Direction ~ Lag2 + sqrt(abs(Lag2)), data = Weekly, subset = train)
pred.qda2 <- predict(fit.qda2, Weekly0910)
table(pred.qda2$class, Direction0910)
```
```{r}
mean(pred.qda2$class == Direction0910)
```
The logistic regression and LDA have the best performance based on test error rates.
***

2. (Textbook 4.11, *25 pt*) In this problem, you will develop a model to predict whether a given car gets high or low gas mileage based on the `Auto` data set. Write a data analysis report addressing the following problems.

    (a) Create a binary variable, `mpg01`, that contains a 1 if `mpg` contains a value above its median, and a 0 if `mpg` contains a value below its median.
```{r}
attach(Auto)
mpg01 = rep(0, length(mpg))
mpg01[mpg > median(mpg)] = 1
Auto = data.frame(Auto, mpg01)
```
    

    (b) Explore the data graphically in order to investigate the association between `mgp01` and the other features. Which of the other features seem most likely to be useful in predicting `mpg01`? Scatterplots and boxplots may be useful tools to answer this question. Describe your findings.
```{r}
cor(Auto[,-9])
```
```{r}
pairs(Auto)
```
```{r}
boxplot(cylinders ~ mpg01, data = Auto, main = "Cylinders vs mpg01")
```
```{r}
boxplot(displacement ~ mpg01, data = Auto, main = "Displacement vs mpg01")
```
```{r}
boxplot(horsepower ~ mpg01, data = Auto, main = "Horsepower vs mpg01")
```
```{r}
boxplot(weight ~ mpg01, data = Auto, main = "Weight vs mpg01")
```
```{r}
boxplot(acceleration ~ mpg01, data = Auto, main = "Acceleration vs mpg01")
```
```{r}
boxplot(year ~ mpg01, data = Auto, main = "Year vs mpg01")
```

There exists some association between mpg01 & cylinders, weight, displacement and horsepower.    

    (c) Split the data into a training set and a test set.
```{r}
train <- (year %% 2 == 0)
Auto.train <- Auto[train, ]
Auto.test <- Auto[!train, ]
mpg01.test <- mpg01[!train]
```
    

    (d) Perform LDA on the training data in order to predict `mpg01` using the variables that seemed most associated with `mpg01` in (b). What is the test error of the model obtained?
```{r}
fit.lda <- lda(mpg01 ~ cylinders + weight + displacement + horsepower, data = Auto, subset = train)
fit.lda
```
```{r}
pred.lda <- predict(fit.lda, Auto.test)
table(pred.lda$class, mpg01.test)
```
```{r}
mean(pred.lda$class != mpg01.test)
```
Test error rate is 12.64%.    

    (e) Perform QDA on the training data in order to predict `mpg01` using the variables that seemed most associated with `mpg01` in (b). What is the test error of the model obtained?
```{r}
fit.qda <- qda(mpg01 ~ cylinders + weight + displacement + horsepower, data = Auto, subset = train)
fit.qda
```
```{r}
pred.qda <- predict(fit.qda, Auto.test)
table(pred.qda$class, mpg01.test)
```
```{r}
mean(pred.qda$class != mpg01.test)
```
The test error rate is 13.19%.    

    (f) Perform logistic regression on the training data in order to predict `mpg01` using the variables that seemed most associated with `mpg01` in (b). What is the test error of the model obtained?
```{r}
fit.glm <- glm(mpg01 ~ cylinders + weight + displacement + horsepower, data = Auto, family = binomial, subset = train)
summary(fit.glm)
```
```{r}
probs <- predict(fit.glm, Auto.test, type = "response")
pred.glm <- rep(0, length(probs))
pred.glm[probs > 0.5] <- 1
table(pred.glm, mpg01.test)

```
```{r}
mean(pred.glm != mpg01.test)
```
There is a test error rate of 12.09%.
***

