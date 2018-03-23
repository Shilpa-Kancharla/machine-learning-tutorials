---
title: "STOR 565 Spring 2018 Homework 1"
author: "Shilpa Kancharla"
header-includes:
- \usepackage{amsgen,amsmath,amstext,amsbsy,amsopn,amssymb,mathabx,amsthm,bm,bbm}
- \usepackage[labelsep=space]{caption}
output:
  pdf_document: default
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
\theoremstyle{definition}
\newtheorem*{hint}{Hint}
\newtheorem*{pchln}{Punchline}

\theoremstyle{remark}
\newtheorem*{rmk}{Remark}

**Exercise 1.** *(5 pt)* Using the `c`, `rep` or `seq` commands, create the following 6 vectors:

$x1 = (2, .5, 4, 2)$;

$x2 = (2, .5, 4, 2, 1, 1, 1, 1)$;

$x3 = (1, 0, -1, -2)$;

$x4 = ("\text{Hello}", "\ ", "\text{World}, "!", "\text{Hello World!}")$;

**Hint.** Try `paste` function.

$x5 = (\text{TRUE}, \text{TRUE}, \text{NA}, \text{FALSE})$;

**Hint.** Check `?NA` and `class(NA)` to learn more about the missing value object `NA`.

$x6 = (1, 2, 1, 2, 1, 1, 2, 2)$.

```{r, eval=TRUE}
x1 <- c(2, .5, 4, 2);
x2 <- c(2, .5, 4, 2, rep(1, 4));
x3 <- seq(1, -2, -1);
x4 <- paste("Hello"," ", "World", "!", "Hello World!", sep=" ", collapse = NULL);
x5 <- c(rep(TRUE,2), NA, TRUE);
x6 <- c(1, 2, 1, 2, rep(1, 2), rep(2, 2));
x1
x2
x3
x4
x5
x6
```
**Exercise 2.** *(5 pt)* Using `matrix`, `rbind` and `cbind`, create
$$ \textbf{X} = 
\begin{pmatrix} 
1 &  2 &  3  &  4\\
1 &  0 & -1  & -2\\
2 & .5 &  4  &  2\\
1 &  1 &  1  &  1
\end{pmatrix}
$$

```{r, eval=TRUE}
A = matrix(c(1,1,2,1), 4, 1)
B = matrix(c(2,0,.5,1), 4, 1)
C = matrix(c(3, -1, 4, 1), 4, 1)
D = matrix(c(4, -2, 2, 1), 4, 1)
X <- cbind(A, B, C, D)
X
 
```

```{r, results='hide'}
students <- data.frame( id      = c("001", "002", "003"), # ids are characters
                        score_A = c(95, 97, 90),          # scores are numericss
                        score_B = c(80, 75, 84))       
students
```
 

**Exercise 3.** *(5 pt)* Applying the conditional selection technique (without using `subset`), extract the record of $003$ in `students`.

```{r, eval=TRUE}
students3 <- students[3,]
students3
```

One can also create a matrix or a legitimate list first and then convert it into a data.frame as follows.
```{r, results='hide'}

scores <- matrix(c(95, 97, 90, 80, 75, 84), 3, 2)
scores <- data.frame(scores)
colnames(scores) <- c("score_A", "score_B")
id <- c("001", "002", "003")
students1 <- cbind(id, scores)
students2 <- data.frame( list( id      = c("001", "002", "003"),
                               score_A = c(95, 97, 90),
                               score_B = c(80, 75, 84))       
                         )
```

**Exercise 4.** *(10 pt)* Create a data.frame object to display the calendar for Jan 2018 as follows.

```{r, eval = TRUE}
## Sun Mon Tue Wed Thu Fri Sat
##      NY   2   3   4   5   6
##   7   8   9  10  11  12  13
## MLK  15  16  17  18  19  20
##  21  22  23  24  25  26  27
##  28  29  30  31            
calendar <- matrix(c(" ", 7, "MLK", 21, 28, "NY", 8, 
                     15, 22, 29, 2, 9, 16, 23, 30, 3, 
                     10, 17, 24, 31, 4, 11, 18, 25, " ", 
                     5, 12, 19, 26, " ", 6, 13, 20, 27, " "), 5, 7)
calendar <- data.frame(calendar)
colnames(calendar) <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
print(calendar, row.names=FALSE)
```
## Factors

Factor is a special data structure in **R** in representing categorical variables and facilitating the data labels and subgroups. It's basically a character vector that keeps track of its distinct values called levels. Consider the longitudinal layout of the previous score table.

```{r, results='hide'}
id        <- rep(c("001","002","003"), 2)
subj      <- rep(c("A","B"), each = 3)
score     <- c(95, 97, 90, 80, 75, 84)
students3 <- data.frame(id, subj, score)  # try cbind(id, subj, score) to see the difference

# students3$id and students3$subj are automatically formatted as factors
class(students3$id)
levels(students3$id)

class(students3$subj)
levels(students3$subj)

# combind student 003 with 002 via level rename
students4 <- students3    # work on a copy in case of direct modification of students3
levels(students4$id)[3] <- "002"
levels(students4$id)
students4
```

**Exercise 5.** *(5 pt)* Create a factor variable `grade` in `students3`, where the `score` variable is divided into $[90,100]$, $[80,89)$ and $[0,79)$ corresponding to A, B and C in `grade` respectively.

```{r, eval=TRUE}
grades <- cut(students3$score, breaks = c(100, 89, 79, 0), labels=c("C","B","A"))
grades
students3 <- data.frame(id, subj, score, grades)
students3
```

## Operations and Functions

**Exercise 6.** *(5 pt)* Without using the `var` and `scale` functions, compute the sample covariance `X.var` of the data matrix `X` as in **Exercise 2.**

```{r eval=TRUE}
k <- ncol(X) #number of variables
n <- nrow(X) #number of subjects
X_mean <- matrix(data=1,nrow=n) %*% cbind(mean(A),mean(B),mean(C),mean(D)) #creates means for each column
H <- X - X_mean #creates a difference matrix
X.var <- (n-1)^-1 * t(H) %*% H #creates covariance matrix
X.var
cov(X)
```

**Exercise 7.** *(10 pt)* Create a variable `score.mean` in `students3`, taking value as the mean score among students who have the same `subj` value.

```{r eval=TRUE}
A_mean <- mean(score[students3$subj == "A"])
B_mean <- mean(score[students3$subj == "B"])
score.mean <- c(A_mean,B_mean)
score.mean
```

### Writing your own functions

**Exercise 8.** *(15 pt)* Write a function `bisect(f, lower, upper, tol = 1e-6)` to find the root of the univariate function `f` on the interval [`lower`, `upper`] with precision tolerance $\le$ `tol` (defaulted to be $10^{-6}$) via bisection, which returns a list consisting of `root`, `f.root` (`f` evaluated at `root`), `iter` (number of iterations) and `estim.prec` (estimated precision). Apply it to the function
$$f(x) = x^3 - x - 1$$
on $[1,2]$ with precision tolerance $10^{-6}$. Compare it with the built-in function `uniroot`.

```{r, eval=TRUE}
bisection <- function(f, a, b, n = 1000, tol = 1e-6) {
  if (!(f(a) < 0) && (f(b) > 0)) {
    stop('signs of f(a) and f(b) differ')
  } else if ((f(a) > 0) && (f(b) < 0)) {
    stop('signs of f(a) and f(b) differ')
  }
  
  for (i in 1:n) {
    c <- (a + b) / 2 # Calculate midpoint
    if ((f(c) == 0) || ((b - a) / 2) < tol) {
      return(c)
    }
    ifelse(sign(f(c)) == sign(f(a)), 
           a <- c,
           b <- c)
  }
  print('Too many iterations')
}
f <- function(x) {x^3 - x -1} #function
a <- 1 #lower
b <- 2 #upper
tol <- 1e-6 #tolerance
n <- 10000 #iterations
bisection(f, a, b, n, tol)
```

**Exercise 9.** *(15 pt)* Without using `cor`, compute the sample correlation matrix `X.cor` from `X.var` in **Exercise 6.** Output `X.cor` to a text file "X_cor.txt" which displays as in Table \ref{table:X_cor}. Then input "X_cor.txt" in **R** and reproduce the correlation matrix `X.cor1`.

**Hint.** 1) Functions `round` and `lower.tri`; 2) the `NA` trick; 3) options `sep = "\t", col.names = NA`.

\begin{table}
  \center
  \begin{tabular}{lllll}
      & V1 & V2    & V3   & V4   \\
  V1  &    & -0.29 & 0.68 & 0.2  \\
  V2  &    &       & 0.51 & 0.88 \\
  V3  &    &       &      & 0.86 \\
  V4  &    &       &      &       
  \end{tabular}
  \caption{}
	\label{table:X_cor}
\end{table}

```{r eval=TRUE}
##       V1    V2   V3   V4
## V1  1.00 -0.29 0.68 0.20
## V2 -0.29  1.00 0.51 0.88
## V3  0.68  0.20 1.00 0.86
## V4  0.51  0.88 0.86 1.00
value <- sqrt(diag(X.var))
value1 <- solve(diag(value))
X.cor <- value1 %*% X.var %*% value1
X.cor
#Output as text file
write.table(X.cor, file="X_cor.txt", sep="\t", col.names=NA, quote=FALSE)
X.cor1 <- read.table("X_cor.txt", header=FALSE, sep = "\t")
X.cor1
cov2cor(X.var)
```

**Exercise 10.** *(10 pt)* `iris` is a built-in dataset in **R**. Check `?iris` for more information. Randomly divide `iris` into five subsets `iris1` to `iris5` stratified to `iris$Species` (namely, the proportion of `iris$Species` among different levels remains identical across all subsets).
```{r eval=TRUE}
set.seed(5)
irisnew <- split(iris, sample(1:5))
iris1 <- irisnew[1]
iris2 <- irisnew[2]
iris3 <- irisnew[3]
iris4 <- irisnew[4]
iris5 <- irisnew[5]
iris.5fold <- list(iris1, iris2, iris3, iris4, iris5)
iris.5fold
```

**Exercise 11.** *(15 pt)* Reproduce the code that generates the following plot about `Sepal.Length` in `iris`.

```{r echo=TRUE}
knitr::include_graphics("Iris_Sepal_Length.pdf")
```

**Hint.** 1) Most decorations are based on defaults in `hist` with `ylim = c(0, 1.3)`; 2) let `h` be the object resulted by `hist` and set `xlim = range(h$breaks)`; 3) set `cex = 0.5` in `legend`; 4) use `curve` function in plotting the normal density with specified parameters.

```{r eval=TRUE}

setosa_length <- iris$Sepal.Length[iris$Species == "setosa"]
hist(setosa_length, main = "Histogram of Sepal_Length", 
     xlab = "Sepal_Length Species = setosa", freq=FALSE)
x <- seq(4, 6, length.out=100)
y <- with(iris, dnorm(x, mean(setosa_length), sd(setosa_length)))
lines(x, y, col="red")
lines(density(setosa_length), col="blue")
legend("topright", 5, 1.3, legend=c("Normal Density", "Kernel Density"), 
       col=c("red", "blue"), lty=1:2, cex=0.5)

versicolor_length <- iris$Sepal.Length[iris$Species == "versicolor"]
hist(versicolor_length, main = "Histogram of Sepal_Length", 
     xlab = "Sepal_Length Species = versicolor", freq=FALSE)
x <- seq(4, 8, length.out=100)
y <- with(iris, dnorm(x, mean(versicolor_length), sd(versicolor_length)))
lines(x, y, col="red")
lines(density(versicolor_length), col="blue")
legend("topright", 5, 2, legend=c("Normal Density", "Kernel Density"), 
       col=c("red", "blue"), lty=1:2, cex=0.5)

virginica_length <- iris$Sepal.Length[iris$Species == "virginica"]
hist(virginica_length, main = "Histogram of Sepal_Length", 
     xlab = "Sepal_Length Species = virginica", freq=FALSE)
x <- seq(4, 8, length.out=100)
y <- with(iris, dnorm(x, mean(virginica_length), sd(virginica_length)))
lines(x, y, col="red")
lines(density(virginica_length), col="blue")
legend("topright", 5, 2, legend=c("Normal Density", "Kernel Density"), 
       col=c("red", "blue"), lty=1:2, cex=0.5)

```