#' ---
#' title: "Demo: Data Visualization"
#' subtitle: "NIHES BST02"
#' author: "Eleni-Rosalina Andrinopoulou, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' Load packages
#' If you are using the package for the first time, you will have to first install it:
# install.packages("xlsx") 
# install.packages("lattice")
library(survival)
library(lattice)

#' Basic plot with 1 variable
plot(pbc$bili)

#' Basic plot with 2 variables
plot(pbc$age, pbc$bili)

#' Basic plot with 2 variables - add axis labels
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age")

#' Basic plot with 2 variables - add axis labels - change size of axis and labels
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age", cex.axis = 1.5, cex.lab = 1.9)

#' Basic plot with 3 variables - xaxis represents age, yaxis represents bili and colours represent sex
plot(pbc$age, pbc$bili, ylab = "Serum bilirubin", xlab = "Age", cex.axis = 1.5, cex.lab = 1.9, col = pbc$sex, pch = 16)
legend(30, 25, legend = c("male", "female"), col = c(1,2), pch = 16)

#' Histogram
hist(pbc$bili, breaks = 50)
hist(pbc$bili, breaks = seq(min(pbc$bili), max(pbc$bili), length = 20))

#' Barchart
barchart(pbc$sex)

#' Boxplot
boxplot(pbc$age ~ pbc$sex, ylab = "Age", xlab = "Gender")

#' Mutivariate plot
pairs(cbind(pbc$bili, pbc$chol, pbc$albumin))

#' Lattice family - smooth evolution of bili with age
xyplot(bili ~ age, data = pbc, type = "smooth", lwd = 2)

#' Lattice family - smooth evolution of bili with age per sex
xyplot(bili ~ age, group = sex, data = pbc, type = "smooth", lwd = 2, col = c("red", "blue"))

#' Lattice family - smooth evolution with points of bili with age per sex
xyplot(bili ~ age, group = sex, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red", "blue"))
  
#' Lattice family - smooth evolution with points of bili with age per sex (as separate panel)
xyplot(bili ~ age | sex, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"))   
xyplot(bili ~ age | status, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"))  

#' Lattice family - smooth evolution with points of bili with age per status (as separate panel - change layout)
xyplot(bili ~ age | status, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"), layout = c(3,1)) 

#' Lattice family - smooth evolution with points of bili with age per status (as separate panel - change layout).
#' Add names of status
pbc$status <- factor(pbc$status, levels = c(0, 1, 2), labels = c("censored", "transplant", "dead"))
xyplot(bili ~ age | status, data = pbc, type = c("p", "smooth"), lwd = 2, col = c("red"), layout = c(3,1))  

#' Density plots of bili per sex
pbc_male_bili <- pbc$bili[pbc$sex == "m"]
pbc_female_bili <- pbc$bili[pbc$sex == "f"]
plot(density(pbc_male_bili), col = rgb(0,0,1,0.5), 
     main = "Density plots", xlab = "age", ylab = "")
polygon(density(pbc_male_bili), col = rgb(0,0,1,0.5), border = "blue")
lines(density(pbc_female_bili), col = rgb(1,0,0,0.5))
polygon(density(pbc_female_bili), col = rgb(1,0,0,0.5), border = "red")
legend(20,0.03, c("male", "female"), 
       col = c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)), lty = 1)  



