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
  titlePanel("title panel"),
  sidebarLayout(
    sidebarPanel( "sidebar panel",
                  selectInput('element_id', label = 'Select one option', choices = LETTERS[1:10])),
    mainPanel("main panel", 
              h1('The title of some text'), 
              p('And here is some content that is put into the first paragraph'))
  )
  
)

# Run the application 
shinyApp(ui = ui, server = server)

###################################################################################################################

#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("title panel"),
  sidebarLayout(
    sidebarPanel("sidebar panel",
                 selectInput("element_id", label = "Select one option", 
                             choices = c(1:10))),
    mainPanel("main panel", 
              h1("The title of some text"), 
              p(textOutput("dynamicText")))
  )
  
)

server <- function(input, output) {
  
  output$dynamicText <- renderText({
    paste("My number today is", input$element_id)
  })
  
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)


###################################################################################################################

#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("title panel"),
  sidebarLayout(
    sidebarPanel("sidebar panel",
                 selectInput('element_min', label = 'Select min option', choices = c(1:100)),
                 selectInput('element_max', label = 'Select max option', choices = c(100:500))),
    mainPanel("main panel", 
              h1('The title of some text'), 
              p('And here is the plot'),
              plotOutput("modelPlot"))
  )
  
)

server <- function(input, output) {
  
  output$modelPlot <- renderPlot({
    plot(sample(input$element_min : input$element_max))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
