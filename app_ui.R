# Ted Talks Final
# app_ui.R script for our Shiny App

# Load libraries --------------------------------------------------------------



#######################################################
#Summary Page



#######################################################
#Interactive Page 1 -----------------------------------------------------------

# Set choices for continuous varibale to be plotted
cont_metrics <- list(
  "Views" = "views",
  "Duration (minutes)" = "duration_minutes",
  "Comments" = "comments",
  "Languages Available" = "languages"
)

# Make sidebar with widgets for chart for overall interaction
### ADD ME ###

# Make sidebar with widgets for chart by year
year_sidebar_content <- sidebarPanel(
  selectInput(
    "year_metric",
    label = "Metric",
    choices = cont_metrics
  ),
  tags$hr(),
  sliderInput(
    inputId = "year_range",
    label = "Year Range", min = 2006, max = 2017, value = c(2006, 2017),
    ticks = FALSE,
    sep = ""
  )
)

# Make main panel for overall chart to be displayed
### ADD ME ###

# Make main panel for year chart to be displayed
year_main_content <- mainPanel(
  plotlyOutput("metrics_by_year")
)

# Make tab one
panel_one <- tabPanel(
  "Video Popularity",
  tags$h1("Exploring User Interaction with TED Videos"),
  tags$hr(),
  # Chart one and widgets
  tags$h2("Overall Interaction"),
  ## ADD ME ##
  # Chart two and widgets
  tags$h2("Interaction by Year"),
  sidebarLayout(
    year_sidebar_content,
    year_main_content
  )
)

#######################################################
#Interactive Page 2





#######################################################
#Interactive Page 3





#######################################################
#Summary Takeways Page






#######################################################
ui <- navbarPage(
  "TED Talks",
  panel_one
)