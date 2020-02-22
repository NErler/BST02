# helpfunction
write_Demos_md <- function(x) {
  xnew <- gsub(' ', '-', tolower(x))
  
  filenames <- unique(gsub('.R$|.html$|.Rmd$', '', 
                           grep('.R$|.html$|.Rmd$', 
                                dir(file.path(getwd(), 'Demos', x)), value = TRUE)))
  
  topics <- setNames(gsub("\\_", " ", filenames), filenames)
  
  filetypes <- sapply(filenames, function(file) {
    gsub("^[[:print:]]*\\.", '', grep(paste0(file, '\\.'), dir(file.path(getwd(), 'Demos', x)), value = TRUE))
  }, simplify = FALSE)

  
  cat(
    paste0("---\n",
           "title: ", x, "\n",
           "---\n\n"
    ),
    paste0(
      sapply(filenames, function(file) {
        paste0("* ", topics[file],
               paste0(
                 sapply(filetypes[[file]], function(type) {
                   paste0(" [[", type, "]](/demo/", xnew, "/", file, ".", type, ")")
                 }), collapse = ' '))
    }), collapse = "\n"), file = paste0('website/content/demo/', x, '.md')
  )
}

write_Practicals_md <- function(x) {
  xnew <- gsub(' ', '-', tolower(x))
  
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

write_Slides_md <- function(x) {
  file <- gsub('^Slides/', '', x)
  title <- gsub('.pdf$', '', gsub("_", ' ', sub("_", ': ', file)))
  img <- gsub('.pdf$', '.png', file)
  
  
  cat(
    paste0("---\n",
           "title: '", title, "'\n",
           "link: /slide/", file, "\n",
           "image: /slide/", img, "\n",
           "---\n\n"
    ), file = paste0('website/content/slide/', gsub('.pdf$', '', file), '.md')
  )
}

################################################################################
## Demos
################################################################################
# Render all R files in Demos to html
for (xxx in dir('Demos', full.names = TRUE)) {
  Rfiles <- grep('.R$|.Rmd$', dir(xxx, full.names = TRUE), value = TRUE)
  htmlfiles <- grep('.html$', dir(xxx, full.names = TRUE), value = TRUE)
  file.remove(htmlfiles)
  if (length(grep("shiny", Rfiles)) >= 1) {
    shinyFiles <- grep("shiny", Rfiles)
    Rfiles <- Rfiles[-shinyFiles]
  }
  for (k in Rfiles) {
    rmarkdown::render(k)
  } 
}



# remove content of website/content/demo and website/static/demo
unlink('website/content/demo/*')
unlink('website/static/demo/*', recursive = TRUE)

# Copy all files in folder Demos to the corresponding folders in website/static/demo
for (x in dir('Demos')) {
  xnew <- gsub(' ', '-', tolower(x))
  dir.create(file.path('website/static/demo', xnew))
  files <- dir(file.path(getwd(), 'Demos', x), full.names = TRUE)
  file.copy(from = grep('.R$|.html$|.Rmd$', files, value = TRUE),
            to = file.path('website/static/demo', xnew),
            overwrite = TRUE)
  
  write_Demos_md(x)
}


################################################################################
## Practicals
################################################################################
# Render all R files in Practicals to html
for (x in list.dirs('Practicals', recursive = FALSE)) {
  Rmd_files <- grep('.Rmd$', dir(x, full.names = TRUE), value = TRUE)
  html_files <- grep('.html$', dir(x, full.names = TRUE), value = TRUE)
  file.remove(html_files)
  
  for (k in Rmd_files) {
    rmarkdown::render(k)
  }
}


# remove content of website/content/practical and website/static/practical
unlink('website/content/practical/*')
unlink('website/static/practical/*', recursive = TRUE)

# Copy all .html files in folder Practicals to the corresponding folders in website/static/practical
for (x in list.dirs('Practicals', recursive = FALSE)) {
  x <- gsub('Practicals/', '', x)
  
  xnew <- gsub(' ', '-', tolower(x))
  
  dir.create(file.path('website/static/practical', xnew))
  
  html_files <- grep('.html$', dir(file.path(getwd(), 'Practicals', x),
                                   full.names = TRUE), value = TRUE)
  
  file.copy(from = html_files,
            to = file.path('website/static/practical', xnew),
            overwrite = TRUE)
  
  write_Practicals_md(x)
}



################################################################################
## Slides
################################################################################

# compile all slides
Rmdfiles <- grep('.Rmd$', dir('Slides', full.names = TRUE), value = TRUE)
sapply(Rmdfiles, rmarkdown::render)

# remove unnecessary files created during compilation 
sapply(c('.log', '.tex', '.aux', '.out', '.vrb', '.snm', '.nav', '.toc'),
       function(k) {
         file.remove(gsub('.Rmd$', k, Rmdfiles))
       })

# remove content of website/content/slide and website/static/slide
unlink('website/content/slide/*')
unlink('website/static/slide/*')


# Copy all .pdf files in folder Slides to the corresponding folders in website/static/slide
pdfs <- grep(".pdf$", dir('Slides', recursive = FALSE, full.names = TRUE), value = TRUE)
file.copy(from = pdfs,
          to = file.path('website/static/slide'),
          overwrite = TRUE)

# write .md files for website/content/slide
for (x in pdfs) {
  write_Slides_md(x)
  
  img <- gsub('Slides/', '', gsub('.pdf$', '.png', x))
  
  # the following gives an error/message but works anyway
  pdftools::pdf_convert(x, pages = 1, dpi = 150,
                        filenames = paste0('website/static/slide/', img))
}




################################################################################
## make the .zip file
################################################################################

demos <- sapply(list.dirs('Demos', recursive = FALSE), function(x) {
  grep('.html$|.R$|.Rmd$', dir(x, full.names = TRUE), value = TRUE)
})

practicals <- sapply(list.dirs('Practicals', recursive = FALSE), function(x) {
  grep('.html$', dir(x, full.names = TRUE), value = TRUE)
})

slides <- grep(".pdf$", dir('Slides', recursive = FALSE, full.names = TRUE), value = TRUE)


# create a .zip
zip(zipfile = 'website/static/slide/BST02_2020', files = unlist(c(demos, practicals, slides)))


################################################################################
## update webpage
################################################################################
# remove docs folder
unlink("docs", recursive = TRUE)

# Build website
system2('hugo', args = "-s website")

# does not work, but I don't know why...
# system2('hugo server', args = "-s website")
# Works when running in the Terminal though: hugo -s website
