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

data_1 = data.frame(Id = c(1,1,1,2,2,2,3,3,3,3,4,5,5), Score = c(sample(1:20, 13)))
data_2 = data.frame(Id = c(1,2,4,6), Country = c(rep("Netherlands", 1), rep("Belgium", 2), rep("Netherlands", 1)))
data_3 = data.frame(Id = c(7,8,9,10,10), DiastolicBloodPressure = c(sample(40:100, 5)))

data_1_diffIDnames = data.frame(ID = c(1,1,1,2,2,2,3,3,3,3,4,5,5), Score = c(sample(1:20, 13)))
data_2_diffIDnames = data.frame(id = c(1,2,4,6), Country = c(rep("Netherlands", 1), rep("Belgium", 2), rep("Netherlands", 1)))
data_3_diffIDnames = data.frame(ID_patient = c(7,8,9,10,10), DiastolicBloodPressure = c(sample(40:100, 5)))



#####################
# Run the shiny app #
#####################

ui <- fluidPage(
  
  # Application title
  titlePanel("Explore merge using a simulated data set"),
  
  # Text input 
  tabsetPanel(
    tabPanel("Basic merge examples",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 selectInput("data1", "Select the first data set", 
                             choices = c("data_1", "data_2", "data_3"),
                             selected = "data_1"),
                 
                 selectInput("data2", "Select the second data set", 
                             choices = c("data_1", "data_2", "data_3"),
                             selected = "data_2"),
                 
                 selectInput("allx", "Select whether you want to keep all the rows of the first data set",
                             choices = c("FALSE", "TRUE"),
                             selected = "FALSE"),
                 
                 selectInput("ally", "Select whether you want to keep all the rows of the second data set",
                             choices = c("FALSE", "TRUE"),
                             selected = "FALSE")
                 
                 
                 
                 
                 ),
               mainPanel(
                 
                 tabsetPanel(
                   tabPanel("Data sets", verbatimTextOutput("data")),
                   tabPanel("Rcode", verbatimTextOutput("Rcode")),
                   tabPanel("Output",  verbatimTextOutput("Routput")))
                 
                        ) 
                       )

    
          ),
    tabPanel("Merge examples - different column names",  fluid = TRUE, 
             sidebarLayout(
               sidebarPanel(
                 
                 selectInput("data1a", "Select the first data set", 
                             choices = c("data_1_diffIDnames", "data_2_diffIDnames", "data_3_diffIDnames"),
                             selected = "data_1_diffIDnames"),
                 
                 selectInput("data2a", "Select the second data set", 
                             choices = c("data_1_diffIDnames", "data_2_diffIDnames", "data_3_diffIDnames"),
                             selected = "data_2_diffIDnames"),
                 
                 selectInput("byx", "Select the column used for merging in the first data set",
                             choices = c("ID", "id", "ID_patient"),
                             selected = "ID"),
                 
                 selectInput("byy", "Select the column used for merging in the seconf data set",
                             choices = c("ID", "id", "ID_patient"),
                             selected = "id"),
                 selectInput("all", "Select whether you want to keep all the rows of the first and second data set",
                             choices = c("FALSE", "TRUE"),
                             selected = "FALSE")
                 
                 
                 
                 
                 
               ),
               mainPanel(
                 
                 tabsetPanel(
                   tabPanel("Data sets", verbatimTextOutput("data2")),
                   tabPanel("Rcode", verbatimTextOutput("Rcode2")),
                   tabPanel("Output",  verbatimTextOutput("Routput2")))
                 
               ) 
             )
             
             
    ) 
         )
)





server <- function(input, output) {
  
  output$Rcode <- renderText({
    return(paste0("merge(", input$data1, ", ", input$data2, ", by = 'Id', all.x = ", input$allx, ", all.y = ", input$ally, ")"))
  })
  
  dat_1 <- reactive({
    a <- input$data1
    return(a)
  })
  
  dat_2 <- reactive({
    a <- input$data2
    return(a)
  })
  
  output$Routput <- renderPrint({
    code1 <- paste0("merge(", dat_1(), ", ", dat_2(), ", by = 'Id', all.x = ", input$allx, ", all.y = ", input$ally, ")")
    eval(parse(text = code1))
  })
  
  
  output$Rcode2 <- renderText({
    return(paste0("merge(", input$data1a, ", ", input$data2a, ", by.x = '", toString(input$byx), "', by.y = '", toString(input$byy), "', all = ", input$all, ")"))
  })
  
  dat_1a <- reactive({
    a <- input$data1a
    return(a)
  })
  
  dat_2a <- reactive({
    a <- input$data2a
    return(a)
  })
  
  output$Routput2 <- renderPrint({
    code1 <- paste0("merge(", dat_1a(), ", ", dat_2a(), ", by.x = '", toString(input$byx), "', by.y = '", toString(input$byy), 
                    "', all = ", input$all, ")")
    eval(parse(text = code1))
  })
  
  output$data <- renderPrint({
    list(data_1 = data_1, data_2 = data_2, data_3 = data_3)
  })
  
  output$data2 <- renderPrint({
    list(data_1_diffIDnames = data_1_diffIDnames, data_2_diffIDnames = data_2_diffIDnames, data_3_diffIDnames = data_3_diffIDnames)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

