#################
# Load packages #
#################

# install.packages("shiny")
# install.packages("JM")
library(JM)
library(shiny)


################################################
# Give the data and information that is needed #
################################################

is.fact <- sapply(pbc2.id, is.factor)
is.num <- sapply(pbc2.id, is.numeric)


#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("Explore the apply family using the pbc2.id data set"),
  
  # Text input 
  tabsetPanel(
    tabPanel("Simple apply examples",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select the continous covariates (either as number or as name) that you want to investigate 
                   (they have to be >= than two - e.g. c("years", "age") or c(2, 5))'),
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
                             choices = colnames(pbc2.id[, is.num]),
                             selected = "age"),
                 
                 p('Select a categorical covariate'),
                 selectInput("factors2", "Categorical covariates",
                             choices = colnames(pbc2.id[, is.fact]),
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
                 
                 p('Select the continous covariates (either as number or as name) that you want to investigate 
                   (they have to be >= than two - e.g. c("years", "age") or c(2, 5))'),
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
    return(paste0("apply(pbc2.id[ , ", (input$covariates1), "], ", rowcol, ", ", input$stats, ")"))
  })
  
  output$Routput <- renderText({
    rowcol <- if (input$rowscolunms == "rows") {
      1
    } else {
      2
    }
    code1 <- paste0("apply(pbc2.id[ ,", input$covariates1, "], ", rowcol, ", ", input$stats, ")")
    eval(parse(text = code1))
  })
  
  
  output$Rcode2 <- renderText({
    return(paste0("tapply(pbc2.id$", input$continuous2, ", pbc2.id$", input$factors2, ", ", input$stats2, ")"))
  })
  
  output$Routput2 <- renderText({
    code1 <- paste0("tapply(pbc2.id$", input$continuous2, ", pbc2.id$", input$factors2, ", ", input$stats2, ")")
    eval(parse(text = code1))
  })
  
  output$Rcode3 <- renderText({
    if (input$stats3 == "standardize") {
      stats3 <- paste0("function(x) (x-mean(x))/sd(x)")
    } else {
      stats3 <- input$stats3
    }
    return(paste0(input$applys3, "(pbc2.id[ , ", input$continuous3, "], ", stats3, ")"))
  })
  
  output$Routput3 <- renderPrint({
    if (input$stats3 == "standardize") {
      stats3 <- paste0("function(x) (x-mean(x))/sd(x)")
    } else {
      stats3 <- input$stats3
    }
    code1 <- paste0(input$applys3, "(pbc2.id[, ", input$continuous3, "], ", stats3, ")")
    eval(parse(text = code1))
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

