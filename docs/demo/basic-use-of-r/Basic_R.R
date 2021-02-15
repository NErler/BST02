#' ---
#' title: "Demo: Basics in R"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#'     df_print: paged
#' ---
#' 

#' ## Load packages 
#' If you are using the package for the first time, you will first have to install it. \
# install.packages("survival") 
# install.packages("memisc") 
#' If you have already downloaded these packages in the current version of R, you will only have to load the packages.
library(survival)
library(memisc)

#' ## Get and view the data
#' Load a data set from a package.\
#' You can use the double colon symbol (:), to return the pbc object from the package survival. We store this data set to an object with the name pbc.
pbc <- survival::pbc

#' Print the first 6 rows of the data set using the function `head()`.
head(pbc)

#' View the data set.
view(pbc)

#' ## Common research questions that can be answered in R
#' What is the average `age`?
#' To obtain that we can use the function `mean()`.
mean(pbc$age)

#' What is the average `serum bilirubin`?
mean(pbc$bili)

#' What is the average `serum cholesterol`?
mean(pbc$chol)

#' The previous code would not work because we have some missing values in that variable. 
#' If we carefully check the help page of the function `mean()`, we will see that there is an argument that can handle missing values. 
#' In particular, if we set na.rm equal to TRUE, R will only use the observed values to calculate the mean.
mean(pbc$chol, na.rm = TRUE)

#' What is the percentage of `females`? \
#' We can use the function `percent()` to answer this question. The package `memisc` should be loaded first.
percent(pbc$sex)

#' We obtained some results in R by answering the aforementioned questions. However, we did not save anything. \
#' For example if I type "Hello" in R I get the following:
"Hello"

#' In order to obtain this word again, we will have to retype it. An alternative approach is to assign the string "Hello" to a new variable named hi as follows.
hi <- "Hello"
#' Then we can print this word whenever we type hi.
hi

#' Make sure that you have defined the object before you use it. \
#' E.g. `number` and `x` will not be found since we did not define them. We can only call them after we have defined them. \
# number
number <- 10
number
# x
x <- 1
x

#' ## Things to remember!
#' * `=` is different from`==`, e.g. `x == 3` is asking a question to R. The single = is equal to <-.\ 
#' * **R** is sensitive, e.g. `pbc$Age` will not run because there is a typo \
#' We need to check the names first using the function `names()`
names(pbc)

#' The correct name is age and not Age.
pbc$age

#' ## Data checks
#' Check if an object consists of missing values. To do that we can use the function `is.na()`.
is.na(x)

#' The function `head()` can be used in order to print the first 6 elements of an object.
head(is.na(pbc))

#' In order to get a summary of the missing values, use the function `table()`.
table(is.na(pbc))
is.na(pbc$age)
table(is.na(pbc$age)) 

#' Use the `is.infinite()` function to Check for infinity data.
is.infinite(pbc$age)
