#' ---
#' title: "Demo: Functions"
#' subtitle: "NIHES BST02"
#' author: "Nicole Erler, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: html_document
#' ---
#' 

#' ## Say hello!
#' ### A first function
hello <- function(name) {
  paste0("Hello ", name, ", how are you?")
}

hello("Nicole")

#' The function `paste()` seems to concatenate / combine strings.
#' Let's check out the help file for `paste()`:
#+ eval = FALSE
?paste

#' `paste()` has arguments
#' 
#' * `...`: one or more R objects, to be converted to character vectors. 
#' * `sep`: a character string to separate the terms. Not NA_character_.
#' * `collapse`: an optional character string to separate the results. Not NA_character_.
#' 
#' The help file also tells us that
#' `paste0(..., collapse)` is equivalent to `paste(..., sep = "", collapse)`.
#' 
#' ### Let's experiment with this a bit 
#' Note: to experiment with the content of our own function it can be convenient
#' to set the arguments of our function to a value:
name <- "Nicole"
paste0("Hello ", name, ", how are you?") # same as above
paste("Hello ", name, ", how are you?") # use paste instead of paste0 
#' Notice the extra spaces between the text and `name`?

paste("Hello ", name, ", how are you?", sep = "")
#' Setting `sep = ""` indeed gives us is the same as `paste0`!

#' We can also `paste` vectors. Note the difference:
paste(c("I", "am", "a", "vector", "of", "character", "strings")) # (sentence 1)
paste("We", "are", "several", "character", "strings")            # (sentence 2)

#' We can use this to explore the effect of the arguments `sep` and `collapse`:
paste(c("I", "am", "a", "vector", "of", "character", "strings"), sep = "+++")
paste(c("I", "am", "a", "vector", "of", "character", "strings"), collapse = "---")

paste("We", "are", "several", "character", "strings", sep = "+++")
paste("We", "are", "several", "character", "strings", collapse = "---")

#' * `sep` separates the different objects. 
#'   Because the vector `c(...)` is one object it didn't have effect in sentence 1,
#'   Sentence 2 has multiple objects (each word is a separate object).
#' * `collapse` separates the terms (elements) of an object.
#'   This is why it has an effect in sentence 1 (each word is an element of the vector)
#'   but not in sentence 2 (each word is only one object).
#'   
#' This is what was written in the help file!
#' 
#' BTW: `paste()` does not only work for character strings:
paste(c(1, 2, "abc"), 345, sep = " a word ", collapse = " / ")
#' 
#' **What should I have learned from this?**
#' 
#' * Read the help files! They (usually) explain how things work!
#' * Play around with the options / arguments to figure out how things work if you
#'   don't immediately understand the help file.
#' 
#' ### Write your own function
#' Now that we understand `sep` and `collapse`, can you write a function that
#' can greet two people at the same time?
#' 
#' 
#' 
hello2 <- function(name1, name2) {
  paste0("Hello ", name1, " and ", name2, ", how are you?")
}

hello2("Elrozy", "Nicole")

#' What about a function that can greet any number of people?
#' 
hello_any <- function(names) {
  paste0("Hello ", 
         paste(names, collapse = ", "),
         ", how are you?")
}

hello_any(c("Elrozy", "Nicole"))
hello_any(c("Elrozy", "Nicole", "Anton", 'Daniel'))

hello_any("Elrozy")

#' **What happens when we give this input to our previous functions?**
#+ error = TRUE
hello(c("Elrozy", "Nicole", "Anton", 'Daniel'))

hello2("Elrozy")
hello2(c("Elrozy", "Nicole", "Anton", 'Daniel'))


#' **What should I have learned from this?**
#' 
#' * Better knowledge of the use of `paste()`, of course.
#' * When you write functions, think about what the possible input might be.
#' * Try your function with different possible inputs.
#' * It can be useful to write functions general enough to handle different
#'   input.


#' Re-inventing the wheel
mymean1 <- function(x) {
  mean(x)
}

mymean2 <- function(x) {
  sum(x)/length(x)
}

# simulate a vector of random numbers:
x <- rnorm(50)

mean(x)
mymean1(x)
mymean2(x)

# t-test
my_t_test <- function(x) {
  # calculate the standard error
  se <- sd(x)/sqrt(length(x))
  
  # calculate the test statistic
  stat <- mean(x)/se
  
  # obtain the probability under the null-hypthesis (t-distribution)
  pt(stat, df = length(x) - 1) * 2
}

t.test(x)
my_t_test(x)


my_t_test2 <- function(x) {
  # calculate the standard error
  se <- sd(x)/sqrt(length(x))
  
  # calculate the test statistic
  stat <- mean(x)/se
  
  # obtain the probability under the null-hypthesis (t-distribution)
  pval <- pt(stat, df = length(x) - 1) * 2
  
  return(list(mean = mean(x), std.err = se, stat = stat, "p-value" = pval))
}

my_t_test2(x)

visualise_t_test <- function(x) {
  res <- my_t_test2(x)
  
  x0 <- seq(from = -4, to = 4, length = 100)
  plot(x0, dt(x0, df = length(x)-1), type = 'l', xlab = "mean of x", ylab = "density")
  abline(v = res$stat, lty = 2)
  legend(x = 'topleft', legend = 'value of the\ntest statistic', lty = 2, col = 1, bty = 'n')
}

visualise_t_test(x)


visualise_t_test2 <- function(x, emp = TRUE) {
  res <- my_t_test2(x)
  
  x0 <- seq(from = -4, to = 4, length = 100)
  plot(x0, dt(x0, df = length(x)-1), type = 'l', xlab = "mean of x", ylab = "density")
  abline(v = res$stat, lty = 2)
  legend(x = 'topleft', legend = 'value of the\ntest statistic', lty = 2, col = 1, bty = 'n')
  
  if (emp == TRUE)
    lines(density(x), col = 2)
}
