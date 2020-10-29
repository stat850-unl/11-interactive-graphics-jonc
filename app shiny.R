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
ui <- fluidPage(

    # Application title
    titlePanel("New England Cocktails For Dummies"),

    fluidPage(

        # Copy the chunk below to make a group of checkboxes
        radioButtons("radio", label = h3("Drink Category"),
                     choices = list("Vodka" = 1, "Tequila" = 2, "Cocktail Classics" = 3), 
                     selected = 1),
        
        hr(),
        fluidRow(column(3, verbatimTextOutput("value")))
        
    )
        
    radioButtons("radio", label = h3("Juice Type"),
                 choices = list("Pineapple" = 1, "Orange" = 2, "Apple" = 3), 
                 selected = 1),
    
    hr(),
    fluidRow(column(3, verbatimTextOutput("value")))
    
)  

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

# fluidPage(
#
#     # Copy the chunk below to make a group of checkboxes
#     checkboxGroupInput("checkGroup", label = h3("Checkbox group"),
#                        choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3),
#                        selected = 1),
#
#
#     hr(),
#     fluidRow(column(3, verbatimTextOutput("value")))
#
# drink names with correct category and type of juice

juice_search <- str_to_lower(input$juice) %>%
    # paste("\b", ., "\b", sep = "") %>%
    paste(collapse = "|")

boston_cocktails %>%
    filter(category %in% input$booze) %>%
    filter(str_detect(ingredient, juice_search)) %>%
    select(name)



# --------------------------------


# Take multiple juice options and look for any matches
juice_search <- str_to_lower(input$juice) %>%
    # paste("\b", ., "\b", sep = "") %>%
    paste(collapse = "|")







boston_cocktails %>%
    filter(category %in% input$booze) %>%
    filter(str_detect(ingredient, input$juice)) %>%
    select(name)
