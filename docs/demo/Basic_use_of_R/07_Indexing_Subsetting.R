#' ---
#' title: "Demo: Indexing/Subsetting"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' Load packages \
#' If you are using the package for the first time, you will have to first install it
# install.packages("survival") 
library(survival)

#' Select the 3rd element for vector age
pbc$age[3]

#' Select the 3rd column of the pbc data set
pbc[, 3]
pbc[, 3]

pbc[[3]]
pbc$status

#' Select the sex of the 10th patient
pbc$sex[10]

#' Select the baseline details of the 5th patient
pbc[pbc$id == 5, ]

#' Select the serum cholesterol for all males
pbc[pbc$sex == "m", "bili"]
pbc$bili[pbc$sex == "m"]

#' Select the age for `male` patients or patients that have `serum bilirubin` more than 3
pbc[pbc$sex == "m" | pbc$bili > 5, "age"]
pbc$age[pbc$sex == "m" | pbc$bili > 5]

#' Select the first measurement per patient using the `pbcseq` data set
head(pbcseq[tapply(row.names(pbcseq), pbcseq$id, head, 1), ])

#' Select the last measurement per patient using the `pbcseq` data set
head(pbcseq[tapply(row.names(pbcseq), pbcseq$id, tail, 1), ])

#' From the vector `age`, select patients that are younger than 30
pbc$age[pbc$age < 30]

#' From the vector `age`, select only `female` patients
pbc$age[pbc$sex == "f"]

#' From the vector `age`, select the 3rd element
pbc$age[3]

#' Select all `male` patients that died
pbc[pbc$sex == "m" & pbc$status == 2, ]      

#' Select `male` patients or patients that died
pbc[pbc$sex == "m" | pbc$status == 2, ]   

#' Select the `serum bilirubin` measurements only for `female` patients \
#' Calculate the mean and standard deviation \
#' Plot a histogram
pbc[pbc$sex == "f", "bili"]   

mean(pbc[pbc$sex == "f", "bili"])
sd(pbc[pbc$sex == "f", "bili"])

hist(pbc[pbc$sex == "f", "bili"])

#' Select all rows where the `serum bilirubin` measurements are smaller that 10
pbc[pbc$bili < 10, ]

#' Make a boxplot of `serum bilirubin` per `sex` using the previous selection
new_pbc <- pbc[pbc$bili < 10, ]
boxplot(new_pbc$bili ~ new_pbc$sex)

#' Create a list with 3 elements: \
#' 1st element: all `pbc$id` \
#' 2nd element: `pbc$bili` for males \
#' 3rd element: `pbc$age` > 30
myList <- list(pbc$id, pbc$bili[pbc$sex == "m"], pbc$age[pbc$age > 30])

#' Select the second element (the output should be a list)
myList[2]

#' Select the third element (the output should be a vector)
myList[[3]]

#' Select the third element (the output should be a vector) \
#' Then, from the third element, select the elements that are smaller than 20
newData <- myList[[3]]
newData[newData < 20]

#' Create a list with 3 elements and add names: \
#' 1st element - all_id: all `pbc$id` \
#' 2nd element - bili_male: `pbc$bili` for males \
#' 3rd element - young: `pbc$age` < 30
myList <- list(all_id = pbc$id, bili_male = pbc$bili[pbc$sex == "m"], young = pbc$age[pbc$age < 30])

#' Select all_id by name indexing
myList$all_id

