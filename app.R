# app.R script for our Shiny App
library("shiny")
source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)

