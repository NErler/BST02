#' ---
#' title: "Demo: Importing and Saving your Work"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' Load packages
#' If you are using the package for the first time, you will have to first install it:
# install.packages("survival") 
# install.packages("xlsx") 
library(survival)
library(xlsx)

#' List all your R objects 
ls()

#' Save your work
#' Take care: first you need to set your working directory (Rstudio: Session -> Set Working Directory -> Choose Directory...)
getwd()

dt <- pbc[1:6, c("id", "sex", "bili", "chol")]
p <- 1

#save(dt, p, file = "data.RData")
#saveRDS(dt, file = "data.RData")

#' Load previous work
#load("data.RData")
#readRDS("data.RData")

#' Tranform a RData data set to xls, csv or text
#write.csv(dt, "mydata.txt")
#write.table(dt, "mydata.txt", sep="\t")
#write.xlsx(dt, "mydata.xlsx")


