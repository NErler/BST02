#' ---
#' title: "Demo: Control-flow"
#' subtitle: "NIHES BST02"
#' author: "Nicole Erler, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---
#' 
#' 
#' ## `ifelse()` vs `if() ... else ...`
#' Let's see what happens when we use the `ifelse()` example from the slides
#' with `if() ... else ...`

x <- rnorm(10)
ifelse(x < 0, "<0", ">0")

if (x < 0) {
  "<0"
} else {
  ">0"
}

#' The problem here is that `if()` expects an expression that either returns
#' `TRUE` or `FALSE`, but we gave it a vector:
x < 0

#' In this case, only the first element of this vector is used.
#'  
#' On the other hand, the `if () ... else ...` example from the slides works in
#' both cases:
if (length(x) > 5) {
  mean(x)
} else {
  x
}

ifelse(length(x) > 5, mean(x), x)

#' But for other cases it may not do what we expect it to do:
(x <- list(a = 5, b = rnorm(7), c = rnorm(4)))
ifelse(length(x) > 5, mean(x), x)
#' Here, the "test" `length(x) > 5` results in `FALSE`, but because `ifelse()`
#' expects a vector of "tests" (and only receives one "test"), it will only 
#' return the first element of `x`.
#' 

#' But `if() ... else ...` also does not work per element:
if (length(x) > 5) {
  mean(x)
} else {
  x
}
 

#' ## `for()`-loop
#' We could solve the above issue using a `for()`-loop. This allows us to look
#' at each element of `x` separately.

#' Here, the function `seq_along()` comes in handy:
seq_along(x)
#' It produces a sequence with the same length as `x` has elements.


#' Because we are using a loop, we need to add the `print()` function to see
#' the printed output.
for (i in seq_along(x)) {
  if (length(x[[i]]) > 5) {
    print(mean(x[[i]]))
  } else {
    print(x[[i]])
  }
}
 

#' We could also "collect" the output in a new object:
output <- list()

for (i in seq_along(x)) {
  output[[i]] <- if (length(x[[i]]) > 5) {
    mean(x[[i]])
  } else {
    x[[i]]
  }
}

output

#' ## An example with `while()`
#' `while()` requires a `condition` that at some point is `FALSE` for the loop
#' to stop.
#' 
#' The following would run forever (stop it by pressing "Esc" when in the Console):
#+ eval = FALSE
i <- 0
while(i < 5) {
  print(i)
}

#' This one here could also take very long. Instead of printing the output
#' we save it in a vector that we can plot afterwards.
x <- 0
xvec <- c()
while(x < 5) {
  x <- x + rnorm(1, 0, 1)
  xvec <- c(xvec, x)
}

length(xvec)

#+ fig.width = 8, fig.height = 4
plot(xvec, type = 'l')

#' We could extend the syntax from above by adding a counter
x <- i <- 0
xvec <- c()
while(x < 5 & i < 25) {
  x <- x + rnorm(1, 0, 1)
  xvec <- c(xvec, x)
  i <- i + 1
}
xvec

#' Now we will get a maximum of 25 iterations. The loop stops as soon as `x` is
#' larger than or equal to 5, or if 25 iterations are reached.
