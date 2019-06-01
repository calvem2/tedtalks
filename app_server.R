# Ted Talks Final
# app_server.R script for our Shiny App

# Load libraries --------------------------------------------------------------
library(dplyr)
library(scales)
library(ggplot2)
library(tidyr)

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

# Wrangle TED language data ---------------------------------------------------

# Get language style info from TED language data 
# Convert given column of percents of word count to number of words
perc_to_wc <- function(col) {
  round(col * ted_lang$WC / 100)
}

# convert word style columns from percentages and gather based on style group
ted_word_styles <- ted_lang %>%
  mutate(posemo = perc_to_wc(posemo), negemo = perc_to_wc(negemo),
         family = perc_to_wc(family), friend = perc_to_wc(friend),
         female = perc_to_wc(female), male = perc_to_wc(male),
         insight = perc_to_wc(insight), cause = perc_to_wc(cause),
         discrep = perc_to_wc(discrep), tentat = perc_to_wc(tentat),
         certain = perc_to_wc(certain), differ = perc_to_wc(differ),
         see = perc_to_wc(see), hear = perc_to_wc(hear),
         feel = perc_to_wc(feel), body = perc_to_wc(body),
         health = perc_to_wc(health), sexual = perc_to_wc(sexual),
         ingest = perc_to_wc(ingest), affiliation = perc_to_wc(affiliation),
         achieve = perc_to_wc(achieve), power = perc_to_wc(power),
         reward = perc_to_wc(reward), risk = perc_to_wc(risk),
         focuspast = perc_to_wc(focuspast),
         focuspresent = perc_to_wc(focuspresent),
         focusfuture = perc_to_wc(focusfuture), motion = perc_to_wc(motion),
         space = perc_to_wc(space), time = perc_to_wc(time),
         work = perc_to_wc(work), leisure = perc_to_wc(leisure),
         home = perc_to_wc(home), money = perc_to_wc(money),
         relig = perc_to_wc(relig), death = perc_to_wc(death),
         swear = perc_to_wc(swear), netspeak = perc_to_wc(netspeak),
         assent = perc_to_wc(assent), nonflu = perc_to_wc(nonflu),
         filler = perc_to_wc(filler)) %>%
  select(posemo, negemo, family, friend, female, male, insight, cause,
         discrep, tentat, certain, differ, see, hear, feel, body, health,
         sexual, ingest, affiliation, achieve, power, reward, risk, focuspast,
         focuspresent, focusfuture, motion, space, time, work, leisure,
         home, money, relig, death, swear, netspeak, assent, nonflu, filler) %>%
  gather(key = type, value = word_count)

# Create server ---------------------------------------------------------------
server <- function(input, output) {
  # INTERACTIVE PAGE ONE PLOT(S)
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
  
  # INTERACTIVE PAGE TWO PLOT(S)
  
  # INTERACTIVE PAGE THREE PLOT(S)
  output$word_style <- renderPlotly({
    current <- ted_word_styles %>%
      filter(is.element(type, unlist(strsplit(input$style_group, " ")))) %>%
      group_by(type) %>%
      summarise(total_words = sum(word_count, na.rm = TRUE))
    
    p <- ggplot(current) +
      geom_col(aes(x = type, y = total_words,
                   text = paste(total_words, "words"))) +
      scale_y_continuous(
        breaks = pretty(current$total_words),
        labels = comma
    ) +
      labs(title = "Frequency of Different Types of Words Within a Group") +
      xlab("Word Type") +
      ylab("Total Words") +
      theme(plot.title = element_text(hjust = 0.5))
    ggplotly(p, tooltip = "text")
    
  })
}
