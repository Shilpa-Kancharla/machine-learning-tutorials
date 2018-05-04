---
title: "blank"
author: "Shilpa Kancharla"
date: "4/25/2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
xtr <- matrix(rnorm(100*100), ncol = 100) #Training data set of 100 by 100 predictors, with 100 columns.
xte <- matrix(rnorm(100000*100), ncol = 100) #Testing data set of 10000 by 100 predictors, with 100 columns.
beta <- c(rep(1,10), rep(0,90))
ytr <- xtr%*%beta + rnorm(100) #Training responses
yte <- xte%*%beta + rnorm(100000) #Test responses
rsq <- trainerr <- testerr <- NULL
for (i in 2:100) {
  mod <- lm(ytr~xtr[,1:i])
  rsq <- c(rsq, summary(mod)$r.squared)
  beta <- mod$coef[-1]
  intercept <- mod$coef[1]
  trainerr <- c(trainerr, mean((xtr[,1:i]%*%beta+intercept - ytr)^2))
  testerr <- c(testerr, mean((xte[,1:i]%*%beta+intercept - yte)^2))
}
par(mfrow=c(1,3))
plot(2:100, rsq, xlab="No of Variables", ylab="R Squared", log="y")
abline(v=10, col="red")
plot(2:100, trainerr, xlab="No of Variables", ylab="Training Error", log="y")
abline(v=10, col="red")
plot(2:100, testerr, xlab="No of Variables", ylab="Test Error", log="y")
abline(v=10, col="red")
```

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
