library(shiny)

library(shinydashboard)
library(tmap)
library(rgdal)
admin <- readOGR("export","Export_Output")
df <- admin@data
name <- names(df)
use_name <- name[c(113:120,124,129,131)]
dashboardPage(


  dashboardHeader(title="maps"),
  dashboardSidebar(
    
    selectInput("x","names",use_name),
    selectInput("x2","Factors",c("Factor_1","Factor_2","Factor_3","Factor_4")),
    selectInput("x3","State",c("New York","Los Angeles"))

    
  ),
  dashboardBody(
    column(4,plotOutput("plot1")),
    column(4,plotOutput("plot2")),
    column(4,plotOutput("plot3"))
  )
  
)  
