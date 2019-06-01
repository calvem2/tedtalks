# Ted Talks Final
# app_server.R script for our Shiny App

# Load libraries --------------------------------------------------------------
library(dplyr)
library(scales)

# Load data -------------------------------------------------------------------
ted_main <- read.csv("data/ted_main.csv", stringsAsFactors = FALSE)
ted_lang <- read.csv("data/TED_Talks_by_ID_plus-transcripts-and-LIWC-and-MFT-plus-views.csv",
                     stringsAsFactors = FALSE)
# Wrangle TED main data -------------------------------------------------------

# Format published date as a year, calculate duration in mintues
ted_main <- ted_main %>%
  mutate(
    published_date = as.POSIXct(as.numeric(as.character(published_date)),
      origin = "1970-01-01", tz = "GMT"
    )
  ) %>%
  mutate(
    published_year = format(published_date, format = "%Y"),
    duration_minutes = duration / 60
  )


# Create server ---------------------------------------------------------------
server <- function(input, output) {
  # INTERACTIVE PAGE ONE PLOTS
  
  # Render plotly chart of distribution of views, comments, etc., by year
  output$metrics_by_year <- renderPlotly({
    p <- ggplot(ted_main) +
      geom_boxplot(aes_string(x = "published_year", y = input$year_metric)) +
      scale_x_discrete(
        limits = as.character(seq(input$year_range[1], input$year_range[2]))
      ) +
      scale_y_continuous(
        breaks = pretty(ted_main[, input$year_metric]),
        labels = comma
      ) +
      labs(title = paste(input$year_metric, "by year")) +
      xlab("Year Published") +
      ylab(input$year_metric) +
      theme(plot.title = element_text(hjust = 0.5))
  })
  
  # INTERACTIVE PAGE TWO PLOTS
  
  # INTERACTIVE PAGE THREE PLOTS
}
