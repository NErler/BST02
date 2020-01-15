#' ---
#' title: "Demo: Functions for exploring data"
#' author: "Nicole Erler, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---
#' 

#' ## Dataset
#' We will explore the datasets `swiss` and `esoph` (both automatically availabe in R).
#' 

# ------------------------------------------------------------------------------
#' ## What type of object do I have?
class(swiss)

#' ## How large is this dataset?
#' Dimension of a `data.frame` or a `matrix`:
dim(swiss)

#' We can also get the rows and columns separately:
nrow(swiss)
ncol(swiss)

#' Be carefull:
length(swiss)

#' Why is that?
#' Because a `data.frame` is also a `list`:
is.list(swiss)
is.data.frame(swiss)

#' but:
length(swiss$Fertility)


#' ## How does the dataset look like?
#' Names of all the variables in the data:
names(swiss)

#' Show me the first and last few rows:
head(swiss)
tail(swiss)

#' We can adjust how many rows are shown:
head(swiss, n = 10)

# Structure of the dataset:
str(swiss)
#' The function `str` has many arguments to customize the output, 
#' but we will skip that here.



# ------------------------------------------------------------------------------
#' ## Descriptive Statistics
#' ### Summary of a `data.frame` or `matrix`
summary(esoph)



#' ### Summaries per variable
#' We can also get the summary of a single variable
summary(swiss$Fertility)

#' or you can do all the work yourself:
min(swiss$Fertility)
max(swiss$Fertility)
range(swiss$Fertility)
mean(swiss$Fertility)
median(swiss$Fertility)
quantile(swiss$Fertility, probs = c(0.1, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99))

#' Inter quartile range:
IQR(swiss$Fertility)

#' Standard deviation
sd(swiss$Fertility)

#' Variance
var(swiss$Fertility)

#' All the above functions (`min`, `max`, `range`, `mean`, `median`, `quantile`,
#' `sd`, `var`) have an argument `na.rm` which is by default set to `FALSE`.
(x <- c(rnorm(5), NA))
min(x)
min(x, na.rm = TRUE)


#' Another helpful function to summarize continuous data is `ave()`.
#' It calculates a summary measure of a continuous variable per group, that are
#' defined by one or more categorical variables:
esoph$av_case_by_age <- ave(esoph$ncases, esoph$agegp)
esoph[12:22, ]

#' `ave()` also works with other functions than the mean:
esoph$med_case_by_age <- ave(esoph$ncases, esoph$agegp, FUN = median)
esoph[28:36, ]

#' And we can split the data by multiple categorical variables:
ave(esoph$ncases, esoph$agegp, esoph$alcgp, FUN = median)



# ------------------------------------------------------------------------------
#' ## Tables
#' The above summaries were all for continuous variables. 
#' For categorical variables we may be interested to see the different categories
#' and how many observations there are per category:
levels(esoph$agegp)
table(esoph$agegp)

#' By default, table only shows observations.
#' The argument `exclude` can be set to `NULL` to also include missing values:
(x <- factor(c(NA, sample(LETTERS[1:3], size = 10, replace = TRUE)),
             levels = LETTERS[1:5]))
table(x)
table(x, exclude = NULL)

#' We can also get tables for multiple variables.
table(age = esoph$agegp, alc = esoph$alcgp)




#' ### Tables: Margins
#' To add summaries (e.g. the sum) for each column and/or row:
tab <- table(age = esoph$agegp, alc = esoph$alcgp)
addmargins(tab)
addmargins(tab, margin = 1)
addmargins(tab, margin = 2, FUN = mean)

#' It is also possible to use different functions per margin:
addmargins(tab, FUN = c(mean, sum))

#' ### Tables: Proportions
#' To convert the table to proportions:
prop.table(tab)

#' Here, the sum over all cells is 1:
sum(prop.table(tab)) 

#' The argument `margin` allows us to get proportions relative to the row- or 
#' column sum:
prop.table(tab, margin = 1)

#' In the above table, the sum in each row is equal to 1:
addmargins(prop.table(tab, margin = 1))



#' ### Tables: More Dimensions
#' It is possible to get tables with > 2 dimensions:
table(esoph[, 1:3]) # same as table(esoph$agegp, esoph$alcgp, esoph$tobgp)

#' In that case a "flat table" can be more clear:
ftable(table(esoph[, 1:3]))
#' With the help of the arguments `row.vars` and `col.vars` we can determine 
#' which variables are given in the rows and which in the columns:
ftable(table(esoph[, 1:3]), row.vars = c(1))
ftable(table(esoph[, 1:3]), row.vars = c(3, 2))


# ------------------------------------------------------------------------------
#' ## Functions for matrices
#' ### Sums and Means
#' The function `colMeans()` allows us to calculate the mean for each column 
#' in a `matrix` or `data.frame`:
colMeans(swiss)

#' We can't use `colMeans()` on the `esoph` data because there not all variables 
#' are numeric:
#+ error = TRUE
colMeans(esoph)

#' The functions `colSums()`, `rowMeans()` and `rowSums()` work correspondingly,
#' but are usually less useful to summarize a whole dataset.
colSums(swiss)
rowMeans(swiss)

#' To use other functions (like `min`, `max`, `median`, `sd`, ...) on a whole
#' `matrix` or `data.frame` we need some
#' more programming and the help of  `if (...)`, `for (...)` and/or `apply()`
#' (will be covered later).
#' 



#' ### Variance, Covariance and Correlation
#' The functions `var`, and `cov` return the variance-covariance matrix when 
#' used on a `matrix` or `data.frame`:
var(swiss)

#' This of course only gives meaningful resuls when the data are continuous:
#+ error = TRUE
cov(esoph)

#' When there are missing values in the data:
#' Specify the argument `use = "pairs"` to exclude missing values (which would 
#' otherwise result in a `NA` value for the (co)variance)

#' A (co)variance matrix can be converted to a (pearson) correlation matrix with the help
#' of the function `cov2cor()`:
cov2cor(var(swiss))

#' The correlation matrix can be obtained directly using `cor()`. The argument 
#' `method` allows the choice of pearson", "kendall" or "spearman" correation.
cor(swiss, method = 'kendall')




# ------------------------------------------------------------------------------
#' ## Duplicates and Comparison
#' To find duplicates in a `data.frame`, `matrix` or a `vector` we can use the 
#' function `duplicated()`:
duplicated(esoph)

(x <- sample(LETTERS[1:5], 10, replace = TRUE))
duplicated(x)

#' Let's set the original variable and the duplication indicator next to each 
#' other to see what is happening:
cbind(x, duplicated(x))

#' (We will get to know the function `cbind()` later).

#' Using the argument `fromLast = TRUE` checks for duplicates starting from
#' the last value:
cbind(x,
      duplFirst = duplicated(x),
      duplLast = duplicated(x, fromLast = TRUE))

#' Return only the unique values:
unique(x)

#' This also works for `data.frame` and `matrix`.
(dat <- data.frame(x = x,
                  y = rbinom(length(x), size = 1, prob = 0.5))
)
unique(dat)

(mat <- as.matrix(dat))
unique(mat)

#' With the function `data.frame()` we create a `data.frame` and the function
#' `as.matrix()` allows us to convert an object to a `matrix`. 

