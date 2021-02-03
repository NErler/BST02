#################
# Load packages #
#################

# install.packages("shiny")
# install.packages("sirvival")
library(survival)
library(shiny)


################################################
# Give the data and information that is needed #
################################################

pbc$status <- factor(pbc$status, levels = c(0, 1, 2), 
                     labels = c("censored", "transplant", "dead"))
pbc$ascites <- factor(pbc$ascites, levels = c(0, 1), 
                      labels = c("no", "yes"))
pbc$hepato <- factor(pbc$hepato, levels = c(0, 1), 
                     labels = c("no", "yes"))
pbc$spiders <- factor(pbc$spiders, levels = c(0, 1), 
                      labels = c("no", "yes"))
pbc$trt <- factor(pbc$trt, levels = c(1, 2), 
                      labels = c("D-penicillmain", "placebo"))
pbc$stage <- factor(pbc$stage, levels = c(1, 2, 3, 4), 
                      labels = c("1", "2", "3", "4"))

is.fact <- sapply(pbc, is.factor)
is.num <- sapply(pbc, is.numeric)
is.num[1] <- FALSE

#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("Explore the apply family using the pbc data set from the survival package"),
  
  # Text input 
  tabsetPanel(
    tabPanel("Simple apply examples",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select the continous covariates (either as numbers or as names) that you want to investigate 
                   (they have to be >= than two - e.g. c("time", "age") or c(2, 5))'),
                 textInput("covariates1", "Continuous covariates", 
                           value = ""),
                 
                 p('Select whether you want to investigate the covariate by row or column'),
                 selectInput("rowscolunms", "By",
                             choices = c("rows", "columns"),
                             selected = "rows"),
                 
                 p('Select which statistic you are going to use'),
                 selectInput("stats", "Statistic",
                             choices = c("mean", "median", "sd", "sum", "IQR", "min", "max"),
                             selected = "mean")
                 
                 
                 
               ),
               mainPanel(
                 
                 tabsetPanel(
                   tabPanel("Rcode", verbatimTextOutput("Rcode")),
                   tabPanel("Output",  verbatimTextOutput("Routput")))
                 
               )
             )
    ),
    tabPanel("Simple tapply examples",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select a continuous covariate'),
                 selectInput("continuous2", "Continuous covariates",
                             choices = colnames(pbc[, is.num]),
                             selected = "age"),
                 
                 p('Select a categorical covariate'),
                 selectInput("factors2", "Categorical covariates",
                             choices = colnames(pbc[, is.fact]),
                             selected = "sex"),

                 
                 p('Select which statistic you are going to use'),
                 selectInput("stats2", "Statistic",
                             choices = c("mean", "median", "sd", "sum", "IQR", "min", "max"),
                             selected = "mean")
                 
                 
                 
                 ),
               mainPanel(
                 
                 tabsetPanel(
                   tabPanel("Rcode", verbatimTextOutput("Rcode2")),
                   tabPanel("Output",  verbatimTextOutput("Routput2")))
                 
               )
              )
      ),
    tabPanel("lapply/sapply examples",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select the continous covariates (either as numbers or as names) that you want to investigate 
                   (they have to be >= than two - e.g. c("time", "age") or c(2, 5))'),
                 textInput("continuous3", "Continuous covariates", 
                           value = ""),
                 
                 
                 p('Select which statistic you are going to use'),
                 selectInput("stats3", "Statistic",
                             choices = c("mean", "standardize", "sd", "sum", "IQR", "min", "max"),
                             selected = "mean"),
                 
                 p('Select which apply function you want'),
                 selectInput("applys3", "Apply",
                             choices = c("lapply", "sapply"),
                             selected = "lapply")
                 
                 
               ),
               mainPanel(
                 
                 tabsetPanel(
                   tabPanel("Rcode", verbatimTextOutput("Rcode3")),
                   tabPanel("Output",  verbatimTextOutput("Routput3")))
                 
               )
             )
    )

    
  ) 
)





server <- function(input, output) {
  
  output$Rcode <- renderText({
    rowcol <- if (input$rowscolunms == "rows") {
      1
    } else {
      2
    }
    return(paste0("apply(pbc[ , ", (input$covariates1), "], ", rowcol, ", ", input$stats, ", na.rm = TRUE)"))
  })
  
  output$Routput <- renderText({
    rowcol <- if (input$rowscolunms == "rows") {
      1
    } else {
      2
    }
    code1 <- paste0("apply(pbc[ ,", input$covariates1, "], ", rowcol, ", ", input$stats, ", na.rm = TRUE)")
    eval(parse(text = code1))
  })
  
  
  output$Rcode2 <- renderText({
    return(paste0("tapply(pbc$", input$continuous2, ", pbc$", input$factors2, ", ", input$stats2, ", na.rm = TRUE)"))
  })
  
  output$Routput2 <- renderText({
    code1 <- paste0("tapply(pbc$", input$continuous2, ", pbc$", input$factors2, ", ", input$stats2, ", na.rm = TRUE)")
    eval(parse(text = code1))
  })
  
  output$Rcode3 <- renderText({
    if (input$stats3 == "standardize") {
      stats3 <- paste0("function(x) (x-mean(x))/sd(x)")
    } else {
      stats3 <- input$stats3
    }
    return(paste0(input$applys3, "(pbc[ , ", input$continuous3, "], ", stats3, ")"))
  })
  
  output$Routput3 <- renderPrint({
    if (input$stats3 == "standardize") {
      stats3 <- paste0("function(x) (x-mean(x))/sd(x)")
    } else {
      stats3 <- input$stats3
    }
    code1 <- paste0(input$applys3, "(pbc[, ", input$continuous3, "], ", stats3, ")")
    eval(parse(text = code1))
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

