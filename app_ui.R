# Ted Talks Final
# app_ui.R script for our Shiny App

# Load libraries --------------------------------------------------------------
library(plotly)


#######################################################
#Summary Page
intropanel <- tabPanel(
  "Project Overview",
  mainPanel(
    tags$h1("What Makes a Ted Talk Tick?"),
    tags$p("By: Megan Calverley, Dominik Gorecki, George Prentice, Sarah Trostle"),
    tags$p("Date: 6/5/2019"),
    
    tags$p(a("Our data", href = "https://www.kaggle.com/rounakbanik/ted-talks"),
      "is downloaded from the website Kaggle, but the data originally came from",
      a("Ted.com", href = "https://www.ted.com/talks"), "and looks at all the TEDTalks
      (which started in 1984) published on TED’s website as of", strong("September 21st, 2017."),
      "It contains data such as: the number of comments, a brief description, duration
      of the talk, where the event took place, the number of languages the talk is in,
      the film date, the main speaker’s name, the number of speakers, the publishing
      date, the ratings, the speaker occupation, the number views, and the name of the
      talk."),
    
    tags$p("Our group is interested in this domain because Ted Talks have become a
      cultural icon in our time. Ted Talks cover a large range of topics and some are
      more widely viewed than others. We are curious to explore datasets of Ted Talks
      to determine if it will reveal information about society or the times we live
      in. It is also possible that we will not find anything that we can extrapolate
      to be a reflection of our society but rather will simply learn more about what
      people find interesting or entertaining and what they do not."),
    
    tags$h2("Overview"),
    tags$p("From Ted.com’s launch, there have been,", strong("2,550"), "videos posted.", strong("Ken Robinson’s"),
      "video", em("Ken Robinson: Do schools kill creativity?"), "has the most views of any
      video at", strong("47,227,110"), "views. However,", strong("Hans Rosling"), "has recorded more videos than
      any other individual at 9 videos. The most commented video was", em("Richard
                                                                          Dawkins: Militant atheism"), "receiving", strong("6,404"), "comments.")
    ),
  tags$img(src = "./imgs/TED-Talks-1.jpg",width = 742.5,
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
# set choices for viewership variables
view_variables <- list(
  "Duration (minutes)" = "duration_minutes",
  "Languages Available" = "languages",
  "Number of Speakers" = "num_speaker"
)
# Make sidebar with widgets for chart for overall interaction
overall_sidebar_content <- sidebarPanel(
  selectInput(
    "viewership_variable",
    label = "Variable of Interest",
    choices = view_variables
  )
)

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
overall_main_content <- mainPanel(
  plotOutput("viewership_chart"),
  tags$p("The purpose of the chart above is to investigate whether there is a 
         relationship between certain variables and viewership of the talks. 
         The user can select from duration of the video, languages it is 
         available in, and the number of speakers.")
)

# Make main panel for year chart to be displayed
year_main_content <- mainPanel(
  plotlyOutput("metrics_by_year"),
  tags$p("The chart above allows the user to view four different metrics of 
         interaction, Views, Duration, Comments and Languages by year. The 
         general trend for this chart appears to show that the earlier years
         (roughly before 2012) had what could be broadly stated as more 
         interactions. The videos were recieving more views, being translated
         into more languages and recieving more comments. The range of these
         metrics by year became smaller with the exception of duration of 
         the videos in minutes which appears to have no discernable trend. This
         may lead one to the conclusion that Ted Talks are decreasing in
         popularity, however we propose an alternative hypothesis that fits the
         data. The data source for these metrics was Ted.com which likely began
         losing viewers to Youtube as that became a more popular viewing
         platform. ")
)

# Make first interactive tab
interactive_panel_one <- tabPanel(
  "Video Popularity",
  tags$h1("How do users interact with Ted Talk Videos?"),
  tags$hr(),
  # Chart one and widgets
  tags$h2("Viewership Interaction"),
  sidebarLayout(
    overall_sidebar_content,
    overall_main_content
  ),
  # Chart two and widgets
  tags$h2("Interaction by Year"),
  sidebarLayout(
    year_sidebar_content,
    year_main_content
  )
)

#######################################################
#Interactive Page 2
metrics_groups <- list(
  "Function Words" = "ppron ipron article prep auxverb adverb conj negate",
  "Grammar Types" = "verb adj compare interrog number quant"
)

# Create siderbar with wdiget for the chart output
lang_met_sidebar_content <- sidebarPanel(
  selectInput(
    "language_metrics",
    label = "Select the Language Metrics",
    choices = metrics_groups
  )
)

# Create main panel for Plot content
lang_met_main_content <- mainPanel(
  plotOutput("lang_metrics"),
  tags$p("This plot shows the language metrics for two different categories
    of metrics. The first category, Function Words, includes
    personal pronouns, impersonal pronouns, articles, prepositions,
    auxiliary verbs, common adverbs, conjunctions and negations. 
    The second category, Grammar Types, includes regular verbs,
    adjectives, comparatives, interrogatives, numbers and quantifiers.
    Using this data we can better understand the sentence structure in 
    successful Ted Talks. Additionally, this information can help us
    better understand how information is transferred from individual
    to another efficiently."),
  tags$p("When reviewing the plots we can see that talks contain
    significantly more prepositions and verbs. This is likely
    connected to the purpose of talks. Inspiration and calls
    to action are common in many talks therefore it makes sense
    that these language types are the most common.")
)

# Create second Interactive Tab
interactive_panel_two <- tabPanel(
  "Language Metrics",
  tags$h1("What words are used in Ted Talks?"),
  tags$hr(),
  sidebarLayout(
    lang_met_main_content,
    lang_met_sidebar_content
  )
)
 


#######################################################
#Interactive Page 3

# Set choices for style groups
style_groups <- list(
  "All" = "posemo negemo family friend female male insight cause discrep tenat certain differ see hear feel body health sexual ingest affiliation achieve power reward risk focuspast focuspresent focusfuture motion space time work leisure home money relig death swear netspeak assent nonflu filler",
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
  ggiraphOutput("word_style"),
  tags$p("The purpose of this chart is to provide an easy way to compare the
         style of language being used in the Ted Talks by category. The dataset
         we used provided a breakdown of the language style into various 
         categories for example, negative emotions would include the use of the 
         word sad. Hovering over the bubbles provides examples of words that fit
         into those categories"), 
  tags$p("First,examining the chart of", strong("all"), "the words we can see 
         that the category", strong ("focuspresent"), "is the dominant one. This 
         deals with the fact that many Ted Talks provide advice on how to 
         improve your own life and thus the concept of living in the present is 
         well represented. The word group", strong("Affect Words"), "is broken 
         down into positive and negative emotions, with positive making up a 
         larger portion. That is on brand with our cultural perception of Ted 
         Talks as inspiring videos. The", strong("Social"), "grouping provides 
         an interesting insight. Male References outnumber Female references by
         13,000. This could be because they are catering to a male audience, 
         the speakers themselves are primarily male or it reflects the male 
         dominated societies that we still live in. Another stand out 
         grouping was", strong("Personal Concerns"), "of which Work was
         by far the largest bubble. This needs to be investigated further, but
         a reasonable hypothesis for this is the competitive world we live in. 
         This type of data reflects what our culture is concerned with and a 
         reality of that is the intense pressure we are under to succeed in our
         work lives."),
  tags$p("The many options for word groupings provide multiple incites to be 
         gathered. The groups examined above had standout data although there
         are more hypotheses that could likely be generated from every grouping.
         ")
)

# Make 3rd interactive tab 
interactive_panel_three <- tabPanel(
  "Language Style",
  tags$h1("What kind of language is used in TED Talks?"),
  tags$hr(),
  sidebarLayout(
    style_sidebar_content,
    style_main_content
  )
)




#######################################################
#Summary Takeways Page
summarypanel <- tabPanel(
  "Summary",
  mainPanel(
    tags$h1("Summary of Data"),
    tags$p("Our purpose for analyzing data on ted talks was multi-faceted. Ted
          Talks have become a part of our lives both academically and 
          personally. Many of us have viewed Ted Talks in classrooms, for 
          assignments and also just for our personal pleasure. Therefore we 
          wanted to see if we could come to any conclusions about our culture or
          our generations lives based in addition to simply satisfying a 
          curiosity about what talks people find interesting."),
    
    tags$p("There were a few observations that we made that we found to be 
           significant. In our analyzation of the video popularity we concluded
           that the videos were appearing to decline in popularity but this was 
           likely misleading due to Youtube providing an alternate platform
           for viewership. Examination of Language Metrics revealed that verbs
           were the most popular form of word used by a long shot. Based on 
           the concept that Ted describes their videos as influential videos
           we proposed that people view these talks for inspiration. These ted
           talks are usually informative in nature and advise people how to 
           take the right actions to achieve their goals so this seemed 
           consistent with our expectations. Finally, we broke down the data by 
           language style, which led us to the conclusion that ......."))
)


#######################################################
ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    img(src = "./imgs/logo.png",width = 65.4, height = 30.8),
    intropanel,
    interactive_panel_one,
    interactive_panel_two,
    interactive_panel_three,
    summarypanel
  )
)
