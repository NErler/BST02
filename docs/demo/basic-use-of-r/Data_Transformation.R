#' ---
#' title: "Demo: Data Transformation"
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
# install.packages("reshape2")
#' If you have already downloaded this package in the current version of R, you will only have to load the package.
library(survival)
library(reshape2)

#' ## Get the data
#' Load a data set from a package.\
#' You can use the double colon symbol (:), to return the pbc and pbcseq objects from the package survival. We store these data sets to new objects with the names pbc and pbcseq.
pbc <- survival::pbc
pbcseq <- survival::pbcseq

#' ## Round continuous variables. For that we can use the function `round()`.
pbc$ast <- round(pbc$ast, digits = 1)
pbc$age <- round(pbc$age, digits = 2)
pbc

#' ## Create factors
#' Set `status` as factor with labels `alive`, `transplant` and `dead`.
factor(pbc$status, levels = c(0, 1, 2),
       labels = c("alive","transplant", "dead"))

#' ## Transform continuous variables \
#' Categorize the variable `age` of the pbc data set (take as cut off value 40).
#' 
#' * Step 1: Check whether the `age` variable of each patient is above 40
pbc$age40higher <- pbc$age > 40
#' This will give us a logical vector, where TRUE indicates that a patient is older than 40.

#' * Step 2: Transform a logical variable into a numeric.
pbc$age40higher <- as.numeric(pbc$age40higher)
pbc

#' * Step 3: Transform a numeric variable into a factor.
pbc$age40higher <- factor(pbc$age40higher, levels = c(0:1),
                              labels = c("young","old"))
pbc

#' Standardize `age` of the pbc data set.
pbc$ageST <- (pbc$age-mean(pbc$age))/(sd(pbc$age))
pbc


#' ## Order the data set by specific variables \
#' Using the function `sort()`
sort(pbc$protime)
#' This obviously is not doing what we want.
#' A more useful function is the function `order()`.
#' Let's sort the pbc data set by the variable `protime`.
pbc[order(pbc$protime), ]
#' Note that if there is only one variable to be sorted on, the cases with tied values are left in their original order.  
#' If the data frame is sorted on multiple variables, the values of later variables will be used to "break the tie".
#' For example:
pbc[order(pbc$protime, pbc$age), ]
#' Check the variable age in the two first cases.\
#' \
#' We can also sort in reverse order by using a minus sign ( - ) in front of the variable that we want sorted in reverse order.
#' For example, the data will be sorted on protime, and within each category of protime, the variable age is sorted in reverse order.
pbc[order(pbc$protime, -pbc$age), ]


#' ## Wide/long format \
#' ### Long to wide data set \
#' The data set `pbcseq` is in long format.
pbcseq

#' Select the first (or last) row of each patient  \ \
#' Let's assume that we only want to keep the first or last value and remove the rest. \
#' We will select the first or last measurement by using the following code.
pbcseq[!duplicated(pbcseq[, "id"]), ]
pbcseq[!duplicated(pbcseq[, "id"], fromLast = TRUE), ]

#' Step by step
duplicated(pbcseq[, "id"])
!duplicated(pbcseq[, "id"])

duplicated(pbcseq[, "id"])
duplicated(pbcseq[, "id"], fromLast = TRUE)
!duplicated(pbcseq[, "id"], fromLast = TRUE)



#' Let's assume that we want to have our data in wide format while keeping all measurements. 
#' We will have to create new columns to include this information.
#' 
#' * Step 1: Obtain how many repeated measurements we have per patient
vec <- table(pbcseq$id)

#' * Step 2: Take a sequence of the visits of each patient
vec2 <- sequence(vec)
pbcseq$visits <- vec2

#' * Step 3: Obtain the wide format `pbcseq` data set using the function `reshape()` from the `reshape2` package
pbcseqWide <- reshape(pbcseq, idvar = c("id"), 
                    drop = c("futime", "status", "trt", "age", "sex", 
                             "day", "ascites", "hepato", "spiders", 
                             "edema", "chol", "albumin", "alk.phos", 
                             "ast", "platelet", "protime", "stage"),
                    timevar = "visits", direction = "wide")

pbcseqWide


#' ### Wide to long data set  \
#' Obtain the long format `pbcseqWide` data set using the function `reshape()` from the `reshape2` package
pbcLong <- reshape(pbcseqWide, idvar = c("id"), timevar = "time", 
                    varying = list(names(pbcseqWide)[2:17]),
                    v.names = "bili", direction = "long", times = 1:16)
pbcLong

#' Extra step: Order the data set by `id` number
pbcLong <- pbcLong[order(pbcLong$id),]
pbcLong


