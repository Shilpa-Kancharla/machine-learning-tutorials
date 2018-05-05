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
library(glmnet)
cv.out <- cv.glmnet(xtr, ytr, alpha = 0, nfolds = 5)
print(cv.out$cvm)
plot(cv.out)
cat("CV Errors", cv.out$cvm, fill = TRUE)
cat("Lambda with smallest CV Error", cv.out$lambda[which.min(cv.out$cvm)], fill = TRUE)
cat("Coefficients", as.numeric(coef(cv.out)), fill = TRUE)
sum((abs(coef(cv.out)) < 1e-8), fill = TRUE)
```

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Cmd+Option+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Cmd+Shift+K* to preview the HTML file). 

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.

