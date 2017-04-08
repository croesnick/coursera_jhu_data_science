#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
data("Loblolly")

loblolly.age_max <- max(Loblolly$age)
loblolly.height_min <- min(Loblolly$height)
loblolly.height_max <- max(Loblolly$height)
loblolly.seed_levels <- c("All", levels(Loblolly$Seed))

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Growth of Loblolly Pine Trees"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("age_range",
                   "Age range:",
                   min = 0,
                   max = loblolly.age_max,
                   value = c(0, loblolly.age_max)),
       sliderInput("height_range",
                   "Height range:",
                   min = loblolly.height_min,
                   max = loblolly.height_max,
                   value = c(loblolly.height_min, loblolly.height_max)),
       selectInput("seeds",
                   "Seeds types:",
                   loblolly.seed_levels,
                   selected = "All",
                   multiple = TRUE
                   )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tags$h2("Data & Usage"),
      tags$p("This web app loads the Loblolly pine tree growth data set shipped with R.
             Each data point (tree age and height) belongs to one group of seeds it arose from.
             The plot below shows the change in height by age for seed.
             Move the sliders on the left and select/deselect seeds to alter what's shown in the plot."),
      tags$h2("Output"),
      textOutput("numGroupsSelected"),
      plotOutput("distPlot")
    )
  )
))
