#################
# Load packages #
#################

# install.packages("shiny")
# install.packages("lattice")
# install.packages("JM")
# install.packages("effects")
library(lattice)
library(JM)
library(effects)
library(shiny)

################################################
# Give the data and information that is needed #
################################################

# specify the data
data <- pbc2.id
# names of the covariates
covNames <- c("years", "status", "drug", "age", "sex", "ascites", "hepatomegaly", "spiders", "edema", "serBilir", "serChol", "albumin", 
              "alkaline", "SGOT", "platelets", "prothrombin", "histologic")
# names of the outcomes
outNames <- c("serBilir", "serChol", "prothrombin", "hepatomegaly", "spiders", "ascites")
# indicate which outcomes are continuous
indCont <- sapply(outNames, function(x) is.numeric(data[[x]])) 


#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("Perform univariable regression analysis using the Pbc2.id data set"),
  
  # Sidebar with a slider input for the covariates
  sidebarLayout(
    
    sidebarPanel(
      
      p('You can run univariable regression analysis by selecting the outcome and the covariate'),

      selectInput("outcomes", "Which outcome to include in the univariable model:", 
                  choices = outNames),
            
      selectInput("covariates", "Which covariate to include in the univiariable model:", 
                  choices = covNames),
      
      p('As results we present effect plots (using the effect package in R) and the summary of each regression')
    ),
    
    
    # Show a plot and the summary
    mainPanel(
      tabsetPanel(
        tabPanel("R code", verbatimTextOutput("Rcode")),
        tabPanel("Effect plot", plotOutput("Plot")), 
        tabPanel("Summary", verbatimTextOutput("summary")))
      
    )
  )
)



server <- function(input, output) {
  
  output$Plot <- renderPlot({
     if (any(input$outcomes == outNames[indCont])) {
      form <- as.formula(paste(input$outcomes ," ~", input$covariates))
      fm <- lm(form, data = data)
      plot(effect(input$covariates, fm))
    } else {
      form <- as.formula(paste(input$outcomes ," ~", input$covariates))
      fm <- glm(form, data = data, family = binomial)
      plot(effect(input$covariates, fm))
    }
  })
  
  
  output$summary <- renderPrint({
    if (any(input$outcomes == outNames[indCont])) {
      form <- as.formula(paste(input$outcomes ," ~", input$covariates))
      fm <- lm(form, data = data)
    } else {
      form <- as.formula(paste(input$outcomes ," ~", input$covariates))
      fm <- glm(form, data = data, family = binomial)
    }
    return(summary(fm))
    
  })
  
  
  output$Rcode <- renderText({
    
    if (any(input$outcomes == outNames[indCont])) {
      fm <- paste0("lm(", input$outcomes ," ~ ", input$covariates, ", data = data)")
    } else {
      fm <- paste0("glm(", input$outcomes ," ~ ", input$covariates, ", data = data, family = binomial)")
    }
    
    return(paste0("## Run the model", "\n",
                  "summary(", fm, ")\n",
                  "\n",
                  "## Obtain effect plot", "\n",
                 "plot(effect(", input$covariates, ", fm))"))
    
  })
  
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

