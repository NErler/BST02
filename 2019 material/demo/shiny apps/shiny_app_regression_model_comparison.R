#################
# Load packages #
#################

# install.packages("shiny")
# install.packages("lattice")
# install.packages("JM")
library(lattice)
library(JM)
library(shiny)


#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("Regression model using the phc2.id data set"),
  
  # Sidebar with the covariates options
  sidebarLayout(
    
    sidebarPanel(
      selectInput("Model", "Model with the following covariates:", 
                  choices = c("drug, age, sex and spiders", "drug and spiders")),
      selectInput("compare", "Do you want to compare the two models:", 
                  choices = c("No", "Yes"))
      
                ),
    
    
    # Show plots, summary and patient data
    mainPanel(
      tabsetPanel(
        tabPanel("R code", verbatimTextOutput("Rcode"), verbatimTextOutput("RcodeComp")),
        tabPanel("Plot", plotOutput("Plot")), 
        tabPanel("Summary", verbatimTextOutput("summary"), verbatimTextOutput("comparison")))

      
    )
  )
)



server <- function(input, output) {
  
  output$Plot <- renderPlot({
    fm <- lm(serBilir ~ drug + age + sex + spiders, data = pbc2.id)
    fmSign <- lm(serBilir ~ drug + spiders, data = pbc2.id)
    
    newdata <- with(pbc2.id, data.frame(
      drug = gl(2,200,labels = c("placebo","D-penicil")),
      age = rep(seq(min(pbc2.id$age), max(pbc2.id$age), length = 50), times = 4),
      sex = gl(2,100,labels = c("male","female")),
      spiders = gl(2,50,labels = c("No","Yes"))
      
    ))
    
    newdataSign <- with(pbc2.id, data.frame(
      drug = gl(2,200,labels = c("placebo","D-penicil")),
      spiders = gl(2,50,labels = c("No","Yes"))
      
    ))
    
    newdata$pred <- predict(fm, newdata, interval = "confidence")[,1]
    newdata$lo <- predict(fm, newdata, interval = "confidence")[,2]
    newdata$up <- predict(fm, newdata, interval = "confidence")[,3]
    
    newdataSign$predSign <- predict(fmSign, newdataSign, interval = "confidence")[,1]
    newdataSign$loSign <- predict(fmSign, newdataSign, interval = "confidence")[,2]
    newdataSign$upSign <- predict(fmSign, newdataSign, interval = "confidence")[,3]
    
    
    plots.names <- c("withoutInteraction", "withInteraction")
    plots <- as.list(rep(NA, length(plots.names)))
    plots[["drug, age, sex and spiders"]] <- xyplot(pred + lo + up ~ age | drug * sex * spiders, type = "l", lty = c(1, 2, 2), 
                             cex = 1.8,  col = 1, lwd = 2, layout = c(4,2),
                             main = "Effect plot", xlab = "age", ylab = "serBilir", data = newdata)
    plots[["drug and spiders"]] <- xyplot(predSign + loSign + upSign ~ drug | spiders, type = "l", lty = c(1, 2, 2), cex = 1.8,  col = 1, lwd = 2, 
                                 main = "Effect plot", xlab = "age", ylab = "serBilir", data = newdataSign)
    
    plots[[input$Model]]
  })
  
  
  output$Rcode <- renderText({
    
    if (input$Model == "drug, age, sex and spiders") {
      return(paste0("## Run the model", "\n",
                    "fm <- lm(serBilir ~ drug + age + sex + spiders, data = pbc2.id)", "\n",
                    "", "\n",
                    "## Create a new data set for the effect plots", "\n",
                    "newdata <- with(pbc2.id, data.frame(", "\n",
                    "  drug = gl(2,200,labels = c('placebo','D-penicil')),", "\n",
                    "  age = rep(seq(min(pbc2.id$age), max(pbc2.id$age), length = 50), times = 4), ", "\n",
                    "  sex = gl(2,100,labels = c('male','female')),", "\n",
                    "  spiders = gl(2,50, labels = c('No','Yes')) ", "\n",
                    "))", "\n",
                    "", "\n",
                    "## Obtain predicted values with confidence interval", "\n",
                    "newdata$pred <- predict(fm, newdata, interval = 'confidence')[,1]", "\n",
                    "newdata$lo <- predict(fm, newdata, interval = 'confidence')[,2]", "\n",
                    "newdata$up <- predict(fm, newdata, interval = 'confidence')[,3]", "\n",
                    "", "\n",
                    "## Obtain effect plot", "\n",
                    "xyplot(pred + lo + up ~ age | drug * sex * spiders, type = 'l', lty = c(1, 2, 2), ", "\n",
                    "  cex = 1.8,  col = 1, lwd = 2, layout = c(4,2),", "\n",
                    "  main = 'Effect plot', xlab = 'age', ylab = 'serBilir', data = newdata)", "\n"
             )
       )
    } else if (input$Model == "drug and spiders") {
      return(paste0("## Run the model", "\n",
                    "fmSign <- lm(serBilir ~ drug + spiders, data = pbc2.id)", "\n",
                    "", "\n",
                    "## Create a new data set for the effect plots", "\n",
                    "newdataSign <- with(pbc2.id, data.frame(", "\n",
                    "  drug = gl(2,200,labels = c('placebo','D-penicil')),", "\n",
                    "  spiders = gl(2,50,labels = c('No','Yes'))", "\n",
                    "))", "\n",
                    "", "\n",
                    "## Obtain predicted values with confidence interval", "\n",
                    "newdataSign$predSign <- predict(fmSign, newdataSign, interval = 'confidence')[,1]", "\n",
                    "newdataSign$loSign <- predict(fmSign, newdataSign, interval = 'confidence')[,2]", "\n",
                    "newdataSign$upSign <- predict(fmSign, newdataSign, interval = 'confidence')[,3]", "\n",
                    "", "\n",
                    "## Obtain effect plot", "\n",
                    "xyplot(predSign + loSign + upSign ~ drug | spiders, type = 'l', lty = c(1, 2, 2), cex = 1.8,  col = 1, lwd = 2,", "\n",
                    "  main = 'Effect plot', xlab = 'age', ylab = 'serBilir', data = newdataSign)"
              )
      )
    }
  })
  
  output$RcodeComp <- renderText({
    
    if (input$compare == "No") {
      return(paste0(""))
    } else if (input$compare == "Yes") {
      return(paste0("## Compare the two models", "\n",
                    "anova(fm, fmSign)"))
    }
  })
  
  output$summary <- renderPrint({
    fm <- lm(serBilir ~ drug + age + sex + spiders, data = pbc2.id)
    fmSign <- lm(serBilir ~ drug + spiders, data = pbc2.id)
    
    if (input$Model == "drug, age, sex and spiders") {
      return(summary(fm))
    } else if (input$Model == "drug and spiders") {
      return(summary(fmSign))
    }
  })
  
  output$comparison <- renderPrint({
    if (input$compare == "No") {
      return()
    } else {
      fm <- lm(serBilir ~ drug + age + sex + spiders, data = pbc2.id)
      fmSign <- lm(serBilir ~ drug + spiders, data = pbc2.id)
      return(anova(fm, fmSign))
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
