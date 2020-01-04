#' ---
#' title: "Demo: Functions for Manipulating Data"
#' subtitle: "NIHES BST02"
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
#' We will work with the datasets `swiss` and `esoph` (both automatically availabe in R).
#' 

#' ## Transformations
#' ### The logarithm
#' In R, `log()` by default calculates the natural logarithm, i.e., the following
#' two commands are equal:
log(swiss$Fertility)
log(swiss$Fertility, base = exp(1))

#' For other commonly used bases we can use separate functions, e.g. `log2()` or
#' `log10`.
#' The argument `base` allows us to change the base of the logarithm to any value:
log(swiss$Fertility, base = 2)
log2(swiss$Fertility)

log(swiss$Fertility, base = 10)
log10(swiss$Fertility)

#' ### Other transformations
#' Exponential function
exp(swiss$Fertility)
#' Square root
sqrt(swiss$Fertility)
#' Absolute value
(x <- rnorm(10))
abs(x)
#' Distribution function of the logistic distribution: this function is for instance
#' useful to convert the linear predictor of a logistic model to the probability scale.
plogis(x)

#' ## Splitting & Combining
#' ### Dividing a (continuous) variable into a `factor`
#' The function `cut()` allows us to convert a numeric variable to a factor.
#' The arguments `breaks` is used to specify the cutoffs for the
#' categories.
(x <- rnorm(20))
cut(x, breaks = c(-1, 0, 1))
#' Note that values outside the smallest and largest "break" are set to `NA`.
#' To prevent that we can include `-Inf` and `Inf`:
cut(x, breaks = c(-Inf, -1, 0, 1, Inf))

#' By default, the lower bound of each interval is excluded, the upper bound is included.
#' We can include the lowest bound by setting `include.lowest = TRUE`.
cut(x, breaks = c(-Inf, -1, 0, 1, Inf), include.lowest = TRUE)
#' Note that this only changes the lower bound of the lowest interval.
#' The argument `right` specifies that the right bound of each interval is included,
#' this chan be changed by setting `right = FALSE`.
#' By default, the resulting factor is unordered. With the argument 
#' `ordered_result = TRUE` we can change this.
#' 
#' To set custom labels for the categories, the argument `labels` can be used:
cut(x, breaks = c(-Inf, -1, 0, 1, Inf), labels = c('lowest', 'low', 'high', 'highest'))
#' 
 
#' ### Splitting a `data.frame`, `matrix` or `vector` by one or more categorical
#' variables

split(swiss, f = swiss$Education > 10)
#' This creates a list with one element per category of `f`. When the splitting
#' factor has more categories, the list has more elemets:
split(swiss, f = cut(swiss$Education, c(0, 5, 10, 15, 20)))
#' Note that cases with Education > 20 are now excluded (because we set the highest
#' breakpoint in `cut()` to 20). To include the "category" `NA`, we can use the
#' function `addNA()`:
split(swiss, f = addNA(cut(swiss$Education, c(0, 5, 10, 15, 20))))

#' The list elements will always have the same class as the original object,
#' i.e., when we split a vector, we obtain a list of vectors:
split(x, x > 0)


#' ### Combining things
#' The function `c()` allows us to combine values into a `vector` or a `list`,
#' the functions `cbind()` and `rbind()` combine objects (usually vectors,
#' matrices or data.frames) by column or row, respectively.
(x <- 1:5)
(y <- 3:7)
c(x, y)
cbind(x, y)
rbind(x, y)

#+ error = TRUE
(X <- matrix(nrow = 3, ncol = 2, data = LETTERS[1:6]))
(Y <- matrix(nrow = 4, ncol = 2, data = LETTERS[10:17]))

rbind(X,Y)
cbind(X,Y)
#' When combining matrices or data.frames, the dimensions must match.
#' When combining vectors, the shorter object is repeated up to the length of
#' the longer vector:
(z <- 1:9)
cbind(x, z)

#' When combining lists, behaviour depends on whether both elements are lists:
(list1 <- list(a = 4, b = c(1, 4, 6)))
c(list1, LETTERS[4:7])
c(list1, list(LETTERS[4:7]))

#' ### Combining strings
#' The function `paste()` (and it's special case `paste0()`) 
#' allows us to combine objects into strings:
paste0("The mean of x is ", mean(x), ".")
#' `paste()` has arguments `sep` and `collapse` that control how the different
#' objects and elements of the objects are combined:

paste("This", "is", "a", "sentence.", sep = " +++ ")
paste(c("This", "is", "a", "sentence."), collapse = " +++ ")

#' ### Getting a subset of a `data.frame`
#' The function `subset()` helps us to get a subset of a `data.frame`.
#' Its arguments `subset` and `select` are used to specify which cases and which
#' variables shouls be selected:

subset(swiss, 
       subset = Education > 15,
       select = c(Fertility, Education, Infant.Mortality))

#' Note that here we can use the variable names without quotes.

#' ### Merging data
#' The function `merge()` allows us to merge two datasets.


# merge
# 

#' ## repetition and sequence
# rep
# seq
# expand.grid

#' ## ransofrmations for objects
# t
# unlist 
# unname
# as.numeric
# as.matrix
# as.data.frame
# 

#' ## Sorting 
# sort
# order
# rev
# rank


#' ## Functions for matrices
# %*%
# diag
# det
# solve
# upper.tri
# lower.tri
