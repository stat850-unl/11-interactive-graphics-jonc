#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

boston_cocktails <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/boston_cocktails.csv')
head(boston_cocktails)

# Define UI for application that draws a histogram
# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)

ui <- fluidPage(
    titlePanel("New England Cocktails for Dummies"),

    # Create a new Row in the UI for select Inputs
    fluidRow(
        column(4,
               selectInput("Boo",
                           "Booze:",
                           c("All",
                             unique(as.character(boston_cocktails$category))))
        ),
        column(4,
               selectInput("Jui",
                           "Ingredient:",
                           c("All",
                             unique(as.character(boston_cocktails$ingredient))))
        ),
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
)


library(ggplot2)

function(input, output) {

    # Filter data based on selections
    output$table <- DT::renderDataTable(DT::datatable({
        data <- boston_cocktails
        if (input$category != "All") {
            data <- data[data$manufacturer == input$category,]
        }
        if (input$ingredient != "All") {
            data <- data[data$cyl == input$ingredient,]
        }
        data
    }))

}

# Define server logic required to draw a histogram
server <- function(input, output) {

    server = function(input, output) {
        output$table <- renderDataTable(boston_cocktails,
                                        options = list(
                                            pageLength = 5,
                                            initComplete = I("function(settings, json) {alert('Done.');}")
                                        )
        )
    }
}


# Run the application
shinyApp(ui = ui, server = server)
