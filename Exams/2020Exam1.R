# Question 1

# Investigate the data set bladder from the survival pakage. What is the number of rows in this data set.

dim(survival::bladder)[1]

dim(survival::bladder)[2]

100

345


# Question 2

# What is the number of events in the bladder data set.

111

sum(bladder[,2])

sum(bladder$event == 0)

sum(bladder$event == 1)


# Question 3

# Create a new variable (with the name event2) that converts the variable `event` into a factor. The value 0 should take the label "no" and the value 1 should take the label "yes".

bladder$event2 <- factor(bladder$event, levels = c(0, 1), labels = c("no", "yes")) 


# Question 4

# Obtain the median, minimum (function min()) and maximum(function max()) value of the variables: number, size and stop from the data set bladder.

median(bladder$number)
min(bladder$number)
max(bladder$number)
median(bladder$size)
min(bladder$size)
max(bladder$size)
median(bladder$stop)
min(bladder$stop)
max(bladder$stop)

# Question 5

# Obtain the median, value of the variables: number, size and stop per event group using the data set bladder.

tapply(bladder$number, bladder$event, median)
tapply(bladder$size, bladder$event, median)
tapply(bladder$stop, bladder$event, median)

# Question 5

# Now create a function with the name fun_med that takes as input a continuous variable (with the name cont) and a categorical variable (with the name cate). 
# This function should obtain the median, value of the continuous variable per group (categorical variable) using the data set bladder.
# Apply the function in the bladder data set using as continuous variable the variable stop and as categorical variable the variable rx.
name_fun <- function(cont, cate){
  tapply(cont, cate, median)
}

name_fun(bladder$stop, bladder$rx)

# Question 6

# a) Obtain the mean stop variable for all patients with size equal or smaller than 3 using the bladder data set.
# b) Now create a function that takes as input:
#      dat: a data set
#      cont_var: the name of a continuous variable (such as "stop")
#      ord_var: an ordered variable (such as "size") 
#      z: a number (that takes the values of the ordered variable)
# This function should return the mean value of the continuous variable of all the patients were the ordered variable is equal or smaller than z.
# The name of the function should be sub_mean.
# Check if this fuction gives you the same result is in a) when dat = bladder, cont_vat = "stop", ord_var = "size" and z = 3.

mean(bladder$stop[bladder$size <= 3])

sub_mean <- function(dat, cont_var, ord_var, z){
  mean(dat[[cont_var]][dat[[ord_var]] <= z])
}

sub_mean(dat = bladder, cont_var = "stop", ord_var = "size", z = 3)

