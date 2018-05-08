# Questions to Review

## Homework 2

### Theory 2

I collect a set of data (n = 100 observations) containing a single predictor and a quantitative response. I then fit a linear regression model to the data, as well as a separate cubic regression, i.e., Y = β0 + β1X + β2X2 + β3X3 + ε.

(a) Suppose that the true relationship between X and Y is linear, i.e. Y = β0 + β1X + ε. Consider the training residual sum of squares (RSS) for the linear regression (noticing that MSE = SSE/n in this case), and also the training RSS for the cubic regression. Would we expect one to be lower than the other, would we expect them to be the same, or is there not enough information to tell? Justify your answer.

(b) Answer (a) using test rather than training RSS.

(c) Suppose that the true relationship between X and Y is not linear, but we don’t know how far it is from linear. Consider the training RSS for the linear regression, and also the training RSS for the cubic regression. Would we expect one to be lower than the other, would we expect them to be the same, or is there not enough information to tell? Justify your answer.

(d) Answer (c) using test rather than training RSS.

### Computation 2

This question should be answered using the `Carseats` data set.

(a) Fit a multiple regression model to predict `Sales` using `Price`, `Urban`, and `US`.

(b) Provide an interpretation of each coefficient in the model.

(c) Write out the model in equation form, being careful to handle the qualitative variables properly.

(d) For which of the predictors can you reject the null hypothesis H0 : βj = 0?

(e) On the basis of your response to the previous question, fit a smaller model that only uses the predictors for which there is evidence of association with the outcome.

(f) How well do the models in (a) and (e) fit the data?

(g) Using the model from (e), obtain 95% confidence intervals for the coefficient(s).

(h) Using the leave-one-out cross-validation and 5-fold cross-validation techniques to compare the perfor- mance of models in (a) and (e). What can you tell from (f) and (h)?

## Homework 3

### Theory 1

Consider the ridge regression with tuning parameter λ = 0 and the constrained version of LASSO with tuning parameter s >= 0. As λ and s increase from 0 respectively, indicate which of the following is correct for: 

(a) training RSS, (b) test RSS, (c) variance, and (d) (squared) bias. Justify your answer.

(i) Increase initially, and then eventually start decreasing in an inverted U shape. 

(ii) Decrease initially, and then eventually start increasing in a U shape.

(iii) Steadily increase. 

(iv) Steadily decrease. 

(v) Remain constant.

### Theory 2

### Computation 1

## Homework 4

### Theory 1

### Theory 3

**Suppose we collect data for a group of students in a statistics class with variables X1 = hours studied, X2 = undergrad GPA and Y = receive an A. We fit a logistic regression and produce estimated coefficient, β^0 = -6, βˆ1 = 0.05, βˆ2 = 1.**

**(a) Provide an interpretation of each coefficient in the model. Note that β^0 corresponds to an additional intercept in the model.**

**(b) Estimate the probability that a student whoe studies for a 40 hours and has an undergrad GPA of 3.5 gets an A in the class**

**(c) How many hours would the student in part (b) need to study to have a 50% chance of getting an A in the class?**

### Theory 4

**(a) If the Bayes decision boundary is linear, do we expect LDA or QDA to perform better on the training set? On the test set?**

QDA will probably perform better on the training set because of the high flexibility, thus leading to a closer fit (lower bias). However, on the test set, we cannot make any further assumptions unless we know more about about the nature of the relationship of the predictors and the response. Even though the Bayes decision boundary may be linear, the underlying distributional relationships may not be Gaussian. Therefore, neither LDA nor QDA fits into the framework.

**(b) If the Bayes decision boundary is nonlinear, do we expect LDA or QDA to perform better on the training set? On the test set?**

Nonlinearity does not imply a quadratic boundary and we do not know if this setting holds up the Gaussian assumptison of QDA for the test set.

**(c) In general, as the sample size *n* increases, do we expect the test prediction accuracy of QDA relative to LDA to improve, decline, or be unchanged? Why?**

We would expect the accuracy of QDA to improve relative to LDA to improve as the sample size *n* increases, because a more flexible method will yield a less biased model while the variance from the training set would be vanishing as n approaches infinity.

**(d) True or False: Even if the Bayes decision boundary for a given problem is linear, we will probably achieve a superior test error test error rate using QDA rather than LDA because QDA is flexible enough to model a linear decision boundary. Justify your answer.**

False. QDA could overfit the model and lead to a higher test error. It would lead to a higher variance from the training set, yielding a higher test error rate than LDA.

### Computation 1

## Homework 5

### Theory 2

### Theory 3

### Computation 1

## Homework 6

### Theory 1

### Theory 3

### Computation 1 

### Computation 2

## Homework 7 

### Theory 1

### Theory 3

### Computation 2
