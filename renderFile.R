renderFile <- function(file) {
  # owd = getwd()
  # setwd(dirname(file))
  # file = basename(file)
  output = gsub(".Rmd", ".R", file)
  ## Extract R code
  knitr::purl(file, output = output)
  
  ## Make presentation
  rmarkdown::render(file, output_format = c("html_document", "pdf_document", "word_document"))
  # on.exit({ 
  #   setwd(owd)
  # })
}
