#' ---
#' title: "Demo: Data Visualization"
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
# install.packages("lattice")
# install.packages("ggplot2")
# install.packages("emojifont")
# install.packages("gtrendsR")
#' If you have already downloaded this package in the current version of R, you will only have to load the package.
library(survival)
library(lattice)
library(ggplot2)
library(emojifont)
library(gtrendsR)

#' ## Get the data
#' Load a data set from a package.\
#' You can use the double colon symbol (:), to return the pbc and pbcseq objects from the package survival. We store these data sets to new objects with the names pbc and pbcseq.
pbc <- survival::pbc
pbcseq <- survival::pbcseq

#' ## Basic plots
#' Basic plot with 1 continuous variable using the function `plot()`. For example, investigate the variable `bili` of the pbc data set.
plot(x = pbc$bili)

#' Basic plot with 2 continuous variables. For example, Check the correlation between `age` and `bili` of the pbc data set.
plot(x = pbc$age, y = pbc$bili)

#' Basic plot with 2 continuous variables. Now, insert labels for the x and y-axis (use the argument xlab).
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age")

#' Basic plot with 2 continuous variables. Now, insert labels for the x and y-axis and change the size of the axis and labels (use the arguments cex.axis and cex.lab).
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age",
     cex.axis = 1.2, cex.lab = 1.4)

#' Basic plot with 2 continuous variables. Insert axis labels and change the size and type of points. 
#' Change also the size and the type of the points (use the arguments cex and pch). 
#' If you are not sure which arguments to use, check the help page.
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age",
     cex.axis = 1.2, cex.lab = 1.4,
     cex = 2, pch = 16)


#' Basic plot with 2 continuous variables. Insert labels for the x and y-axis and change the size of the axis and labels. Change also the colour of the points. \
#' Note that we can set the colours in different ways:\
#' * using numbers that correspond to a colour \
#' * using the name of the colour \
#' * using the RGB colour specification (Red Green Blue) `?rgb` \
#' * using the HEX colour code
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age", 
     cex.axis = 1.2, cex.lab = 1.4,
     col = 2)
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age", 
     cex.axis = 1.2, cex.lab = 1.4,
     col = "red")
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age", 
     cex.axis = 1.2, cex.lab = 1.4,
     col = rgb(1,0,0))
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age", 
     cex.axis = 1.2, cex.lab = 1.4,
     col = "#FF0000")

#' Basic plot with 3 variables (2 continuous and 1 categorical). X-axis represents `age`, y-axis represents `serum bilirubin` and colours represent `sex`.
plot(x = pbc$age, y = pbc$bili, ylab = "Serum bilirubin", xlab = "Age", 
     cex.axis = 1.5, cex.lab = 1.4, col = pbc$sex, pch = 16)
legend(30, 25, legend = c("male", "female"), col = c(1,2), pch = 16)

#' Histogram for continuous variables. Check the distribution of `bili` and investigate the argument breaks and length.
hist(x = pbc$bili, breaks = 50)
hist(x = pbc$bili, breaks = seq(min(pbc$bili), max(pbc$bili), length = 20))

#' Multiple panels (using the `par()` function).
par(mfrow=c(2,2))
hist(x = pbc$bili, freq = TRUE)
hist(x = pbc$chol, freq = TRUE)
hist(x = pbc$albumin, freq = TRUE)
hist(x = pbc$alk.phos, freq = TRUE)
#' Check what the argument freq does.\
#' Tip: Note that sometimes you will have to clear all plots in order to get 1 panel again (brush icon in `Plots` tab).

#' Barchart for categorical variables using the function `plot()`. Check the frequency of `males` and `females`.
plot(x = pbc$sex)

#' Piechart for categorical variables using the functions `pie()` and `table()`. Check the frequency of `males` and `females`.
pie(x = table(pbc$sex))

#' Boxplot for investigating the distribution of a continuous variable per group using the function `boxplot()`. Check the distribution of `age` per `sex` group.
boxplot(formula = pbc$age ~ pbc$sex, ylab = "Age", xlab = "Gender")

#' Multivariate plot of the variables `bili`, `chol` and `albumin`.
#' We first need to create a matrix/data.frame.
pairs(x = data.frame(pbc$bili, pbc$chol, pbc$albumin))
pairs(x = cbind(pbc$bili, pbc$chol, pbc$albumin))
pairs(formula = ~ bili + chol + albumin, data = pbc)
#' In the last case we set the data set to pbc. That means that we do not have to specify pbc every time we select a variable. 
#' The function knows that it has to look in the pbc data set for these names.
      
#' Density plots of `bili` per `sex` group to investigate the distribution. \
#' Several ways exist to obtain this plot. 
# Here we start by assigning the `bili` values for `males` and `females` to a new object.
pbc_male_bili <- pbc$bili[pbc$sex == "m"]
pbc_female_bili <- pbc$bili[pbc$sex == "f"]
# We first plot the `bili` values for `males`.
plot(density(pbc_male_bili), col = rgb(0,0,1,0.5), ylim = c(0,0.40),
     main = "Density plots", xlab = "bili", ylab = "")
# Then we fill in the area under the curve using the function `polygon()`.
polygon(density(pbc_male_bili), col = rgb(0,0,1,0.5), border = "blue")
# Then we add the `bili` values for `females`. Since a plot has been already specified we can use the function `lines()` to add a line.
lines(density(pbc_female_bili), col = rgb(1,0,0,0.5))
# Then we fill in the area under the curve using the function `polygon()`.
polygon(density(pbc_female_bili), col = rgb(1,0,0,0.5), border = "red")
# Finally, we add a legend using the `legend()` function.
legend(5,0.3, legend = c("male", "female"), 
       col = c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)), lty = 1)  

#' ## Lattice family
#' Correlation between `bili` and `age`. Investigate the arguments type and lwd.
xyplot(x = bili ~ age, data = pbc, type = "p", lwd = 2)

#' Smooth evolution of `bili` with `age`. To change the type of plot use the argument type.
xyplot(x = bili ~ age, data = pbc, type = c("p", "smooth"), lwd = 2)

#' Smooth evolution of `bili` with `age` per `sex`. Assume different colours for each `sex` category using the group argument.
xyplot(x = bili ~ age, group = sex, data = pbc, type = "smooth", 
       lwd = 2, col = c("red", "blue"))

#' Smooth evolution with points of `bili` with `age` per `sex`. Assume different colours for each `sex` category.
xyplot(x = bili ~ age, group = sex, data = pbc, type = c("p", "smooth"), 
       lwd = 2, col = c("red", "blue"))

#' Smooth evolution with points of `bili` with `age` per `sex` (as separate panel).
xyplot(x = bili ~ age | sex, data = pbc, type = c("p", "smooth"), 
       lwd = 2, col = c("red"))   

#' Smooth evolution with points of `bili` with `age` per `status` (as separate panel).
xyplot(x = bili ~ age | status, data = pbc, type = c("p", "smooth"), 
       lwd = 2, col = c("red"))  

#' Smooth evolution with points of `bili` with `age` per `status` (as separate panel - change layout).
xyplot(x = bili ~ age | status, data = pbc, type = c("p", "smooth"), 
       lwd = 2, col = c("red"), layout = c(2,2)) 

#' Smooth evolution with points of `bili` with `age` per `status` (as separate panel - change layout). \
#' Transform `status` into a factor with labels and run the plot again.
pbc$status <- factor(x = pbc$status, levels = c(0, 1, 2), 
                     labels = c("censored", "transplant", "dead"))
xyplot(x = bili ~ age | status, data = pbc, type = c("p", "smooth"), 
       lwd = 2, col = c("red"), layout = c(3,1))  

#' Individual patient plot.
xyplot(x = bili ~ day, group = id, data = pbcseq, type = "l", col = "black")

#' Individual patient plot per `status`.
pbcseq$status <- factor(x = pbcseq$status, levels = c(0, 1, 2), 
                        labels = c("censored", "transplant", "dead"))
xyplot(x = bili ~ day | status, group = id, data = pbcseq, type = "l", 
       col = "black", layout = c(3,1),
       grid = TRUE, xlab = "Days", ylab = "Serum bilirubin")

#' Barchart for categorical variables using the function `barchart()`. Checking the frequency of `males` and `females`.
barchart(x = pbc$sex)

#' Boxplot of `serum bilirubin` per `sex` group using the function `bwplot()`.
bwplot(x = pbc$bili ~ pbc$sex)


#' ## Ggplot family 
#' Correlation between `age` with `bili`. \
#' Each `sex` has a different colour.
ggplot(data = pbc, mapping = aes(age, bili, colour = sex)) + 
  geom_point()

ggplot(data = pbc, mapping = aes(age, bili, colour = sex)) + 
geom_point(alpha = 0.3) +
geom_smooth()

#' Correlation between `day` with `bili` for patient 93. \
#' A smoothed curve is added in blue.
ggplot(data = pbcseq[pbcseq$id == 93,], mapping = aes(day, bili)) +
geom_line() +
geom_smooth(colour = "blue", span = 0.4) +
labs(title = "Patient 93", subtitle = "Evolution over time", 
     y = "Serum bilirubin", x = "Days")

#' Correlation between `serum bilirubin` per `stage`.
ggplot(data = pbc, mapping = aes(stage, bili, group = stage)) +
geom_boxplot() +
labs(y = "Serum bilirubin", x = "Stage")

#' Density plot of `serum bilirubin` per `sex` to investigate the distribution. \
#' Be aware that a plot is an object in R, so you can save it.
p <- ggplot(data = pbc, mapping = aes(bili, fill = sex)) +
geom_density(alpha = 0.25) 
p

p + scale_fill_manual(values = c("#999999", "#E69F00"))

                     
#' ## Let's have some fun
set.seed(123)
x1 <- rnorm(10)
y1 <- rnorm(10)
x2 <- rnorm(10)
y2 <- rnorm(10)

plot(x = x1, y = y1, cex = 0)
points(x = x1, y = y1, pch = 16)

plot(x = x1, y1, cex = 0)
text(x = x1, y = y1, cex = 1.5, col = "red")
plot(x = x1, y = y1, cex = 0)
text(x = x1, y = y1, labels = emoji("heartbeat"), cex = 1.5, col = "red", family = "EmojiOne")
text(x = x2, y = y2, labels = emoji("cow"), cex = 1.5, col = "steelblue", family = "EmojiOne")

search_emoji("face")

plot(x = x1, y = y1, cex = 0)
text(x = x1, y = y1, labels = emoji("nerd_face"), cex = 1.5, col = "red", family = "EmojiOne")

plot(x = x1, y = y1, cex = 0)
text(x = x1, y = y1, labels = emoji("face_with_head_bandage"), 
     cex = 1.5, col = "blue", family = "EmojiOne")


#' Using google data
google.trends1 = gtrends(c("feyenoord"), gprop = "web", time = "all")[[1]]

ggplot(data = google.trends1, mapping = aes(x = date, y = hits)) +
  geom_line() +
  labs(y = "Feyenoord", x = "Time") +
  ggtitle("Hits on Google")





