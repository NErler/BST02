# helpfunction
write_Demos_md <- function(x) {
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
      " [[R]](/demo/", x, "/", files, ".R)",
      " [[html]](/demo/", x, "/", files, ".html)",
      "\n"
    ), file = paste0('website/content/demo/', x, '.md')
  )
}

write_Practicals_md <- function(x) {
  files <- unique(gsub('.Rmd$|.html$', '', 
                       dir(file.path(getwd(), 'Practicals', x))))
  
  filenames <- gsub("\\_", " ", files)
  cat(
    paste0("---\n",
           "title: ", x, "\n",
           "---\n\n"
    ),
    paste0(
      "* ", filenames,
      " [[html]](/practical/", x, "/", files, ".html)",
      "\n"
    ), file = paste0('website/content/practical/', x, '.md')
  )
}

################################################################################
## Demos
################################################################################
# Render all R files in Demos to html
for (x in dir('Demos')) {
  Rfiles <- grep('.R$', dir(file.path('Demos', x)), value = TRUE)
  sapply(file.path('Demos', x, Rfiles), rmarkdown::render)
}


# Copy all files in folder Demos to the corresponding folders in website/static/demo
for (x in dir('Demos')) {
  dir.create(file.path('website/static/demo', x))
  file.copy(from = dir(file.path(getwd(), 'Demos', x), full.names = TRUE),
            to = file.path('website/static/demo', x),
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

# Copy all .html files in folder Practicals to the corresponding folders in website/static/practical
for (x in list.dirs('Practicals', recursive = FALSE)) {
  x <- gsub('Practicals/', '', x)
  dir.create(file.path('website/static/practical', x))
  
  html_files <- grep('.html$', dir(file.path(getwd(), 'Practicals', x),
                                   full.names = TRUE), value = TRUE)
  
  file.copy(from = html_files,
            to = file.path('website/static/practical', x),
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
