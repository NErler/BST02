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
#' In R, `log()` by default calculates the natural logarithm
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
#' Distribution function of the logistic distribution
plogis(x)

#' ## Splitting & Combining
# split
# cut
# cbind
# rbind
# c
# merge
# subset
# paste
# 

#' ## repitition and sequence
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
