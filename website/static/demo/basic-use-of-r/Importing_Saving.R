#' ---
#' title: "Demo: Importing and Saving your Work"
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
#' If you are using the package for the first time, you will have to first install it \
# install.packages("survival") 
# install.packages("openxlsx") 
library(survival)
library(openxlsx)

#' ## Get data
#' Load data set from package
pbc <- survival::pbc

#' List all your R objects 
ls()

#' ## Save your work 
#' Take care: first you need to set your working directory (Rstudio: Session -> Set Working Directory -> Choose Directory...) \
#' Use also the function `setwd(...)` to set the working directory
getwd()


dt <- pbc[1:6, c("id", "sex", "bili", "chol")]
p <- 1

#save(dt, p, file = "data.RData")
#saveRDS(dt, file = "data.RData")

#' ## Load previous work
#load("data.RData")
#readRDS("data.RData")

#' ## Transform a RData data set into xls, csv or text format
#write.csv(dt, "mydata.csv")
#write.table(dt, "mydata.txt", sep="\t")
#write.xlsx(dt, "mydata.xlsx")


