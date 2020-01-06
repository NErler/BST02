#' ---
#' title: "Demo: Tests for continuous variables"
#' subtitle: "NIHES BST02"
#' author: "Nicole Erler, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---

#+  echo = FALSE
# This is not part of the demo. 
# It just allows the output to be wider (to make the html look nicer)
options(width = 105)


#-------------------------------------------------------------------------------
#' ## t-test
#' ### One-sample t-test
# make data:
x <- rnorm(250, mean = 20.5, sd = 4)

#' Test if the mean of `x` is equal to 0:
t.test(x)

#' Test if the mean of `x` is equal to 21:
t.test(x, mu = 21)

#' By default, a two-sided test is performed. To do a one-sided test, the argument
#' `alternative` can be set to `less` or `greater`:
t.test(x, mu = 21, alternative = 'less')
#' Note that the lower limit of the confidence interval became `-Inf`, because
#' we look at a one-sided test, and that the upper bound reduced compared to the
#' two sided-test.

#' The output we see is produced by the `print()` function that is automatically
#' called.
#' To access the elements of the test results separately:
testres <- t.test(x, mu = 21, alternative = 'less', conf.level = 0.975)
names(testres)
class(testres)
is.list(testres)
#' This means we can treat `testres` as a `list`:
testres$p.value
testres$conf.int


#' ### Two-samples t-test
y <- rnorm(250, mean = 20, sd = 2)

#' By default, the test assumes that the two samples have different variances
#' and that the samples are independent.
#' How can you know this?
#' It is written in the help file!
t.test(x, y)
t.test(x, y, var.equal = TRUE)

#' ### Paired-samples t-test
#' A t-test for a paired sample can be performed by setting the argument 
#' `paired = TRUE`:
t.test(x, y, paired = TRUE)
#' Again, we can change `mean` to test if the difference is different from that
#' value instead of testing for a difference equal to zero.

#' This is equivalent to performing a one-sampe t-test of the differences 
#' `x - y`:
t.test(x - y)

#' ### Using the formula specification
#' It is also possible to specify the test using a formula. This can be more
#' convenient when we have the data in a `data.frame`
dat <- data.frame(z = c(x, y),
                  group  = rep(c('x', 'y'), c(length(x), length(y))))

summary(dat)
t.test(z ~ group, data = dat)

#' or
t.test(z ~ group, data = dat, paired = TRUE)



#-------------------------------------------------------------------------------
#' ## Wilcoxon Test
#' ### Wilcoxon Signed Rank Test
wilcox.test(x, mu = 20)

#' The function `wilcox.test()` has similar arguments as `t.test()`
#' (`x`, `y`, `alternative`, `mu`, `paired`, `conf.level`).

#' Note that conidence intervals are only returned if `conf.int = TRUE`:
wilcox.test(x, conf.int = TRUE, mu = 20)

#' The additional argument `exact` controls if exact p-values and confidence
#' intervals are calculated or if the normal approximation is used. 
#' In the latter case, the argument `correct` determins if a continuity 
#' correction is applied.
wilcox.test(x, conf.int = TRUE, exact = TRUE, mu = 20) 

#' ### Wilcoxon Rank Sum Test
wilcox.test(x, y, correct = TRUE, conf.int = TRUE)

#' Like for the `t.test()`, we can also use a formula specification and the 
#' test output is of the same class, i.e., the p-value etc. can be accessed
#' like elements of a list.



#-------------------------------------------------------------------------------
#' ## Kruskal-Walis Rank Sum Test
#' This test is an extension to the Wilcoxon rank sum test to more than two groups

#' We can povide the data as a `list()`:
x <- list(x1 = rnorm(100, mean = 12, sd = 1.5),
          x2 = rnorm(100, mean = 11, sd = 2),
          x3 = rnorm(100, mean = 11.5, sd = 1.8))

kruskal.test(x)

#' or as a `data.frame` with one variable per column:
kruskal.test(as.data.frame(x))

#' or using the formula specification
dat <- data.frame(x = c(x$x1, x$x2, x$x3),
                  group = rep(c('x1', 'x2', 'x3'), each = 100))
head(dat)
kruskal.test(x ~ group, data = dat)


#-------------------------------------------------------------------------------
#' ## Proportion test
#' ### One-sample proportion test
(x <- rbinom(50, size = 1, prob = 0.3))

#' The data can be provided as the number of successes (`x`) and the number of trials (`n`)
prop.test(x = sum(x), n = length(x), p = 0.4)

#' or as a matrix containing the number of sucesses and failures:
(M <- matrix(nrow = 1, ncol = 2, data = c(sum(x), sum(1 - x)),
             dimnames = list(c(), c('success', 'failure'))))
prop.test(M, p = 0.4)

#' If the argument `p` is unspecified, `p = 0.5` is used.
#' Like in the `t.test()` we can choose a one- or two-sided null hypothesis
#' using the argument `alternative`, and the confidence level using `conf.level`.

#' When `correct = TRUE` Yate's continuity correction is used.

#' ### Exact one-sample proportion test
#' The function `binom.test()` works the same as `prop.test()`, but performs an
#' exact test.
binom.test(x = sum(x), n = length(x), p = 0.4)


#' ### Pearson's $\chi^2$-Test
#' Categorical data in mutiple categories are usually displayed in a table:
X <- matrix(nrow = 2, ncol = 3, data = sample(5:50, size = 6),
            dimnames = list(c('exposed', 'non-exposed'),
                            c('none', 'mild', 'severe'))
)
X

#' The function `chisq.test()` performs Pearson's Chi-squared test.
#' For this test (or for Fisher's Exact test) it does not matter which variable
#' goes into the rows and which into the columns:
chisq.test(X)
chisq.test(t(X))

#' By default, p-values are calculated from the asymptotic chi-squared distribution
#' of the test statistic. This can be changed to calculation via Monte Carlo simuation
#' when `simulate.p.value = TRUE`. 
#' Then, the argument `B` specifies the number of simulations used to calculate
#' the p-value.
chisq.test(X, simulate.p.value = TRUE, B = 1e5)
#' Note that simulation can result in different p-values every time, especially 
#' when `B` is small:
chisq.test(X, simulate.p.value = TRUE, B = 200)
chisq.test(X, simulate.p.value = TRUE, B = 200)

#' Specification is also possible via two factors:
x <- factor(sample(c('a', 'b'), size = 100, replace = TRUE))
y <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE,
            prob = c(0.3, 0.7)))

table(x, y)
chisq.test(x, y, correct = FALSE)
chisq.test(table(x, y), correct = FALSE)


#' ### Fisher's Exact Test
#' `fisher.test()` takes similar arguments as `chisq.test()` and can be used
#' when there are combinations with no observations:
X[2, 3] <- 0
X
fisher.test(X)

#' Arguments `simulate.p.value` and `B` work like for `chisq.test()`.

#' Confidence intervals for the odds ratio and the specification of an `alternative`
#' are only available for 2x2 tables:
fisher.test(X[, -3], conf.int = TRUE, alternative = 'less')


#' ### McNemar Test
M <- matrix(nrow = 2, ncol = 2, data = sample(1:50, size = 4),
            dimnames = list(before = c('no', 'yes'), after = c('no', 'yes')))
M
mcnemar.test(M)

#' The `mcnemar.test()` also has the option to switch off the continuity 
#' correction by setting `correct = FALSE`.


#' Specification for the test is also possible via two factors:
x <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE))
y <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE,
                   prob = c(0.3, 0.7)))

#' Note that in this example the data are independent, but in reality we have 
#' paired observations.

mcnemar.test(x, y)

table(x, y)
mcnemar.test(table(x,y))


#' ### Cochran-Mantel-Haenszel Chi-Squared Test
x <- factor(sample(c('exposed', 'not exposed'), size = 100, replace = TRUE))
y <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE))
stratum <- factor(sample(c('A', 'B', 'C'), size = 100, replace = TRUE))
table(x, y, stratum)

mantelhaen.test(x = x, y = y, z = stratum)
mantelhaen.test(table(x, y, stratum))

#' The arguments `alternative`, `correct`, `exact` and `conf.level` can be used
#' like for the tests before, but only in the case of a 2 x 2 x K table.
