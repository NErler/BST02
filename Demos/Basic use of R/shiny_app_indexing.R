#################
# Load packages #
#################

# install.packages("shiny")
# install.packages("survival")
library(survival)
library(shiny)

pbc <- survival::pbc

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
is.fact <- sapply(pbc, is.factor)
is.fact[1] <- FALSE
pbcCAT <- pbc[, is.fact]
subcat <- sapply(colnames(pbcCAT), function(x) levels(pbc[[x]]))
subcat[["id"]] <- NULL

is.num <- sapply(pbc, is.numeric)

#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("Explore indexing using the pbc data from the survival package"),
  
  # Text input 
  tabsetPanel(
    tabPanel("Simple row and column indexing",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select rows and columns'),
                 p('The rows can be selected as numbers (e.g. 2 or c(2,5))'),
                 p('The columns can be selected as numbers and names (e.g.  2 or c(1, 5, 6) or c("sex") or c("id", "age", "sex"))'),
                 
                 textInput("rows", "Select rows", 
                           value = ""),
                 textInput("columns", "Select columns", 
                           value = "")

                 
               ),
               mainPanel(

                 tabsetPanel(
                            tabPanel("Rcode", verbatimTextOutput("Rcode")),
                            tabPanel("Output",  tableOutput("Routput")))
                                           
               )
             )
    ),
    tabPanel("Simple logical indexing",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select a categorical variable'),
                 
                 selectInput("factors2", "Categorical variables",
                              choices = colnames(pbc[, is.fact]),
                             selected = "status"),
                 
                 p('Select the caregory of this variable'),
                 
                 conditionalPanel(condition = 'input.factors2 == "status"', 
                                  uiOutput("status2")),
                 conditionalPanel(condition = 'input.factors2 == "drug"', 
                                  uiOutput("drug2")),
                 conditionalPanel(condition = 'input.factors2 == "sex"', 
                                  uiOutput("sex2")),
                 conditionalPanel(condition = 'input.factors2 == "ascites"', 
                                  uiOutput("ascites2")),
                 conditionalPanel(condition = 'input.factors2 == "hepato"', 
                                  uiOutput("hepato2")),
                 conditionalPanel(condition = 'input.factors2 == "spiders"', 
                                  uiOutput("spiders2")),
                 conditionalPanel(condition = 'input.factors2 == "edema"', 
                                  uiOutput("edema2"))

                 
               ),
               mainPanel(

                  tabsetPanel(
                    tabPanel("Rcode", verbatimTextOutput("Rcode2")),
                    tabPanel("Output",  tableOutput("Routput2")))

               )
             )
    ),
    
    tabPanel("More complex logical indexing (categorical variables)",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select a categorical variable'),
                 
                 selectInput("factors3a", "Categorical variables",
                             choices = colnames(pbc[, is.fact]),
                             selected = "drug"),
                 
                 p('Select the caregory of this variable'),
                 
                 conditionalPanel(condition = 'input.factors3a == "status"', 
                                  uiOutput("status3a")),
                 conditionalPanel(condition = 'input.factors3a == "drug"', 
                                  uiOutput("drug3a")),
                 conditionalPanel(condition = 'input.factors3a == "sex"', 
                                  uiOutput("sex3a")),
                 conditionalPanel(condition = 'input.factors3a == "ascites"', 
                                  uiOutput("ascites3a")),
                 conditionalPanel(condition = 'input.factors3a == "hepato"', 
                                  uiOutput("hepato3a")),
                 conditionalPanel(condition = 'input.factors3a == "spiders"', 
                                  uiOutput("spiders3a")),
                 conditionalPanel(condition = 'input.factors3a == "edema"', 
                                  uiOutput("edema3a")),
                 
                 p('Select a categorical variable'),
                 
                 selectInput("factors3b", "Categorical variables",
                             choices = colnames(pbc[, is.fact]),
                             selected = "status"),
                 
                 p('Select the caregory of this variable'),
                 
                 conditionalPanel(condition = 'input.factors3b == "status"', 
                                  uiOutput("status3b")),
                 conditionalPanel(condition = 'input.factors3b == "drug"', 
                                  uiOutput("drug3b")),
                 conditionalPanel(condition = 'input.factors3b == "sex"', 
                                  uiOutput("sex3b")),
                 conditionalPanel(condition = 'input.factors3b == "ascites"', 
                                  uiOutput("ascites3b")),
                 conditionalPanel(condition = 'input.factors3b == "hepato"', 
                                  uiOutput("hepato3b")),
                 conditionalPanel(condition = 'input.factors3b == "spiders"', 
                                  uiOutput("spiders3b")),
                 conditionalPanel(condition = 'input.factors3b == "edema"', 
                                  uiOutput("edema3b")),
                 
                 p('Select the logical expression'),
                 
                 selectInput("select", "And/or",
                             choices = c("and", "or"),
                             selected = "and")
                 
                 
               ),
               mainPanel(

                 tabsetPanel(
                   tabPanel("Rcode", verbatimTextOutput("Rcode3")),
                   tabPanel("Output",  tableOutput("Routput3")))
                 
               )
             )
    ),
    
    tabPanel("More complex logical indexing (continuous and categorical variables)",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 p('Select a categorical variable'),
                 
                 selectInput("factors4", "Categorical variables",
                             choices = colnames(pbc[, is.fact]),
                             selected = "drug"),
                 
                 p('Select the caregory of this variable'),
                 
                 conditionalPanel(condition = 'input.factors4 == "status"', 
                                  uiOutput("status4")),
                 conditionalPanel(condition = 'input.factors4 == "drug"', 
                                  uiOutput("drug4")),
                 conditionalPanel(condition = 'input.factors4 == "sex"', 
                                  uiOutput("sex4")),
                 conditionalPanel(condition = 'input.factors4 == "ascites"', 
                                  uiOutput("ascites4")),
                 conditionalPanel(condition = 'input.factors4 == "hepato"', 
                                  uiOutput("hepato4")),
                 conditionalPanel(condition = 'input.factors4 == "spiders"', 
                                  uiOutput("spiders4")),
                 conditionalPanel(condition = 'input.factors4 == "edema"', 
                                  uiOutput("edema4")),
                 
                 p('Select a numerical variable'),
                 
                 selectInput("numerics", "Numerical variables",
                             choices = colnames(pbc[, is.num]),
                             selected = "age"),
                 
                 p('Speficy the cut off value for the variable'),
                 numericInput("numbers", "Number", value = 1, min = 20, max = 1000, step = NA,
                              width = NULL),
                 
                 p('Speficy whether you want to show > or <= values'),
                 
                 selectInput("smaller_lower", "higher/lower and equal",
                             choices = c(">", "<="),
                             selected = ">"),
                 
                 p('Select the logical expression'),
                 
                 selectInput("select2", "And/or",
                             choices = c("and", "or"),
                             selected = "and"),
                 
                 p('Select which columns to show'),
                 p('The columns can be selected as numbers and names (e.g. "sex" or c("id", "age", "sex"))'),
                 
                 textInput("columns2", "Select columns", 
                           value = "")
                
                 
               ),
               mainPanel(
                 
                 tabsetPanel(
                   tabPanel("Rcode", verbatimTextOutput("Rcode4")),
                   tabPanel("Output",  tableOutput("Routput4")))
                 
               )
             )
    )
    
  ) 
)
               




server <- function(input, output) {
  
  output$status2 <- renderUI({
    selectInput("status2", "Categories", 
                choices = subcat$status, selected = "alive")
  })
  output$status3a <- renderUI({
    selectInput("status3a", "Categories", 
                choices = subcat$status, selected = "alive")
  })
  output$status3b <- renderUI({
    selectInput("status3b", "Categories", 
                choices = subcat$status, selected = "alive")
  })
  output$status4 <- renderUI({
    selectInput("status4", "Categories", 
                choices = subcat$status, selected = "alive")
  })
  
  output$drug2 <- renderUI({
    selectInput("drug2", "Categories", 
                choices = subcat$drug, selected = "placebo")
  })
  output$drug3a <- renderUI({
    selectInput("drug3a", "Categories", 
                choices = subcat$drug, selected = "placebo")
  })
  output$drug3b <- renderUI({
    selectInput("drug3b", "Categories", 
                choices = subcat$drug, selected = "placebo")
  })  
  output$drug4 <- renderUI({
    selectInput("drug4", "Categories", 
                choices = subcat$drug, selected = "placebo")
  })
  
  
  output$sex2 <- renderUI({
    selectInput("sex2", "Categories", 
                choices = subcat$sex, selected = "male")
  })
  output$sex3a <- renderUI({
    selectInput("sex3a", "Categories", 
                choices = subcat$sex, selected = "male")
  })
  output$sex3b <- renderUI({
    selectInput("sex3b", "Categories", 
                choices = subcat$sex, selected = "male")
  })
  output$sex4 <- renderUI({
    selectInput("sex4", "Categories", 
                choices = subcat$sex, selected = "male")
  })
  
  output$ascites2 <- renderUI({
    selectInput("ascites2", "Categories", 
                choices = subcat$ascites, selected = "No")
  })
  output$ascites3a <- renderUI({
    selectInput("ascites3a", "Categories", 
                choices = subcat$ascites, selected = "No")
  })
  output$ascites3b <- renderUI({
    selectInput("ascites3b", "Categories", 
                choices = subcat$ascites, selected = "No")
  })
  output$ascites4 <- renderUI({
    selectInput("ascites4", "Categories", 
                choices = subcat$ascites, selected = "No")
  })
  
  output$hepato2 <- renderUI({
    selectInput("hepato2", "Categories", 
                choices = subcat$hepato, selected = "No")
  })
  output$hepato3a <- renderUI({
    selectInput("hepato3a", "Categories", 
                choices = subcat$hepato, selected = "No")
  })
  output$hepato3b <- renderUI({
    selectInput("hepato3b", "Categories", 
                choices = subcat$hepato, selected = "No")
  })
  output$hepato4 <- renderUI({
    selectInput("hepato4", "Categories", 
                choices = subcat$hepato, selected = "No")
  })
  
  output$spiders2 <- renderUI({
    selectInput("spiders2", "Categories", 
                choices = subcat$spiders, selected = "No")
  })
  output$spiders3a <- renderUI({
    selectInput("spiders3a", "Categories", 
                choices = subcat$spiders, selected = "No")
  })
  output$spiders3b <- renderUI({
    selectInput("spiders3b", "Categories", 
                choices = subcat$spiders, selected = "No")
  })
  output$spiders4 <- renderUI({
    selectInput("spiders4", "Categories", 
                choices = subcat$spiders, selected = "No")
  })
  
  output$edema2 <- renderUI({
    selectInput("edema2", "Categories", 
                choices = subcat$edema, selected = "No edema")
  })
  output$edema3a <- renderUI({
    selectInput("edema3a", "Categories", 
                choices = subcat$edema, selected = "No edema")
  })
  output$edema3b <- renderUI({
    selectInput("edema3b", "Categories", 
                choices = subcat$edema, selected = "No edema")
  })
  output$edema4 <- renderUI({
    selectInput("edema4", "Categories", 
                choices = subcat$edema, selected = "No edema")
  })
  
  
  ###################################################
  output$Rcode <- renderText({
    
    return(paste0("pbc[", input$rows, ", ", input$columns, "]"))
    
  })
  

  output$Routput <- renderTable({
    
     if (input$rows == "") {
       if (input$columns == ""){
         code1 <- paste0("pbc")
         eval(parse(text = code1))
       } else {
         code1 <- paste0("pbc[", ", c(", toString(input$columns), ")]")
         eval(parse(text = code1))
       }
     } else if (input$columns == "") {
       if (input$rows == "") {
         code1 <- paste0("pbc")
         eval(parse(text = code1))
       } else {
         code1 <- paste0("pbc[c(", toString(input$rows), "), ]")
         eval(parse(text = code1))
       }
     } else {
       code1 <- paste0("pbc[c(", toString(input$rows), "), c(", toString(input$columns), ")]")
       eval(parse(text = code1))
     }
    
  })
  
  
  
  output$Rcode2 <- renderText({
    
    if(input$factors2 == "status")  return(paste0("pbc[pbc$", input$factors2, " == ", dQuote(input$status2),", ]"))
    if(input$factors2 == "drug")  return(paste0("pbc[pbc$", input$factors2, " == ", dQuote(input$drug2),", ]"))
    if(input$factors2 == "sex")  return(paste0("pbc[pbc$", input$factors2, " == ", dQuote(input$sex2),", ]"))
    if(input$factors2 == "ascites")  return(paste0("pbc[pbc$", input$factors2, " == ", dQuote(input$ascites2),", ]"))
    if(input$factors2 == "hepato")  return(paste0("pbc[pbc$", input$factors2, " == ", dQuote(input$hepato2),", ]"))
    if(input$factors2 == "spiders")  return(paste0("pbc[pbc$", input$factors2, " == ", dQuote(input$spiders2),", ]"))
    if(input$factors2 == "edema")  return(paste0("pbc[pbc$", input$factors2, " == ", dQuote(input$edema2),", ]"))
    
  })
  
  output$Routput2 <- renderTable({
  
    if(input$factors2 == "status")  {
      code1 <- paste0("pbc[pbc$", toString(input$factors2), " == ", shQuote(input$status2),", ]")
      eval(parse(text = code1))
    } else if (input$factors2 == "drug")  {
      code1 <- paste0("pbc[pbc$", toString(input$factors2), " == ", shQuote(input$drug2),", ]")
      eval(parse(text = code2))
    } else if(input$factors2 == "sex")  {
      code1 <- paste0("pbc[pbc$", toString(input$factors2), " == ", shQuote(input$sex2),", ]")
      eval(parse(text = code1))
    } else if(input$factors2 == "ascites")  {
      code1 <- paste0("pbc[pbc$", toString(input$factors2), " == ", shQuote(input$ascites2),", ]")
      eval(parse(text = code1))
    } else if(input$factors2 == "hepato")  {
      code1 <- paste0("pbc[pbc$", toString(input$factors2), " == ", shQuote(input$hepato2),", ]")
      eval(parse(text = code1))
    }else if(input$factors2 == "spiders")  {
      code1 <- paste0("pbc[pbc$", toString(input$factors2), " == ", shQuote(input$spiders2),", ]")
      eval(parse(text = code1))
    } else if(input$factors2 == "edema")  {
      code1 <- paste0("pbc[pbc$", toString(input$factors2), " == ", shQuote(input$edema2),", ]")
      eval(parse(text = code1))
    }
      
  })
  
  
  
  category3a <- reactive({ 
    if (input$factors3a == "status") {
      categ3a <- input$status3a
    } else if (input$factors3a == "drug") {
      categ3a <- input$drug3a
    } else if (input$factors3a == "sex") {
      categ3a <- input$sex3a
    } else if (input$factors3a == "ascites") {
      categ3a <- input$ascites3a
    } else if (input$factors3a == "hepato") {
      categ3a <- input$hepato3a
    } else if (input$factors3a == "spiders") {
      categ3a <- input$spiders3a
    } else if (input$factors3a == "edema") {
      categ3a <- input$edema3a
    }
    categ3a
  })
  
  category3b <- reactive({ 
    if (input$factors3b == "status") {
      categ3b <- input$status3b
    } else if (input$factors3b == "drug") {
      categ3b <- input$drug3b
    } else if (input$factors3b == "sex") {
      categ3b <- input$sex3b
    } else if (input$factors3b == "ascites") {
      categ3b <- input$ascites3b
    } else if (input$factors3b == "hepato") {
      categ3b <- input$hepato3b
    } else if (input$factors3b == "spiders") {
      categ3b <- input$spiders3b
    } else if (input$factors3b == "edema") {
      categ3b <- input$edema3b
    }
    categ3b
  })
  
  output$Rcode3 <- renderText({
      categ3a <- category3a()
      categ3b <- category3b()
      
      select <- if (input$select == "and") {
        "&"
      } else {
        "|"
      }
      
      return(paste0("pbc[pbc$", input$factors3a, " == ", shQuote(categ3a), " ", select, " pbc$",  input$factors3b, " == ", 
                    shQuote(categ3b), ", ]"))

  })
  
  output$Routput3 <- renderTable({
    categ3a <- category3a()
    categ3b <- category3b()
    
    select <- if (input$select == "and") {
      "&"
    } else {
      "|"
    }
    
    code1 <- paste0("pbc[pbc$", input$factors3a, " == ", shQuote(categ3a), " ", select, " pbc$",  input$factors3b, " == ", 
                  shQuote(categ3b), ", ]")
    eval(parse(text = code1))
    
  })
  
  category4 <- reactive({ 
    if (input$factors4 == "status") {
      categ4 <- input$status4
    } else if (input$factors4 == "drug") {
      categ4 <- input$drug4
    } else if (input$factors4 == "sex") {
      categ4 <- input$sex4
    } else if (input$factors4 == "ascites") {
      categ4 <- input$ascites4
    } else if (input$factors4 == "hepato") {
      categ4 <- input$hepato4
    } else if (input$factors4 == "spiders") {
      categ4 <- input$spiders4
    } else if (input$factors4 == "edema") {
      categ4 <- input$edema4
    }
    categ4
  })
  
  output$Rcode4 <- renderText({
    categ4 <- category4()
    
    select2 <- if (input$select2 == "and") {
      "&"
    } else {
      "|"
    }
    return(paste0("pbc[pbc$", input$factors4, " == ", shQuote(categ4), " ", select2, " pbc$",  input$numerics, 
                  " ", input$smaller_lower, " ", input$numbers ,", ", input$columns2, "]"))
    
  })
  
  
  output$Routput4 <- renderTable({
    categ4 <- category4()
    
    select2 <- if (input$select2 == "and") {
      "&"
    } else {
      "|"
    }
    
    
    if (!is.null(input$columns2)) {
      code1 <- paste0("pbc[pbc$", input$factors4, " == ", shQuote(categ4), " ", select2, " pbc$",  input$numerics,
                      " ", input$smaller_lower, " ", input$numbers ,", ", input$columns2, ", ]")
      eval(parse(text = code1))  
      } else {
      code1 <- paste0("pbc[pbc$", input$factors4, " == ", shQuote(categ4), " ", select2, " pbc$",  input$numerics,
                                                      " ", input$smaller_lower, " ", input$numbers ,", ]")
      eval(parse(text = code1))
      
      
    }
      
    
  })
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

