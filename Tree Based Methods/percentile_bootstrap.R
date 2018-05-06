#Potential disaster for non-symmetric sample distributions

calc_statistic <- function(x) {
  return(mean(x))
}

mu_star <- mean(X)

mu_star_star <- replicate(10000, calc_statistic(sample(X, replace = TRUE)))

U <- quantile(mu_star_star, 0.975)
L <- quantile(mu_star_star, 0.025)

CI <- c(L,U)
