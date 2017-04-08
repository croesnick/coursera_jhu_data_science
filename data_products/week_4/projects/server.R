#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(datasets)
data("Loblolly")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$numGroupsSelected <- reactive({
    if ("All" %in% input$seeds & length(input$seeds) == 1) {
      "The plot shows the height increase for _all_ seeds."
    }
    else {
      num_groups <- length(input$seeds[input$seeds != "All"])
      paste("The plot shows the height increase for ", num_groups, " seed(s).")
    }
  })
  
  output$distPlot <- renderPlot({
    selected_seeds <-
      if ("All" %in% input$seeds & length(input$seeds) == 1) {
        Loblolly$Seed
      }
      else {
        input$seeds[input$seeds != "All"]
      }
    
    loblolly.filtered <-
      Loblolly %>%
      filter(age >= input$age_range[1] & age <= input$age_range[2]) %>%
      filter(height >= input$height_range[1] & height <= input$height_range[2]) %>%
      filter(Seed %in% selected_seeds)
    
    ggplot(data = loblolly.filtered,
           aes(x = age,
               y = height,
               group = Seed,
               colour = Seed)) +
      geom_line() +
      geom_point()
  })
})
