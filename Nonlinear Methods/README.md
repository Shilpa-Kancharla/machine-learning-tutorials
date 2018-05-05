# Nonlinear Methods

## Moving Beyond Linearity
- For regression models, we have mostly focused on linear models. 
- Linear models have significant advantages in terms of interpretation/inference.
- However, standard linear regression has significant limitations in terms of prediction power. 
- We have seen how to improve OLS using ridge regression and the LASSO etc. but we are still using a linear model which can only be improved so far

### Linear or Nonlinear Models? 

In regression problems, f(x) = E(Y|x) is typically nonlinear and non-additive in x. Why are linear models widely used? 
- Convenient and easy to fit
- Easy to interpret
- First-order Taylor approximation to f(x)
- When n is small and/or p is large, use linear models to avoid overfitting
- Nonlinear models are necessary for many applications

For nonlinear methods, we relax the linearity assumption while still attempting to maintain as much of the interpretability as possible. We will do this by examining very simple extensions like polynomial regression as well as more sophisticated approaches such as splines and GAM. 

### Drawbacks of Polynomial Regression

- Not flexible in practice, the same function form everywhere
- Individual observations have large influences on remote parts of the curve
- The polynomial degree cannot be controlled continuously
- Need more flexible basis functions

### Overcomplete Basis

Try to achieve more flexible representations for f(x). Use a dictionary consisting of a very large number of basis functions, far more than affordable 

- piecewise polynomials and splines
- wavelet bases

Need to control model complexity.
