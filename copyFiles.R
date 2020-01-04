write_Demos_md <- function(title) {
  filenames <- unique(gsub('.R$|.html$', '', 
                           dir(file.path(getwd(), 'Demos', title))))
  cat(
    paste0("---\n",
           "title: ", title, "\n",
           "---\n\n"
    ),
    paste0(
      "* ", filenames,
      " [[R]](/demo/", x, "/", filenames, ".R)",
      " [[html]](/demo/", x, "/", filenames, ".html)",
      "\n"
    ), file = paste0('website/content/demo/', x, '.md')
  )
}

# Copy all files in folder Demos to the corresponding folders in website/static/demo
for (x in dir('Demos')) {
  dir.create(file.path('website/static/demo', x))
  file.copy(from = dir(file.path(getwd(), 'Demos', x), full.names = TRUE),
            to = file.path('website/static/demo', x),
            overwrite = TRUE)
  
  # dir.create(file.path('website/content/demo', x))
  write_Demos_md(title = x)
}
