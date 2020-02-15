#' ---
#' title: "Demo: Statistical Tests for Categorical Data"
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
#' ## One-sample proportion test
# create some data:
(x <- rbinom(50, size = 1, prob = 0.3))

#' For a proportion test, the data can be provided as the number of 
#' successes (`x`) and the number of trials (`n`)
prop.test(x = sum(x), n = length(x), p = 0.4)

#' or as a matrix containing the number of sucesses and failures:
M <- matrix(data = c(sum(x), sum(1 - x)),
             nrow = 1, ncol = 2, 
             dimnames = list(c(), c('success', 'failure'))
)
M

prop.test(M, p = 0.4)

#' If the argument `p` is unspecified, `p = 0.5` is used.

#' Like in the `t.test()` we can choose a one- or two-sided null hypothesis
#' using the argument `alternative`, and the confidence level using `conf.level`.

#' When `correct = TRUE` Yate's continuity correction is used.
#' 


#' ### Exact one-sample proportion test
#' The function `binom.test()` works the same as `prop.test()`, but performs an
#' exact test.
binom.test(x = sum(x), n = length(x), p = 0.4)



#-------------------------------------------------------------------------------
#' ## Pearson's $\chi^2$-Test
#' Categorical data in mutiple categories are usually displayed in a table:
X <- matrix(data = sample(5:50, size = 6),
            nrow = 2, ncol = 3,
            dimnames = list(c('exposed', 'non-exposed'),
                            c('none', 'mild', 'severe'))
)
X

#' The function `chisq.test()` performs **Pearson's Chi-squared test**.
#' For this test (or for **Fisher's Exact test**) it does not matter which variable
#' goes into the rows and which into the columns:
chisq.test(X)
chisq.test(t(X))

#' * By default, p-values are calculated from the **asymptotic chi-squared distribution**
#'   of the test statistic.
#'* This can be changed to calculation via **Monte Carlo simuation**
#'   when `simulate.p.value = TRUE`. 
#'   Then, the argument `B` specifies the number of simulations used to calculate
#'   the p-value.
chisq.test(X, simulate.p.value = TRUE, B = 1e5)

#' **Note** that simulation can result in different p-values every time, especially 
#' when `B` is small:
set.seed(1234)
chisq.test(X, simulate.p.value = TRUE, B = 200)
chisq.test(X, simulate.p.value = TRUE, B = 200)

#' Specification is also possible via two factors:
x <- factor(sample(c('a', 'b'), size = 100, replace = TRUE))
y <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE,
                   prob = c(0.3, 0.7)))

table(x, y)
chisq.test(x, y, correct = FALSE)
chisq.test(table(x, y), correct = FALSE)



#-------------------------------------------------------------------------------
#' ## Fisher's Exact Test
#' `fisher.test()` takes similar arguments as `chisq.test()` and can be used
#' when there are **combinations with no observations**:
X[2, 3] <- 0
X
fisher.test(X)

#' * Arguments `simulate.p.value` and `B` work like for `chisq.test()`.
#' * Confidence intervals for the odds ratio and the specification of an `alternative`
#'   are only available for 2x2 tables:
fisher.test(X[, -3], conf.int = TRUE, alternative = 'less')



#-------------------------------------------------------------------------------

#' ## McNemar Test
M <- matrix(data = sample(1:50, size = 4),
            nrow = 2, ncol = 2, 
            dimnames = list(before = c('no', 'yes'), after = c('no', 'yes')))
M
mcnemar.test(M)

#' The `mcnemar.test()` also has the option to switch off the continuity 
#' correction by setting `correct = FALSE`.
#' 
#' 


#' Specification for the test is also possible via two factors:
x <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE))
y <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE,
                   prob = c(0.3, 0.7)))

#' **Note** that in this example the data are independent, but in a real case we would
#' have **paired observations**.

mcnemar.test(x, y)

table(x, y)
mcnemar.test(table(x,y))




#-------------------------------------------------------------------------------
#' ## Cochran-Mantel-Haenszel Chi-Squared Test
x <- factor(sample(c('exposed', 'not exposed'), size = 100, replace = TRUE))
y <- factor(sample(c('yes', 'no'), size = 100, replace = TRUE))
stratum <- factor(sample(c('A', 'B', 'C'), size = 100, replace = TRUE))
table(x, y, stratum)

mantelhaen.test(x = x, y = y, z = stratum)
mantelhaen.test(table(x, y, stratum))

#' The arguments `alternative`, `correct`, `exact` and `conf.level` can be used
#' like for the tests before, but only in the case of a $2 \times 2 \times K$ table.
