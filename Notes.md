
# Notes

* Explain difference between `Error`, `Warning` and `Message`?
* In which part do we practice with logical operators (`&`, `|`, `&&`, `==`, ...)? (Elrozy: `&`, `|`, `==`)
* What about contrasts? `contr.treatment` etc. (Nicole)
* Maybe useful: https://stat.ethz.ch/R-manual/R-devel/doc/html/packages.html
* List of datasets: https://vincentarelbundock.github.io/Rdatasets/datasets.html

# Slides

## Part A
* add a part explaining how to run syntax in R and Rstudio (explain also Refresh and change the setting)

## Part B
### Data Structures
* arrays: we do not present them
* matrix: has as elements scalars. Make it clear.


### Data Transformations
* maybe we shouldn't refer to "outliers" but "extreme values" or "values in a range of interest" (Elrozy: change outliers to a range of values)

### Data Exploration
* `percent()` is not a function (add package as note)

#### General
* Consider moving indexing before data manipulation

## Part C: Functions
### Functions for exploring data
* <div style = "color:lightgrey">Have the students already practiced subsetting in Part B? Yes</div>
* <div style = "color:lightgrey">Should `subset()` go into Part B (subsetting) or Part C (functions)? Part C</div>
* <div style = "color:lightgrey">Do we really need the matrix algebra? No</div>
* Add a section for creating objects (`matrix`, `data.frame`, ...)
* For practical "Summarizing Data" students need to know the functions `factor()`, 
  `sqrt()` and `^`. Nicole: `sqrt()` need to be explained in Functions
* Not yet in practical for data exploration:
  Correlation, covariance, duplicates, function `ave()`

* Link to [https://rstudio.com/resources/cheatsheets/](https://rstudio.com/resources/cheatsheets/)?

### The apply family
* Page 38: change the summary. Maybe give an overview per apply function.

## Part D: Regression
## * need recap of C / day 3

## Part E: Markdown
* add explanation on how to run a Markdown report (where to click)

# Demos
* Maybe remove some Demos in extra programming -> it is too much for the students, it goes fast

# Website
* for some reason the slides render (from the copyFiles) stops after the C_slides. Works if I reun:
`for (i in 1:length(Rmdfiles)) { rmarkdown::render(Rmdfiles[i]) }`