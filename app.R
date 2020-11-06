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
    titlePanel("Basic DataTable"),
    
    # Create a new Row in the UI for selectInputs
    fluidRow(
        column(4,
               selectInput("man",
                           "Manufacturer:",
                           c("All",
                             unique(as.character(mpg$manufacturer))))
        ),
        column(4,
               selectInput("trans",
                           "Transmission:",
                           c("All",
                             unique(as.character(mpg$trans))))
        ),
        column(4,
               selectInput("cyl",
                           "Cylinders:",
                           c("All",
                             unique(as.character(mpg$cyl))))
        )
    ),
    # Create a new row for the table.
    DT::dataTableOutput("table")
)
