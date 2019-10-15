#' ---
#' title: "Demo: Functions"
#' subtitle: "NIHES BST02"
#' author: "Nicole Erler, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

hello <- function(name) {
  paste0("Hello ", name, ", how are you?")
}

hello('Nicole')




#' Re-inventing the wheel
mymean1 <- function(x) {
  mean(x)
}

mymean2 <- function(x) {
  sum(x)/length(x)
}

# simulate a vector of random numbers:
x <- rnorm(50)

mean(x)
mymean1(x)
mymean2(x)

# t-test
my_t_test <- function(x) {
  # calculate the standard error
  se <- sd(x)/sqrt(length(x))
  
  # calculate the test statistic
  stat <- mean(x)/se
  
  # obtain the probability under the null-hypthesis (t-distribution)
  pt(stat, df = length(x) - 1) * 2
}

t.test(x)
my_t_test(x)


my_t_test2 <- function(x) {
  # calculate the standard error
  se <- sd(x)/sqrt(length(x))
  
  # calculate the test statistic
  stat <- mean(x)/se
  
  # obtain the probability under the null-hypthesis (t-distribution)
  pval <- pt(stat, df = length(x) - 1) * 2
  
  return(list(mean = mean(x), std.err = se, stat = stat, "p-value" = pval))
}

my_t_test2(x)

visualise_t_test <- function(x) {
  res <- my_t_test2(x)
  
  x0 <- seq(from = -4, to = 4, length = 100)
  plot(x0, dt(x0, df = length(x)-1), type = 'l', xlab = "mean of x", ylab = "density")
  abline(v = res$stat, lty = 2)
  legend(x = 'topleft', legend = 'value of the\ntest statistic', lty = 2, col = 1, bty = 'n')
}

visualise_t_test(x)


visualise_t_test2 <- function(x, emp = TRUE) {
  res <- my_t_test2(x)
  
  x0 <- seq(from = -4, to = 4, length = 100)
  plot(x0, dt(x0, df = length(x)-1), type = 'l', xlab = "mean of x", ylab = "density")
  abline(v = res$stat, lty = 2)
  legend(x = 'topleft', legend = 'value of the\ntest statistic', lty = 2, col = 1, bty = 'n')
  
  if (emp == TRUE)
    lines(density(x), col = 2)
}
