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
  titlePanel("Testing simulated data set"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
      ,
      
      sliderInput("size",
                  "Number of observations:",
                  min = 1,
                  max = 300,
                  value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", plotOutput("distPlot"), plotOutput("boxPlot")), 
        tabPanel("Summary", verbatimTextOutput("summary")), 
        tabPanel("Table", tableOutput("table")))
      
    )
  )
)


server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- sample(1:100, input$size, replace = TRUE) 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
  
  output$boxPlot <- renderPlot({
    # generate size based on input$size from ui.R
    x <- sample(1:100, input$size, replace = TRUE)
    
    # draw the boxplot with the specified size
    boxplot(x)
  })
  
  output$table <- renderTable({
    # generate size based on input$size from ui.R
    x <- sample(1:100, input$size, replace = TRUE)
    
    # present the numbers 
    cbind(1:input$size, x)
  })
  
  output$summary <- renderText({
    "We show an example of simulations."
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

