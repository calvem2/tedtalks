# Ted Talks Final
# app_ui.R script for our Shiny App

# Load libraries --------------------------------------------------------------
library(plotly)


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

# Make first interactive tab
interactive_panel_one <- tabPanel(
  "Video Popularity",
  tags$h1("User Interaction with TED Videos"),
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

# Set choices for style groups
style_groups <- list(
  "Affect Words" = "posemo negemo",
  "Social Words" = "family friend female male",
  "Cognitive Processes" = "insight cause discrep tenat certain differ",
  "Perceptual Processes" = "see hear feel",
  "Biological Processes" = "body health sexual ingest",
  "Core Drives/Needs" = "affiliation achieve power reward risk",
  "Time Orientation" = "focuspast focuspresent focusfuture",
  "Relativity" = "motion space time",
  "Personal Concerns" = "work leisure home money relig death",
  "Informal Speech" = "swear netspeak assent nonflu filler"
)

# Make sidebar with widgets for chart
style_sidebar_content <- sidebarPanel(
  selectInput(
    "style_group",
    label = "Word Style Group",
    choices = style_groups
  )
)

# Make main panel chart to be displayed
style_main_content <- mainPanel(
  plotlyOutput("word_style")
)

# Make 3rd interactive tab 
interactive_panel_three <- tabPanel(
  "Language Style",
  tags$h1("Types of Language Used in TED Talks"),
  tags$hr(),
  sidebarLayout(
    style_sidebar_content,
    style_main_content
  )
)




#######################################################
#Summary Takeways Page






#######################################################
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "TED Talks",
    interactive_panel_one,
    interactive_panel_three
  )
)
