#################
# Load packages #
#################

#install.packages("shiny")
library(shiny)


#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("Model from simulated data"),
  
  # Sidebar for the BMI values
  sidebarLayout(
    
    sidebarPanel(
      sliderInput("BMI",
                  "BMI:",
                  min = 20,
                  max = 33,
                  value = 20, animate=TRUE)
      
      
      ,
      
      radioButtons("gender", "Gender:",
                   c("Male" = "male",
                     "Female" = "female")
      )),
    
    
    # Show plots, summary and patient data
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("dataPlot"), plotOutput("modelPlot")), 
        tabPanel("Summary", verbatimTextOutput("summary")), 
        tabPanel("Patient data", tableOutput("table")))
      
    )
  )
)



server <- function(input, output) {
  
  
  output$dataPlot <- renderPlot({
    
    set.seed(2015+5)
    patient <- c(1:200)
    height <- rnorm(200, 1.70, 0.1)
    weight <- height + rnorm(200, 60, 10)
    age <- rnorm(200, 60, 10)
    sex <- sample(1:2, 200, replace = TRUE)
    sex <- factor(sex, levels = 1:2, labels = c("male", "female"))
    
    dat <- data.frame(patient, height, weight, sex, age)
    dat$BMI <- dat$weight/(dat$height^2)
    
    dat_subset <- reactive({
      a <- subset(dat, sex == input$gender)
      return(a)
    })
    
    return(xyplot(weight ~ age, type = "smooth", data = dat_subset(), ylim = c(30, 90), xlim = c(30, 90),
                  main = list(label = "Average evolution of weight", cex = 1.5), 
                  col = 2, lwd = 2, cex.lab = 2, ylab = list(label = "Weight", cex = 1.5), 
                  xlab = list(label = "Age", cex = 1.5)))
  })
  
  
  output$modelPlot <- renderPlot({
    
    set.seed(2015+5)
    patient <- c(1:200)
    height <- rnorm(200, 1.70, 0.1)
    weight <- height + rnorm(200, 60, 10)
    age <- rnorm(200, 60, 10)
    sex <- sample(1:2, 200, replace = TRUE)
    sex <- factor(sex, levels = 1:2, labels = c("male", "female"))
    
    dat <- data.frame(patient, height, weight, sex, age)
    dat$BMI <- dat$weight/(dat$height^2)
    
    fm1 <- lm(weight ~ sex + BMI + age, data = dat)
    
    
    newdata <- with(dat, data.frame(
      sex = rep(input$gender, each = 20),
      age = rep(seq(min(dat$age), max(dat$age), length = 20)),
      BMI = rep(input$BMI, 20)
    ))
    
    newdata$pred <- predict(fm1, newdata, interval = "confidence")[,1]
    newdata$lo <- predict(fm1, newdata, interval = "confidence")[,2]
    newdata$up <- predict(fm1, newdata, interval = "confidence")[,3]
    
    return(xyplot(pred + lo + up ~ age, type = "l", lty = c(1, 2, 2), cex = 1.8, ylim = c(50, 88), xlim = c(30, 90),
                  col = 1, lwd = 2, main = list(label = "Effect plot", cex = 1.5), xlab = list("Age", cex = 1.5), 
                  ylab = list(label = "Weight", cex = 1.5), data = newdata, cex.lab = 2))
    
    
  })
  
  
  
  output$table <- renderTable({
    set.seed(2015+5)
    patient <- c(1:200)
    height <- rnorm(200, 1.70, 0.1)
    weight <- height + rnorm(200, 60, 10)
    age <- rnorm(200, 60, 10)
    sex <- sample(1:2, 200, replace = TRUE)
    sex <- factor(sex, levels = 1:2, labels = c("male", "female"))
    
    dat <- data.frame(patient, height, weight, sex, age)
    dat$BMI <- dat$weight/(dat$height^2)
    
    fm1 <- lm(weight ~ sex + BMI + age, data = dat)
    
    newdata <- with(dat, data.frame(
      sex = rep(input$gender, each = 20),
      age = rep(seq(min(dat$age), max(dat$age), length = 20)),
      BMI = rep(input$BMI, 20)
    ))
    
    
    newdata$pred <- predict(fm1, newdata, interval = "confidence")[,1]
    newdata$lo <- predict(fm1, newdata, interval = "confidence")[,2]
    newdata$up <- predict(fm1, newdata, interval = "confidence")[,3]
    
    return(newdata)
    
  })
  
  output$summary <- renderPrint({
    set.seed(2015+5)
    patient <- c(1:200)
    height <- rnorm(200, 1.70, 0.1)
    weight <- height + rnorm(200, 60, 10)
    age <- rnorm(200, 60, 10)
    sex <- sample(1:2, 200, replace = TRUE)
    sex <- factor(sex, levels = 1:2, labels = c("male", "female"))
    
    dat <- data.frame(patient, height, weight, sex, age)
    dat$BMI <- dat$weight/(dat$height^2)
    
    fm1 <- lm(weight ~ sex + BMI + age, data = dat)
    
    return(summary(fm1))
    
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

