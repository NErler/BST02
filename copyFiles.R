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


# remove docs folder
unlink("docs", recursive = TRUE)

# Build website
system2('hugo', args = "-s website")

# does not work, but I don't know why...
# system2('hugo server', args = "-s website")
