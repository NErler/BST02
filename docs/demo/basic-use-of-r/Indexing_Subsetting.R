#' ---
#' title: "Demo: Indexing/Subsetting"
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
#' If you have already downloaded this package in the current version of R, you will only have to load the package.
library(survival)


#' ## Get the data
#' Load a data set from a package.\
#' You can use the double colon symbol (:), to return the pbc object from the package survival. We store this data set to an object with the name pbc.
pbc <- survival::pbc
pbcseq <- survival::pbcseq

#' Remember that for indexing/subsetting we need to use the square brackets.
#' 

#' ## Vector indexing
#' Select the 3rd element from vector `age` of the pbc data set.
pbc$age[3]

#' Select the `sex` of the 10th patient of the pbc data set.
pbc$sex[10]

#' Remove the 1st element from the `id` vector of the pbc data set.
pbc$id[-1]

#' From the vector `age` of the pbc data set, select patients that are younger than 30.
pbc$age[pbc$age < 30]

#' From the vector `age` of the pbc data set, select only `female` patients.
pbc$age[pbc$sex == "f"]


#' ## Matrix and data frame indexing
#' Select the 3rd column of the pbc data set. To do so we type 3 in the second index which represents the columns.\ 
pbc[, 3]

#' Different ways exist to obtain that. As shown below, we can also use double square bracket with a single index.
pbc[[3]]

#' Select the baseline details of the 5th patient of the pbc data set. In that case we only need to specify the row index.
pbc[pbc$id == 5, ]

#' Select the serum bilirubin for all `males` of the pbc data set. In that case we need to specify the row and column index.
pbc[pbc$sex == "m", "bili"]
#' Different ways exist to obtain that. We can take the vector `bili` and then look for `male` patients.
pbc$bili[pbc$sex == "m"]

#' Select the `age` for `male` patients or patients that have `serum bilirubin` more than 5 of the pbc data set. 
#' Here we want one of the two conditions to be satisfied, therefore we use the symbol |.
pbc[pbc$sex == "m" | pbc$bili > 5, "age"]
#' Different ways exist to obtain that. We can take the vector age and from there look for `male` patients or patients that have `serum bilirubin` more than 5.
pbc$age[pbc$sex == "m" | pbc$bili > 5]

#' Select the first measurement per patient using the `pbcseq` data set.\
#' Tip: use the function `duplicated()`.\
#' First think of whether you want to select rows or columns. In that case we want to select rows therefore the first index should be specified.\
#' The code `duplicated(pbcseq[, "id"])` will return a logical vector indicating whether the element is duplicated or not.\
#' We want the opposite (not dublicated). In R we can obtain the opposite by using the symbol !.
pbcseq[!duplicated(pbcseq[, "id"]), ]

#' Select the last measurement per patient using the `pbcseq` data set.\
#' We can use the exact same code as before, but we need to start checking for dublicates from the last measurement per patient.\
#' The `duplicated()` function has an argument called `fromLast` for that.
#' The code `duplicated(pbcseq[, "id"], fromLast = TRUE)` will return a logical vector indicating whether the element is duplicated or not starting from the last observation per patient.\
#' We want the opposite (not dublicated). In R we can obtain the opposite by using the symbol !.
pbcseq[!duplicated(pbcseq[, "id"], fromLast = TRUE), ]

#' Select all `male` patients that died of the pbc data set. Here we want both conditions to be satisfied, therefore we use the symbol &.
pbc[pbc$sex == "m" & pbc$status == 2, ]      

#' Select `male` patients or patients that died of the pbc data set. Here we want one of the two conditions to be satisfied, therefore we use the symbol |. 
#' Use to function `head()` if you do not want to print the full data set.
head(pbc[pbc$sex == "m" | pbc$status == 2, ])

#' Select the `serum bilirubin` measurements only for `female` patients of the pbc data set. \
pbc[pbc$sex == "f", "bili"]   

#' Select all rows of the pbc data set where the `serum bilirubin` measurements are smaller that 10.
head(pbc[pbc$bili < 10, ])


#' ## Array indexing\
#' Create an array
ar <- array(data = 1:19, dim = c(3, 3, 2))
ar 

#' Select the 2nd row of each matrix
ar[2, , ]

#' Select the 2nd column of each matrix
ar[, 2, ]

#' Select the 2nd row and column of the first matrix
ar[2, 2, 1]


#' ## List indexing
#' Create a list with 3 elements: \
#' 
#' * 1st element: all `pbc$id` \
#' * 2nd element: `pbc$bili` for males \
#' * 3rd element: `pbc$age` > 30
myList <- list(pbc$id, pbc$bili[pbc$sex == "m"], pbc$age[pbc$age > 30])

#' Select the second element (the output should be a list).
myList[2]

#' Select the third element (the output should be a vector).
myList[[3]]

#' Select the third element (the output should be a vector). \
#' Then, from the third element, select the elements that are smaller than 20.
#' Tips: do not try doing everything in one step.
newData <- myList[[3]]
newData[newData < 20]

#' Create a list with 3 elements and give them names: \
#' 
#' * 1st element - all_id: all `pbc$id` \
#' * 2nd element - bili_male: `pbc$bili` for males \
#' * 3rd element - young: `pbc$age` < 30
myList <- list(all_id = pbc$id, bili_male = pbc$bili[pbc$sex == "m"], young = pbc$age[pbc$age < 30])

#' Select all_id by name indexing.
myList$all_id

