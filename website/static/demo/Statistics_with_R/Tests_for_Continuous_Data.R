#' ---
#' title: "Demo: Statistical Tests for Continuous Data"
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
#' ## Kruskal-Wallis Rank Sum Test
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
#' ## Testing the Correlation
#' While we can calculate a correlation matrix for a whole set of variables,
#' the function `cor.test()` can only handle two variables at a time:
cor.test(x = swiss$Fertility, y = swiss$Agriculture)

#' Using the argument `method` we can choose between
#' 
#' * `pearson`
#' * `kendall`
#' * `spearman`
#' 
#' Other arguments we know already from other tests are
#' 
#' * `alternative`
#' * `conf.level`
#' * `exact` (only for `kendall` and `spearman`)
#' 
#' We additionally have the argument `continuity` that allows us to use 
#' continuity correction for `method = "kendall"` and `method = "spearman"`.
#' 
cor.test(x = swiss$Fertility, y = swiss$Agriculture, method = "kendall",
         exact = FALSE, continuity = TRUE)


#' It is possible to use a `formula` specification:
cor.test(~ Fertility + Agriculture, data = swiss)

#' This allows us to use the argument `subset` to select only part of the data:
cor.test(~ Fertility + Agriculture, data = swiss, subset = Infant.Mortality > 18)


#' ## Multiple Testing Adjustment
#' Testing multiple hypotheses at a significance level will result in an overall
#' chance of at least one false positive result that is larger than that 
#' significance level.
#' We then need to correct for multiple testing.
#' 
#' This can be done easily using the function `p.adjust()`:

pval1 <- t.test(swiss$Fertility, mu = 50)$p.value
pval2 <- t.test(swiss$Agriculture, mu = 50)$p.value
pval3 <- t.test(swiss$Examination, mu = 30)$p.value

# combine the unadjusted p-values in one vector
(pvals <- c(Fert = pval1, Agri = pval2, Exam = pval3))

# Adjustment using the Bonferroni method:
p_adj_Bonf <- p.adjust(pvals, method = 'bonferroni')

# Adjustment using the Benjamini-Hochberg method
p_adj_BH <- p.adjust(pvals, method = "BH")

cbind(pvals, p_adj_Bonf, p_adj_BH)

#' The available correction methods are available in the vector `p.adjust.methods`:
p.adjust.methods
