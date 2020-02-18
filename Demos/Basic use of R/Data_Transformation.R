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
#' ---
#' 

#' ## Load packages 
#' If you are using the package for the first time, you will have to first install it 
# install.packages("survival") 
# install.packages("reshape2")
library(survival)
library(reshape2)

#' ## Get data
#' Load data set from package
pbc <- survival::pbc
pbcseq <- survival::pbcseq

#' ## Round continuous variables
pbc$ast <- round(pbc$ast, digits = 1)
pbc$age <- round(pbc$age, digits = 2)
head(pbc)

#' ## Create factors
#' Set `sex` as factor with labels `m` for `male` and `f` for `female`
factor(pbc$sex, levels = c("m", "f"),
       labels = c("male","female"))

#' ## Transform continuous variables \
#' Categorize `age` (take as cut off value 40) 
#' 
#' * Step 1: Check whether the age variable of each patient is above 40
pbc$age40higher <- pbc$age > 40

#' * Step 2: Transform a logical variable into a numeric
pbc$age40higher <- as.numeric(pbc$age40higher)
head(pbc)

#' * Step 3: Transform a numeric variable into a factor
pbc$age40higher <- factor(pbc$age40higher, levels = c(0:1),
                              labels = c("young","old"))
head(pbc)

#' Standardize `age`
pbc$ageST <- (pbc$age-mean(pbc$age))/(sd(pbc$age))
head(pbc)


#' ## Wide/long format \
#' ### Long to wide data set
head(pbcseq)

#' Select the first (or last) row of each patient  \ \
#' We will remove a lot of information by using the following way
head(pbcseq[!duplicated(pbcseq[c("id")]), ])
head(pbcseq[!duplicated(pbcseq[c("id")], fromLast = TRUE), ])

#' Step by step
head(duplicated(pbcseq[c("id")]))
head(!duplicated(pbcseq[c("id")]))

head(duplicated(pbcseq[c("id")]))
head(duplicated(pbcseq[c("id")], fromLast = TRUE))
head(!duplicated(pbcseq[c("id")], fromLast = TRUE))



#' We will keep all the observations by using the following way \
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

head(pbcseqWide)


#' ### Wide to long data set  \
#' Obtain the long format `pbcseqWide` data set using the function `reshape()` from the `reshape2` package
pbcLong <- reshape(pbcseqWide, idvar = c("id"), timevar = "time", 
                    varying = list(names(pbcseqWide)[2:17]),
                    v.names = "bili", direction = "long", times = 1:16)
head(pbcLong)

#' Extra step: Order the data set by `id` number
pbcLong <- pbcLong[order(pbcLong$id),]
head(pbcLong)


