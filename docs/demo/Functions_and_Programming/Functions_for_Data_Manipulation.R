#' ---
#' title: "Demo: Functions for Manipulating Data"
#' subtitle: "NIHES BST02"
#' author: "Nicole Erler, Department of Biostatistics, Erasmus Medical Center"
#' date: "`r Sys.setenv(LANG = 'en_US.UTF-8'); format(Sys.Date(), '%d %B %Y')`"
#' output: 
#'   html_document:
#'     toc: true
#'     toc_float:
#'       collapsed: false
#' ---

#+  echo = FALSE
# This is not part of the demo. 
# It just allows the output to be wider (to make the html look nicer)
options(width = 105)


#' ## Dataset
#' We will work with the datasets `swiss` and `esoph` (both automatically availabe in R).
#' 

#' ## Transformations
#' ### The logarithm
#' In R, `log()` by default calculates the natural logarithm, i.e., the following
#' two commands are equal:
log(swiss$Fertility)
log(swiss$Fertility, base = exp(1))

#' For other commonly used bases we can use separate functions, e.g. `log2()` or
#' `log10`.
#' The argument `base` allows us to change the base of the logarithm to any value:
log(swiss$Fertility, base = 2)
log2(swiss$Fertility)

log(swiss$Fertility, base = 10)
log10(swiss$Fertility)

#' ### Other transformations
#' Exponential function
exp(swiss$Fertility)
#' Square root
sqrt(swiss$Fertility)
#' Absolute value
(x <- rnorm(10))
abs(x)
#' Distribution function of the logistic distribution: this function is for instance
#' useful to convert the linear predictor of a logistic model to the probability scale.
plogis(x)

#' ## Splitting & Combining
#' ### Dividing a (continuous) variable into a `factor`
#' The function `cut()` allows us to convert a numeric variable to a factor.
#' The arguments `breaks` is used to specify the cutoffs for the
#' categories.
(x <- rnorm(20))
cut(x, breaks = c(-1, 0, 1))
#' Note that values outside the smallest and largest "break" are set to `NA`.
#' To prevent that we can include `-Inf` and `Inf`:
cut(x, breaks = c(-Inf, -1, 0, 1, Inf))

#' By default, the lower bound of each interval is excluded, the upper bound is included.
#' We can include the lowest bound by setting `include.lowest = TRUE`.
cut(x, breaks = c(-Inf, -1, 0, 1, Inf), include.lowest = TRUE)
#' Note that this only changes the lower bound of the lowest interval.
#' The argument `right` specifies that the right bound of each interval is included,
#' this chan be changed by setting `right = FALSE`.
#' By default, the resulting factor is unordered. With the argument 
#' `ordered_result = TRUE` we can change this. (More on ordered factors later.)
#' 
#' To set custom labels for the categories, the argument `labels` can be used:
cut(x, breaks = c(-Inf, -1, 0, 1, Inf), labels = c('lowest', 'low', 'high', 'highest'))
#' 
 
#' ### Splitting a `data.frame`, `matrix` or `vector`
#' The function `split()` splits a `data.frame`, `matrix` or `vector` by one 
#' or more categorical variables:
split(swiss, f = swiss$Education > 10)
#' This creates a list with one element per category of `f`.
 
#' When the splitting factor has more categories, the list has more elemets:
split(swiss, f = cut(swiss$Education, c(0, 5, 10, 15, 20)))
#' Note that cases with Education > 20 are now excluded (because we set the highest
#' breakpoint in `cut()` to 20).

#' To include the "category" `NA`, we can use the function `addNA()`:
split(swiss, f = addNA(cut(swiss$Education, c(0, 5, 10, 15, 20))))

#' The list elements will always have the same class as the original object,
#' i.e., when we split a vector, we obtain a list of vectors:
split(x, x > 0)


#' ### Combining `vectors` etc.
#' The function `c()` allows us to combine values into a `vector` or a `list`,
#' the functions `cbind()` and `rbind()` combine objects (usually vectors,
#' matrices or data.frames) by column or row, respectively.
(x <- 1:5)
(y <- 3:7)
c(x, y)
cbind(x, y)
rbind(x, y)

#+ error = TRUE
(X <- matrix(nrow = 3, ncol = 2, data = LETTERS[1:6]))
(Y <- matrix(nrow = 4, ncol = 2, data = LETTERS[10:17]))

rbind(X,Y)
cbind(X,Y)
#' When combining matrices or data.frames, the dimensions must match.

#' When combining vectors, the shorter object is repeated up to the length of
#' the longer vector:
(z <- 1:9)
cbind(x, z)

#' When combining lists, behaviour depends on whether both elements are lists:
(list1 <- list(a = 4, b = c(1, 4, 6)))
c(list1, LETTERS[4:7])
c(list1, list(LETTERS[4:7]))

#' ### Combining strings
#' The function `paste()` (and it's special case `paste0()`) 
#' allows us to combine objects into strings:
paste0("The mean of x is ", mean(x), ".")

#' `paste()` has arguments `sep` and `collapse` that control how the different
#' objects and elements of the objects are combined:
paste("This", "is", "a", "sentence.", sep = " +++ ")
paste(c("This", "is", "a", "sentence."), collapse = " +++ ")

#' ### Getting a subset of a `data.frame`
#' The function `subset()` helps us to get a subset of a `data.frame`.
#' Its arguments `subset` and `select` are used to specify which cases and which
#' variables shouls be selected:
subset(swiss, 
       subset = Education > 15,
       select = c(Fertility, Education, Infant.Mortality))
#' Note that here we can use the variable names without quotes.
#' 

#' ### Merging data
#' The function `merge()` allows us to merge two datasets.
# Create two datasets
dat1 <- swiss
dat1$id <- rownames(swiss)
dat2 <- data.frame(id = c(paste0('newid', 1:5), rownames(swiss)[1:30]),
                   x = rnorm(35))

head(dat1)
head(dat2)

mdat <- merge(dat1, dat2)
head(mdat)
dim(mdat)

#' The arguments `all`, `all.x` and `all.y` allow us to specify what happens with
#' cases that are only found in one of the two datasets:
mdat_all <- merge(dat1, dat2, all = TRUE)
mdat_x <- merge(dat1, dat2, all.x = TRUE)
mdat_y <- merge(dat1, dat2, all.y = TRUE)

dim(mdat_all)
head(mdat_all)

dim(mdat_x)
dim(mdat_y)

#' By default, `merge()` will take all identical column names to merge by.
#' Arguments `by.x` and `by.y` allow us to specify the names of variables
#' in each of the datasets to use for merging. This is also possible when 
#' variable names differ:
dat2$z <- sample(1:10, size = nrow(dat2), replace = TRUE) # we add a new variable to the data
dat2$Examination <- dat1$Examination[match(dat2$id, dat1$id)]
mdat3 <- merge(dat1, dat2, by.x = c('id', 'Education'), by.y = c('id', 'z'),
               all = TRUE)

head(mdat3) 
#' * We now have two rows per `id` (for most `id`s), because the values in the
#'   merging variable `Education` (and `z`) differed between `dat1` and `dat2`.
#' * The variable `Examination`, which existed in both datasets, got the suffix
#'   `.x` and `.y` in is now duplicated. The suffix can be changed using the
#'   argument `suffixes`.

#' The function `match()` returns the positions of the (first) matches of its
#' first argument in its second argument.
(a <- c('G', 'A', 'D', 'B', 'Z'))
(b <- LETTERS[1:8])
match(a, b)

#' ## Repetition and Sequences
#' The function `rep()` replicates elements of a `vector` or a `list`.
rep(c('A', 'B'), 4)
rep(c('A', 'B'), each = 4)
rep(c('A', 'B'), c(2, 4))

rep(list(a = 4, s = "This is a string.", b = c('A', 'B', 'C')), 
    c(1, 3, 1))

#' The function `seq()` generates a sequence:
seq(from = 2, to = 5, by = 1)
seq(from = 2, to = 5, by = 0.5)
seq(from = 2, to = 5, length = 8)

seq_along(a)

#' The function `expand.grid()` creates a `data.frame` with all combinations of
#' the supplied variables:
expand.grid(x = c(1, 2, 3),
            a = c('a', 'b'))


#' ## Transforming objects
#' The function `t()` transposes a `matrix` or a `data.frame`:
(M <- matrix(nrow = 3, ncol = 2, data = 1:6))
t(M)
#' A `data.frame` is first converted to a `matrix`, then transposed.
#' A `vector` is seen as a column vector, i.e., transposing it will result in a 
#' `matrix` with one row:
(x <- c(1, 2, 3))
t(x)
t(t(x))

#' `unlist()` flattens lists:
(mylist <- list(a = c(2, 5, 1),
                b = list(name = 'Otto', age = 54, height = 182),
                c = matrix(nrow = 3, ncol = 2, data = 1:6)))

unlist(mylist)

otherlist <- list(a = list(LETTERS[1:5]),
                  b = list(names = c('Otto', 'Max'), 
                           ages = c(54, 45),
                           height = 182),
                  c = 33)

unlist(otherlist)
unlist(otherlist, recursive = FALSE)

unname(otherlist)
unlist(unname(otherlist), recursive = FALSE)


#' The functions `as.numeric()`, `as.matrix()` and `as.data.frame()` can be used
#' to convert objects to numeric vectors, matrices and data frames, respectively.
M
as.numeric(M)
as.data.frame(M)
as.matrix(head(swiss))


#' ## Sorting 
#' The function `sort()` allows us to sort a vector
a <- c(5, 3, 9, 44, 1, 4)
sort(a)

b <- factor(c("A", "Q", "D", "M"))
sort(b, decreasing = TRUE)

#' The function `order()` returns the order of the elements in a vector:
order(a)
#' i.e.: The smallest element of `a` is on the 5th position, the 2nd smallest 
#' element on the 2nd position, ...

#' To `rank()` the elements of `a`:
rank(a)
#' i.e.: the 1st element of `a` is the 4th smallest, the 2nd element is the
#' 2nd smallest, ...

#' With `rev()` we can reverse the order:
rev(a)

