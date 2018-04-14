---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
set.seed(12)
X0 <- matrix(c(1, 2, -1, 2, 2, -1, 2, 1), nrow=4, ncol=2, byrow = TRUE)
#center with scale
center_scale <- function(x) {
  scale(x, scale = FALSE)
}
center_scale(X0)
```
```{r}
#center with apply
center_apply <- function(x) {
  apply(x, 2, function(y) y - mean(x))
}
center_apply(X0)
```
```{r}
#using sweep function
center_sweep <- function(x, row.w = rep(1, nrow(x))/nrow(x)) {
  get_average <- function(v) sum(v * row.w)/sum(row.w)
  average <- apply(x, 2, get_average)
  sweep(x, 2, average)
}
center_sweep(X0)
```
```{r}
#using colMeans function
center_colmeans <- function(x) {
  xcenter = colMeans(x)
  x - rep(xcenter, rep.int(nrow(x), ncol(x)))
}
center_colmeans(X0)
```
```{r}
#using center matrix operator
center_operator <- function(x) {
  n = nrow(x)
  ones = rep(1, n)
  H = diag(n) - (1/n)*(ones %*% t(ones))
  H %*% x
}

center_operator(X0)
```
```{r}
#using mean substraction
center_mean <- function(x) {
  ones = rep(1, nrow(x))
  x_mean = ones %*% t(colMeans(x))
  x - x_mean
}
center_mean(X0)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

