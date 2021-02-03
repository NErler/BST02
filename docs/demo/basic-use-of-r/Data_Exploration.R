#' ---
#' title: "Demo: Data Exploration"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---
#' 

#' ## Load packages 
#' If you are using the package for the first time, you will first have to install it. \ 
# install.packages("survival") 
# install.packages("memisc")
#' If you have already downloaded this package in the current version of R, you will only have to load the package.
library(survival)
library(memisc)

#' ## Get the data
#' Load a data set from a package.\
#' You can use the double colon symbol (:), to return the pbc object from the package survival. We store this data set to an object with the name pbc.
pbc <- survival::pbc

#' ## Common questions that can be answered in R.
#' What is the mean and standard deviation for the variable `age` of the pbc data set?
mean(pbc$age)
mean(pbc$age, na.rm = TRUE)
sd(pbc$age)

#' What is the mean and standard deviation for the variable `time` of the pbc data set?
mean(pbc$time)
mean(pbc$time, na.rm = TRUE)
sd(pbc$time)

#' What is the median and interquartile range for the variable `age` of the pbc data set?
median(pbc$age)
IQR(pbc$age)

#' What is the percentage of `placebo` and `treatment` patients in the pbc data set? \
#' In order to use the `percent()` function you will need to load the `memisc` package.
percent(pbc$trt)

#' What is the percentage of `females` and `males` in the pbc data set?
percent(pbc$sex)

#' What is the mean and standard deviation for the variable `age` of the pbc data set for `males`?\
#' First we can create a new vector with the name `pbc_males` the `male` patients.
pbc_males <- pbc[pbc$sex == "m", ]
#' Then we can obtain the mean and standard deviation of this new vector.
mean(pbc_males$age)
sd(pbc_males$age)

#' What is the mean and standard deviation for `serum bilirubin` of the pbc data set?
mean(pbc$bili)
sd(pbc$bili)


#' ## Handling missing values and outliers
#' Check if there are any missing values using the `is.na()` function.
is.na(pbc$chol)

#' Obtain complete cases for the variable `serum cholesterol` of the pbc data set. We can use the function `complete.cases()` in the row index, to select the non-empty rows.
DF <- pbc[complete.cases(pbc$chol), ]

#' Obtain the dimensions of a matrix or data frame. We can use the function `dim()`.
dim(pbc)
dim(DF)

#' Obtain the rows of the `pbc` data set where the `serum cholesterol` variable has missing values.\
#' We can use a logical vector in the row index to specify whether the particular row is missing.
pbc_chol_na <- pbc[is.na(pbc$chol) == TRUE, ]
head(pbc_chol_na)

#' Obtain the dimensions of the `pbc` data set where the `serum cholesterol` variable has missing.
dim(pbc_chol_na)

#' Outliers: e.g. let's assume that patients with `serum bilirun` values > 25 are outliers.  \
#' 
#' * Check whether there are any outliers: obtain all rows from the data set which correspond to `serum bilirun` outliers.
pbc_out_bili <- pbc[pbc$bili > 25, ]
head(pbc_out_bili)
