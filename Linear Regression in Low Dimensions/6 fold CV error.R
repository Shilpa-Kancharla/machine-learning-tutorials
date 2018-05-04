---
title: "R Notebook"
output: html_notebook
---

This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Cmd+Shift+Enter*. 

```{r}
xtr <- matrix(rnorm(100*100), ncol = 100)
beta <- c(rep(1,10), rep(0,90))
ytr <- xtr%*%beta + rnorm(100)
cv.err <- NULL
for (i in 2:50) {
  dat <- data.frame(x=xtr[,1:i],y=ytr)
  mod <- glm(y~.,data = dat)
  cv.err <- c(cv.err, cv.glm(dat, mod, K = 6)$delta[1])
}
plot(2:50, cv.err, xlab = "Numbr of Variables", ylab = "6-Fold CV Error", log = "y")
abline(v=10, col="red")
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

