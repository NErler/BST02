
#*   R Basics                                 *#

###############################################\
#
# Here the basics of R are demonstrated. An R script consists of a number of
# statements  (expressions and assignments)
#
###############################################;

#  R Statements ====================================================

21 + 21               # Normally the result of an R *statment* is printed
res <- 21 + 21        # The resulting *object* can also be *assigned* to a
                      # variable  (also called 'symbol')
                      # Variable names are case sensitive!


res                   # By typing the name of the variable the results are
                      # printed

(a <- 3+ 4)

mode(res)             # All objects have a *mode*
class(res)            # They also have a *class*. The class dictates what can be
                      # done with an object

text <- 'hello world' # The same can be done with character objects.
                      # character literals need to be enclosed in single or
                      # double quotes



#  Basic R Objects ==============================================================

## vectors  =====================================================================

# R is a vectorized language meaning that usually there is no difference between
# working with single numbers of whole vectors.


# numeric vectors
x <- c(1,3,5,8,9,12)          # vectors are usually constructed with the c()
x                             # function (the c stands for combine)

# character vectors
x <- c("a", "ab", "abc")
x

# factors (for categorical data)
x <- factor(c('male', 'male', 'female', 'male', 'female'))
x

factor(c(1, 1, 2, 1, 2), levels=c(2,1),
       labels = c('M', 'F') )

# comparable with SPSS value labels and its distinction between covariates and
# factors or SASs formats / class variables

# ordered factors
t.shirt.size <- ordered(c("S", "M", "L", "L", "M", "S"))
t.shirt.size

# change the ordering of the levels
t.shirt.size <- ordered(c("S", "M", "L", "L", "M", "S"),
                    levels = c("S", "M", "L"))
t.shirt.size



# logical vectors
y <- c(TRUE, FALSE, TRUE)
y <- c(T, F, T)
 c(1, 7, 6) <= 6
TRUE & NA
TRUE | NA
any(y)
all(y)
!y

# computations ar done on the whole vector
c(1, 2) + c(3, 5)
c(1, 2) * c(3, 5)

## Matrices and arrays -----------------------------------

# A matrix is a rectangular (in rows and columns) lay out of data
# numeric matrices
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
mat.x <- matrix(x, nrow = 3)
mat.x
dim(mat.x)  # shows dimentions
dim(mat.x) <- c(2,6) # we can also change these dimensions
length(mat.x)
mat.x

mat.x <- matrix(x, ncol =   3, byrow = TRUE)

# Combining rows and columns
cbind(c(1,2), c(4,9))
rbind(c(1,2), c(4,9))

# We can also make matrices with other types (eg. character)
# but all data must have the same type

# creating arrays
M<-array(1:9, c(3, 3))
class(M)
array(1:27, c(3, 3, 3))

## Lists and data frames

### lists
# a list can store data of different types. Also the members of the list do not
# all have the same size
mylist <- list(x = c(1, 5, 11, 12),
            names = c("Tom Verlaine", "Richard Hell", "Billy Ficca"),
            logic = c(FALSE, FALSE, TRUE, FALSE, TRUE))

list(matrix(1:4,2), mylist)

### data.frames
# data frames are rectangular lay outs of data where every column corresponds
# to a variable which can have a different type
# the number of observations has to be the same for all columns
mydf <- data.frame(n = c(1,2,3),
                   abc = c("x", "xy", "xyz"),
                   logic = c(TRUE, FALSE, TRUE))
mydf

## Sequences and replication ===========================================================

# creating sequences
seq(1, 10)                 # all inters from 1 to 20
seq(1, 10, by = 2)         # by steps of two
seq(1, 10, length.out = 12) # length of output vector
1:10                       #shorthand
10:1

# replicating elements of vectors
rep(1:5, 2)
rep(1:5, each = 2)
rep(1:5, times = 2)
rep(6:10, times=1:5)



# Indexing ==================================================================

## Indexing vectors =========================================================

x <- -3:4

# position indexing, i.e., keep (or exclude) elements at specified positions
x[1]           # element at the specified position is selected (first element is 1)
x[c(1,2)]      # we can also use a vector
x[c(1,1,2,2)]  # replication is possible
x[-c(1,2,3)]   # negative indices exclude the elements at the specified position


# you can also assign new values
x[c(1,3)] <- 0 # here we replace the 1st, 3rd and 5th elements of 'x' with 0


# logical indexing, i.e., keep the elements for which a condition holds
x > 0
x[x > 0]

# name indexing: it is possible to give names for each element of a vector
x <- c("a" = 1, "b" = 2, "c" = 3, "d" = 4)
x
# we can extract elements by name
x[c("a", "c", "e")]

## matrix indexing ===========================================================
mat <- matrix(1:12, 3)
mat
mat[2, 3]
mat[c(1,2), 3]
mat[1:2, ] # extract rows
mat[, 3:4] # extract columns
mat[mat[, 3] >= 8, ]
mat2 <- matrix(rep(1:3,each=2), 3)
mat[mat2]

## array indexing ============================================================
arr <- array(1:27, c(3, 3, 3))
arr
arr[1, 2, 3]

# the 'drop' argument
mat <- matrix(1:20, 5, 4)
mat
mat[1, ] # not a matrix!!!
mat[, 2] # not a matrix!!!
mat[1, , drop = FALSE]
mat[, 2, drop = FALSE]

## list indexing =============================================================
mylist <- list(x = 1:5, a = c('egg','bacon', 'spam'),
    m = matrix(2:13, 4), l = list(1, 1:2))
mylist[[3]]
mylist[3] # NB: returns a list with one item not a matrix !!
mylist[2:3]
mylist[["m"]] # by name
mylist$m      # shorthand

# you can delete an item by setting it to NULL
mylist$m <- NULL
mylist

## data.frame indexing ======================================================

df <- data.frame(
    id = rep(1:10, each = 2),
    sex = rep(c("male", "female"), each = 10),
    week = rep(6:7, times=10),
    CRL = seq(20,115,5)
)

df[2:3] # 2nd and 3rd column
df[3] # dfa.frame with a single variable
df[[3]] # 3rd variable in the dfa.frame
df["CRL"] # dfa.frame with a single variable
df[["CRL"]] # extract variable by name
df$CRL # the same as above

df[1:6, ] # first 6 rows
df[df$sex == "male", ] # only the males
df[df$sex == "male" & df$week > 6, ] # the males with week greater than 6

# extract the CRL for the first visit of females
df[df$sex == "female", "CRL"]

# indexing by row.names
row.names(df) <- paste0(df$id,'w', df$week)
df
df[c("6w7", "8w6"), ]

ls()
save(list = list(mat.x, mylist), file = 'saving.Rdata')
saveRDS(mylist, file = 'saveRDS.Rds')
newvar <- readRDS('saveRDS.Rds')
newvar
