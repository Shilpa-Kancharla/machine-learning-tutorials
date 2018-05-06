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

### Control Model Complexity
- Restriction methods: decide beforehand to limit the class of functions
  - Additive model
- Selection methods: adaptively scan the dictionary and include only "useful" basis functions
  - "Variable selection"
  - Stagewise greedy approaches like CART, MARS, boosting
- Regularization methods: use entire dictionary but restrict coefficients
  - Ridge, LASSO, smoothing splines

## Splines
- Piecewise polynomial function: divide the domain of x into continuous intervals and fit separate polynomials in each interval
  - Regresion spline (fixed knots spline)
  - Smoothing spline
  - Thin plate spline
- Advantages: flexible, local smoothing
- Knots: places where piecewise functions meet
- Cubic spline is the lowest order spline for which knot-discontinuity is not visible to human eyes.
- **B-Splines**: alternative bases for polynomial splines
  - Each basis function is nonzero ovre at most M consecutive intervals (local support)
  - Resulting design matrix is banded

### Generating B-Spline Basis in R

`bs(x, df = NULL, knots = NULL, degree = 3, intercept = F, boundary.knots)`

Generates the B-spline basis matrix for a polynomial spline.
- df: degrees of freedom
- knots: choose (interior) df-degree-1 (intercept) knots at quantiles of x
- degree: degree of piecewise polynomial; default 3 (cubic splines)
- intercept: if TRUE, an intercept is included in the basis; default FALSE

Returns a matrix of dimension n by df, df = length(knots) + 3 + 1 (if intercept)
- `bs(x, df = 7)` gives an n by 7 matrix, a basis matrix evaluated at n observations of x. Four knots are (20, 40, 60, 80th) quantiles of x.
- `bs(x, degree = 1, knots = c(0.2, 0.4, 0.5=6))` generates n by 4 matrix for linear splines, with 3 interior knots. 

In R, `library(splines)` 
1. Specify the number of basis functions or degrees of freedom.
2. Let the data decide the positions of the knots (default)

### Boundary Effects
- The behavior of polynomial fit tends to be erratic near the boundaries.
- The piecewise polynomial fit beyond the boundary knots behave more wildly than the corresponding global polynomials in that region.

## Natural Cubic Splines
- Additional constraints: the funciton be linear beyond the boundary knots
- Frees up four degrees of freedom (two constraints in each boundary region), which can be spent in the interior region
- The price is bias near the boundaries.
- Assuming the function is linear near the boundaries (where there is less information anyway) is often considered reasonable.

### R for Natural Cubic Splines (NCS)

Generate the B-spline basis matrix for a natural cubic spline 

`ns(x, df = NULL, knots = NULL, intercept = F, Boundary.knots = range(x))`

- Choose df-1-intercept interior knots at quantiles of x; 
- Returns a matrix of dimension n by df, `df = length(knots) + 1 + 1` (if intercept)

## Regression Splines

One needs to specify 
- the order of the spline
- the number of knots
- the location of knots

## Smoothing Splines

Motivation
- Use a maximal set of knots
- Avoid the knot selection problem

### Smoothing Splines in R

In R, we can specify lambda or the degrees of freedom 

`smooth.spline(x, y = NULL, w = NULL, df, spar = NULL, cv = FALSE)`

## GAMs

- Calculate separate f for each X and then add them all together
- There are different ways of representing f_j
- One could use a polynomial as in polynomial regression
- One could use a smoothing kernel
- Most common approach we use is a spline

Pros
- By allowing one to fit a nonlinear f_j to each X_j we can automatically model nonlinear relationships that standard linear regression will miss. 
- We can potentially make more accurate predictions.
- Because we are fitting an additive model, we can still examine the effect of each X_j on Y individually while holding all the other X's fixed. Hence if we are interested in inference, GAM are still a good approach to use. 

Cons
- The model is restricted to be additive
- Thus our fit is not completely nonlinear
- For example, a simple interaction between X_1 and X_2 of the form Y = (X_1)(X_2) can't automatically be modeled using GAM (of course still manually add in an interaction term just as with linear regression).

### R Functions for GAMs

- Packages `gam mgcv`
- Function `gam`
- The `gam` represents the smooth functions using penalized regression splines, given the number basis functions used.
- The `gam` solves the smoothing parameter estimation problem by using the Generalized Cross Validation (GCV) criterion.
