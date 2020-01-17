# helpfunction
write_Demos_md <- function(x) {
  xnew <- gsub(' ', '_', x)
  
  files <- unique(gsub('.R$|.html$', '', 
                       dir(file.path(getwd(), 'Demos', x))))
  
  filenames <- gsub("\\_", " ", files)
  cat(
    paste0("---\n",
           "title: ", x, "\n",
           "---\n\n"
    ),
    paste0(
      "* ", filenames,
      " [[R]](/demo/", xnew, "/", files, ".R)",
      " [[html]](/demo/", xnew, "/", files, ".html)",
      "\n"
    ), file = paste0('website/content/demo/', x, '.md')
  )
}

write_Practicals_md <- function(x) {
  xnew <- gsub(' ', '_', x)
  
  files <- gsub('.Rmd$', '',
                grep('.Rmd$', dir(file.path(getwd(), 'Practicals', x)),
                     value = TRUE)
  )
  
  filenames <- gsub("\\_", " ", files)
  cat(
    paste0("---\n",
           "title: ", x, "\n",
           "---\n\n"
    ),
    paste0(
      "* ", filenames,
      " [[html]](/practical/", xnew, "/", files, ".html)",
      "\n"
    ), file = paste0('website/content/practical/', x, '.md')
  )
}

################################################################################
## Demos
################################################################################
# Render all R files in Demos to html
for (xxx in dir('Demos')) {
  Rfiles <- grep('.R$', dir(file.path('Demos', xxx)), value = TRUE)
  sapply(file.path('Demos', xxx, Rfiles), rmarkdown::render)
}


# remove content of website/content/demo and website/static/demo
unlink('website/content/demo/*')
unlink('website/static/demo/*', recursive = TRUE)

# Copy all files in folder Demos to the corresponding folders in website/static/demo
for (x in dir('Demos')) {
  xnew <- gsub(' ', '_', x)
  dir.create(file.path('website/static/demo', xnew))
  file.copy(from = dir(file.path(getwd(), 'Demos', x), full.names = TRUE),
            to = file.path('website/static/demo', xnew),
            overwrite = TRUE)
  
  write_Demos_md(x)
}


################################################################################
## Practicals
################################################################################
# Render all R files in Practicals to html
for (x in list.dirs('Practicals', recursive = FALSE)) {
  Rmd_files <- grep('.Rmd$', dir(x), value = TRUE)
  sapply(file.path(x, Rmd_files), rmarkdown::render)
}


# remove content of website/content/practical and website/static/practical
unlink('website/content/practical/*')
unlink('website/static/practical/*', recursive = TRUE)

# Copy all .html files in folder Practicals to the corresponding folders in website/static/practical
for (x in list.dirs('Practicals', recursive = FALSE)) {
  x <- gsub('Practicals/', '', x)
  
  xnew <- gsub(' ', '_', x)
  
  dir.create(file.path('website/static/practical', xnew))
  
  html_files <- grep('.html$', dir(file.path(getwd(), 'Practicals', x),
                                   full.names = TRUE), value = TRUE)
  
  file.copy(from = html_files,
            to = file.path('website/static/practical', xnew),
            overwrite = TRUE)
  
  write_Practicals_md(x)
}


################################################################################
## update webpage
################################################################################
# remove docs folder
unlink("docs", recursive = TRUE)

# Build website
system2('hugo', args = "-s website")

# does not work, but I don't know why...
# system2('hugo server', args = "-s website")
# Works when running in the Terminal though
