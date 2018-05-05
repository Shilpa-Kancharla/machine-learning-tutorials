## Linear Regression in High Dimensions

- Variable Pre-Selection: simplest, most straightforward method

1. Choose a small set of variables, say the q variables that are most correlated with the response, where q < n and q < p
2. Use least squares to fit a model predicting y using only these q variables
3. How many variables to use? 
    1. We need a way to choose q, the number of variables used in the regression model.
    2. For a range of values of q, we can perform the validation set approach, LOOCV, or K-Fold CV in order to estimate the test error.
    3. Then choose the value of q for which the estimated test error is smallest.
4. Estimating the test error for a given q
    1. Split the observations into a training set and a validation (test) set.
    2. Using the training set only: 
        1. Identify the q variables most associated with the response 
        2. Use least squares to fit a model predicting y using those q variables
        3. Let the betas be the resulting coefficients
    3. Use the beta coefficients obtained on the training set to predict response on validation set, and compute the validation set MSE
5. Better Approach 
    1. Just because a bunch of variables are correlated with the response doesn’t mean that when used together in a linear model, they will predict the response well
    2. Pick the q variables that best predict the response (not just because they are correlated)
6. How to choose between models? 
    1. Training set MSE is generally an underestimate of the test MSE (MSE = RSS/n)
    2. Training RSS and training set R squared cannot be used to select from among a set of models with different number of variables
    3. Validation and CV is the best for this purpose, but they are computationally intensive or may not work on a sample size too small
    4. An alternative is to adjust the training-based measures so that they can better estimate the test error

- Best Subset Selection: we would like to consider all possible using a subset of the p predictors
    - We would like to consider all 2 to the power p possible models
    - Computationally expensive, consider forward stepwise regression

- Forward stepwise regression
    1. Use least squares to fit p univariate regression models, and select the predictor corresponding to the best model (training set MSE)
    2. Use least squares to fit p - 1 models containing that one predictor, and each of the p - 1 other predictors. Select the predictors in the best two-variable model.
    3. Use least squares to fit p - 2 models containing those two predictors, and each of the p - 2 other predictors. Select the predictors in the best three-variable model. 
    4. And so on.
    5. This gives us a nested set of models.
    6. Which value of q is the best? 
        1. This procedure traces out a set of models, containing between 1 and p variables. 
        2. The one that minimizes test error. 
    7. Drawbacks
        1. Forward stepwise selection isn’t guaranteed to given you the best model containing q variables. 
        2. To get the best model with q variables, you’d need to consider every possible one; computationally intractable. 
        3. If you find a better model with one variable first, it is possible that you wouldn’t be able to consider a better model with two variables. 
        
    8. Procedure
        1. Split data into a training set and a validation set. 
        2. Perform forward stepwise on the training set, and identify the value of q corresponding to the best-performing model on the validation set. 
        3. Then perform forward stepwise selection in order to obtain a q-variable model on the full dataset. 
    9. Bottom line: we estimate the test error in order to choose the correct level of model complexity.  Then we refit the model on the full dataset. 

- Ridge Regression & LASSO Regression: control model complexity by using an alternative to least squares, by shrinking the regression coefficients. This is also known as regularization or penalization. 
    - Crazy Coefficients
        - When p > n, the least squares regression coefficients are highly variable because some of the variables are highly correlated with each other. 
        - Why does correlation matter? 
            - Suppose that X_1 and X_2 are highly correlated with each other (assume X_1 = X_2 for the sake of this argument)
        - Bottom line: when there are too many variables, the least squares coefficients can get crazy. This is response for poor test error, and amounts too much model complexity. 
    1. Ridge Regression
        1. Perform ridge regression for a very fine grid of lambda values
        2. Use cross validation or the validation set approach to select the optimal value of lambda, that is, the best level of model complexity
        3. Perform ridge on the full dataset, using that value of lambda.
        4. Drawbacks
            1. Ridge regression is a simple idea and has a number of attractive properties: for instance, you can continuously control model complexity through the tuning parameter lambda
            2. But it suffers in terms of model interpretability, since the final model contain all p variables, no matter what. 
            3. The LASSO involves performing a little tweak to ridge regression so that the resulting model contains mostly zeros. 
            4. In other words, the resulting model is sparse. We say that the LASSO performs feature selection
    2. LASSO Regression: performs feature selection, resulting in a sparse model. Involves performing tweak to ridge regression so that the resulting model contains mostly zeros. 
        1. Lambda is a nonnegative tuning parameter that controls model complexity. 
        2. When lambda is zero, we get least squares.
        3. When lambda is very large, we get beta = 0. 
        4. Unlike ridge regression, LASSO will give some coefficients exactly equal to zero for intermediate values of lambda.
        5. Perform LASSO for a very fine grid of lambda values.
        6. Use CV or the validation set approach to select the optimal value of lambda - that is, best level of model complexity.
        7. Perform the LASSO on the full dataset, using that value of lambda.

So far we have seen two approaches that select subsets of the features and fit a least squares model: 
- Variable Pre-Selection
- Forward Stepwise Selection

And we have seen two approaches that fit a shrunken model instead of using least squares: 
- Ridge Regression
- LASSO Regression

Now we observe principal components regression (PCR), that first finds a low-dimensional subspace of the data and then fits a model on that low-dimensional subspace, using least squares. 

- Principal Components Regression (PCR): 
    - Our data consists of n observations in a p-dimensional space
    - However, not all of those p dimensions are equally useful, especially when p >> n. 
    - Many are either completely redundant (correlated features) or uninformative (noise features)
    - Can we find a low-dimensional representation of the variables that captures most of the variability in the data? 
    - This is a dimension reduction approach. 
    - PCR doesn’t yield feature selection - all of the original predictors are involved in the final model. 
    - But when M is small, then PCR can avoid overfitting and can give good results.
    - Choose M by cross validation or validation set approach. 
    - With M = p, we just get least squares regression: no dimension reduction occurs. 
    - Turns out that PCR is closely related to ridge regression.
    - Shortcoming of PCR: the first M principal components are guaranteed to explain a lot of the variation in the data, but that doesn’t mean that they are predictive of the response.

