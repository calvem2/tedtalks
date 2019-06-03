# Ted Talks Final
# app_ui.R script for our Shiny App

# Load libraries --------------------------------------------------------------
library(plotly)


#######################################################
#Summary Page
intropanel <- tabPanel(
  "Project Overview",
  mainPanel(
    h1("What makes a Ted Talk Tick?"),
    p("By: Megan Calverley, Dominik Gorecki, George Prentice, Sarah Trostle"),
    p("Date: 6/5/2019"),
    
    p(a("Our data", href = "https://www.kaggle.com/rounakbanik/ted-talks"),
      "is downloaded from the website Kaggle, but the data originally came from",
      a("Ted.com", href = "https://www.ted.com/talks"),"and looks at all the TEDTalks
      (which started in 1984) published on TED’s website as of", strong("September 21st, 2017."),
      "It contains data such as: the number of comments, a brief description, duration
      of the talk, where the event took place, the number of languages the talk is in,
      the film date, the main speaker’s name, the number of speakers, the publishing
      date, the ratings, the speaker occupation, the number views, and the name of the
      talk."),
    
    p("Our group is interested in this domain because Ted Talks have become a
      cultural icon in our time. Ted Talks cover a large range of topics and some are
      more widely viewed than others. We are curious to explore datasets of Ted Talks
      to determine if it will reveal information about society or the times we live
      in. It is also possible that we will not find anything that we can extrapolate
      to be a reflection of our society but rather will simply learn more about what
      people find interesting or entertaining and what they do not."),
    
    h2("Overview"),
    p("From Ted.com’s launch, there have been,", strong("2,550"), "videos posted.", strong("Ken Robinson’s"),
      "video", em("Ken Robinson: Do schools kill creativity?"), "has the most views of any
      video at", strong("47,227,110"), "views. However,", strong("Hans Rosling"), "has recorded more videos than
      any other individual at 9 videos. The most commented video was", em("Richard
                                                                          Dawkins: Militant atheism"), "receiving", strong("6,404"), "comments.")
    ),
  img(src = "./imgs/TED-Talks-1.jpg",width = 742.5,
      height = 360)
  
)

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
    img(src = "./imgs/logo.png",width = 65.4, height = 30.8),
    intropanel,
    interactive_panel_one,
    interactive_panel_three
  )
)
