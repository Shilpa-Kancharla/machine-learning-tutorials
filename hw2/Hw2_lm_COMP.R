---
title: "STOR 565 Spring 2018 Homework 2"
author: "Shilpa Kancharla"
output:
  pdf_document: default
  html_document: default
subtitle: \textbf{Due on 01/31/2018 in Class}
header-includes: \usepackage{amsgen,amsmath,amstext,amsbsy,amsopn,amssymb,mathabx,amsthm,bm,bbm}
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
library("ISLR")
library(MASS)
library(DAAG)
library(boot)

```
\theoremstyle{definition}
\newtheorem*{hint}{Hint}

\theoremstyle{remark}
\newtheorem*{rmk}{Remark}

*Remark.* This homework aims to help you go through the necessary preliminary from linear regression. Credits for **Theoretical Part** and **Computational Part** are in total 100 pt. For **Computational Part**, please complete your answer in the **RMarkdown** file and summit your printed PDF homework created by it.

## Computational Part

1. (*35 pt*) Consider the dataset "Boston" in predicting the crime rate at Boston with associated covariates.
```{r Boston}
head(Boston)
```
Suppose you would like to predict the crime rate with explantory variables

* `medv`  - Median value of owner-occupied homes
* `dis`   - Weighted mean of distances to employement centers
* `indus` - Proportion of non-retail business acres

Run with the linear model
```{r lm}
mod1 <- lm(crim ~ medv + dis + indus, data = Boston)
summary(mod1)
```
Answer the following questions.

(i) What do the following quantities that appear in the above output mean in the linear model? Provide a breif description.

    + `t value` and `Pr(>|t|)` of `medv`
    
    **Answer:** The 't value' is a measure of how many standard deviations our coefficient estimate is away from 0. We want it to be as far away as possible from 0 because that means we can reject the null hypothesis (in this case, we can declare the that relationship between the variables crim to medv, dis and indus is due to more than chance). 'Pr(>|t|)' refers to the probability that you get a t-value as high or higher than the observed value when the null hypothesis is true. A small 'Pr(>|t|)' means that it is unlikely we will observe a relationship between variables due to chance. Three asterisks represents a highly significant p-value. In the crime data set we are working with, the three asterisks would indicate there is a strong relationship between crim to medv and dis, but perhaps not indus (it also has the lowest t-value in the summary).

    + `Multiple R-squared`
    
    **Answer:** The R-squared statistic provides a measure of how well the model is fitting the actual data. It always lies between 0 and 1; if it closer to 0, the regression does not explain the variance in the response variable but if it is closer to 1, it does explain the observed variance in the response variable). This shows how closely the data fits the regression calculated. In this case, Mutliple R-squred = 0.2404, so roughly 24% of the variance found in the response variable (medv, indus and dis) can be explained by the predictor variable (crim). 
    
    ***
    + `F-statistic`, `DF` and corresponding `p-value`

    **Answer:** The F-statistic indicates whether there is a relationship between our predictor and response variables. The further the F-statistic is from 1, the better the relationship is. Here, the F-statistic value is 52.95 which is quite large, indicating a decent relationship between the data. 'DF' means degrees of freedom, meaning the number of data points that went into the estimation of the parameters used after taking into account these parameters (restrictions). In our case, we had 502 degrees of freedom for the four parameters we observed: intercept and three slope terms for indus, medv and dis. The corresponding 'p-value' refers to the number between 0 and 1 that will allow us to reject or not reject the null hypothesis. A small p-value (less than 0.05) means that we can reject the null hypothesis, and we can reject the null hypothesis in this case that the relationship between crim to medv and dis, at least, were due to chance.
    
    ***
    
(ii) Are the following sentences True of False? Briefly justify your answer.

    + `indus` is not a significant predictor of crim, and we can drop this from the model.
    
    **Answer:** TRUE. It has a significance value greater than 0.05 and there are no asterisks next to the p-value corresponding to it..
    
    ***
    + `Multiple R-squared` is preferred to `Adjusted R-squared` as it takes into account all the variables.
    
    **Answer:** FALSE. In multiple regression analysis, the R-squared will always increase as more variables are included in the model. That's why the adjusted R-squared is the preferred measure as it adjusts for the number of variables considered, unlike the multiple R-squared.

    ***    
    + `medv` has a negative effect on the response.
    
    **Answer:** TRUE. The values associated with this variable are negative. 
    
    ***
    + Our model residuals appear to be normally distributed.
    
    \begin{hint}
      You need to access to the model residuals in justifying the last sentence. The following commands might help.
    \end{hint}
    ```{r, eval=FALSE}
    # Obtain the residuals
    res1 <- residuals(mod1)
    
    # Normal QQ-plot of residuals
    plot(mod1, 2)
    
    # Conduct a Normality test via Shapiro-Wilk and Kolmogorov-Smirnov test
    shapiro.test(res1)
    ks.test(res1, "pnorm")
    ```

    **Answer:** FALSE. This is a non-normal distribution because some of the plotted points are not even close to the regression line. This distribution is definitely skewed to the right.  

    ***
    
2. (*35 pt*, Textbook Exercises 3.10) This question should be answered using the `Carseats` data set.

```{r}
head(Carseats)
summary(Carseats)
carseat.fit <- lm(Sales ~ Price + Urban + US, data=Carseats)
summary(carseat.fit)
abs(summary(carseat.fit)$coef[2, 1]) * 1000
abs(summary(carseat.fit)$coef[3, 1]) * 1000
abs(summary(carseat.fit)$coef[4, 1]) * 1000
carseat.fit2 <- lm(Sales ~ Price + US, data=Carseats)
summary(carseat.fit2)
confint(carseat.fit2)
```

(a) Fit a multiple regression model to predict `Sales` using `Price`, `Urban`, and `US`.

**Answer:** Please see above code with call "carseat.fit <- lm(Sales ~ Price + Urban + US, data=Carseats)" and "summary(carseat.fit)"

***

(b) Provide an interpretation of each coefficient in the model. 

**Answer:** Based on the coefficients given in the summary, on average, for every dollar increase in price the sales decrease by 54.45 units (found using ##abs(summary(fit)$coef[2,1]) * 1000). An urban store location and the US have a statistically significant relationship to sales. If the location is urban, the average sale is 21.92 units less than in a rural location. Likewise, if the unit sale in the US is 1200.57 units less than a non-US store.

***

(c) Write out the model in equation form, being careful to handle the qualitative variables properly.

**Answer:** Sales = 13.04 - 0.05Price - 0.02UrbanYes + 1.20USYes + epsilon

***

(d) For which of the predictors can you reject the null hypothesis $H_0 : \beta_j = 0$?

**Answer:** The null hypothesis can be rejected for US and Price.

***

(e) On the basis of your response to the previous question, fit a smaller model that only uses the predictors for which there is evidence of association with the outcome.

**Answer:** Please see above code with call "carseat.fit2 <- lm(Sales ~ Price + Urban + US, data=Carseats)" and "summary(carseat.fit2)"

***

(f) How well do the models in (a) and (e) fit the data?

**Answer:** The smaller model is better because the adjusted R-squared value is higher than in the larger model, indicating better fit. 23.54% of the variability is explained by the model according to the adjusted R-squared value.

***

(g) Using the model from (e), obtain 95% confidence intervals for the coefficient(s).

**Answer:**  Please see above with code "confint(carseat.fit2)"

***

(h) Using the leave-one-out cross-validation and 5-fold cross-validation techniques to compare the performance of models in (a) and (e). What can you tell from (f) and (h)?

**Hint.** Functions `update` (with option `subset`) and `predict`.

**Answer:** After performing the leave-one-out cross validation for the model from (a), the cross validation error was found to be 6.168591 and for the five-fold cross validation it was found to be 6.214894. For the model from part (e), the leave-one-out cross validation has an error of 6.140634 and the five-fold cross validation has an error of 6.141133. In part (f), we say that the smaller model is a better fit for the data, and part (h) further corroborates that the smaller model (fit2) is better as we produce lower error in the cross validation analysis. This was found using the code:

##cv.glm(Carseats, carseat.fit)
##cv.glm(Carseats, carseat.fit, K=5)
##cv.glm(Carseats, carseat.fit2)
##cv.glm(Carseats, carseat.fit2, K=5)

***