# Ted Talks Final
# app_server.R script for our Shiny App

# Load libraries --------------------------------------------------------------
library(dplyr)
library(scales)
library(ggplot2)
library(tidyr)
library(packcircles)
library(viridis)
library(ggiraph)

# Load data -------------------------------------------------------------------
ted_main <- read.csv("data/ted_main.csv", stringsAsFactors = FALSE)
ted_lang <-
  read.csv(
    "data/TED_Talks_by_ID_plus-transcripts-and-LIWC-and-MFT-plus-views.csv",
    stringsAsFactors = FALSE
  )

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

# convert word style columns to word count and gather based on style group
ted_word_styles <- ted_lang %>%
  mutate(
    posemo = perc_to_wc(posemo), negemo = perc_to_wc(negemo),
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
    filler = perc_to_wc(filler)
  ) %>%
  select(
    posemo, negemo, family, friend, female, male, insight, cause,
    discrep, tentat, certain, differ, see, hear, feel, body, health,
    sexual, ingest, affiliation, achieve, power, reward, risk, focuspast,
    focuspresent, focusfuture, motion, space, time, work, leisure,
    home, money, relig, death, swear, netspeak, assent, nonflu, filler
  ) %>%
  gather(key = type, value = word_count) %>%
  group_by(type) %>%
  summarise(word_count = sum(word_count, na.rm = TRUE))

# Add example words and alterante names to data
alt_names <- c(
  "Achievement", "Affiliation", "Assent", "Body", "Causation",
  "Certainty", "Death", "Differentiation", "Discrepancy", "Family",
  "Feel", "Female References", "Fillers", "Future Focus",
  "Past Focus", "Present Focus", "Friends", "Health", "Hear",
  "Home", "Ingestion", "Insight", "Leisure", "Male References",
  "Money", "Motion", "Negative Emotions", "Netspeak",
  "Nonfluencies", "Positive Emotions", "Power", "Religion",
  "Reward", "Risk", "See", "Sexual", "Space", "Swear Words",
  "Tentative", "Time", "Work"
)
examples <- c(
  "win, success, better", "ally, friend, social", "agree, OK, yes",
  "cheek, hands, spit", "because, effect", "always, never",
  "bury, coffin, kill", "hasn&#39t, but, else", "should, would",
  "daughter, dad, aunt", "feels, touch", "girl, her, mom",
  "Imean, youknow", "may, will, soon", "ago, did, talked",
  "today, is, now", "buddy, neighbor", "clinic, flu, pill",
  "listen, hearing", "kitchen, landlord", "dish, eat, pizza",
  "think, know", "cook, chat, movie", "boy, his, dad",
  "audit, cash, owe", "arrive, car, go", "hurt, ugly, nasty",
  "btw, lol, thx", "er, hm, umm", "love, nice, sweet",
  "superior, bully", "altar, church", "take, prize, benefit",
  "danger, doubt", "view, saw, seen", "love, incest",
  "down, in, thin", "fuck, damn, shit", "maybe, perhaps",
  "end, until, season", "jobs, majors, xerox"
)

ted_word_styles$alt_name <- alt_names
ted_word_styles$example <- examples

# Convert Word Metrics from percent to WC
ted_word_metrics <- ted_lang %>%
  mutate(
    ppron = perc_to_wc(ppron), ipron = perc_to_wc(ipron),
    article = perc_to_wc(article), prep = perc_to_wc(prep),
    auxverb = perc_to_wc(auxverb), adverb = perc_to_wc(adverb),
    conj = perc_to_wc(conj), negate = perc_to_wc(negate),
    verb = perc_to_wc(verb), adj = perc_to_wc(adj),
    compare = perc_to_wc(compare), interrog = perc_to_wc(interrog),
    number = perc_to_wc(number), quant = perc_to_wc(quant)
  ) %>%
  select(
    ppron, ipron, article, prep, auxverb, adverb,
    conj, negate, verb, adj, compare, interrog, number, quant
  ) %>%
  gather(key = type_met, value = met_word_count)


# Create server ---------------------------------------------------------------
server <- function(input, output) {
  # INTERACTIVE PAGE ONE PLOT(S)
  colnames(ted_main)[colnames(ted_main) == "duration_minutes"] <- "Duration"
  colnames(ted_main)[colnames(ted_main) == "languages"] <- "Languages"
  colnames(ted_main)[colnames(ted_main) == "num_speaker"] <- "NumberOfSpeakers"
  colnames(ted_main)[colnames(ted_main) == "comments"] <- "Comments"
  colnames(ted_main)[colnames(ted_main) == "views"] <- "Views"


  output$viewership_chart <- renderPlotly({
    v <- ggplot(ted_main) +
      geom_point(aes_string(
        x = input$viewership_variable, y = "Views",
        text = "paste(\"Total Views: \", Views, \"\n\",
        paste0(input$viewership_variable, \":\"),
        round(ted_main[, input$viewership_variable], 2))"
      ), alpha = 0.2) +
      labs(title = paste(input$viewership_variable, "vs. Viewership")) +
      xlab(input$viewership_variable) +
      ylab("Number of Views")
    ggplotly(v, tooltip = "text")
  })
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
      labs(title = paste(input$year_metric, "by Year")) +
      xlab("Year Published") +
      ylab(input$year_metric) +
      theme(plot.title = element_text(hjust = 0.5))
  })

  # INTERACTIVE PAGE TWO PLOT(S)
  output$lang_metrics <- renderPlotly({
    current_met <- ted_word_metrics %>%
      filter(is.element(
        type_met,
        unlist(strsplit(input$language_metrics, " "))
      )) %>%
      group_by(type_met) %>%
      summarise(total_words = sum(met_word_count, na.rm = TRUE))


    plot <- ggplot(current_met) +
      geom_col(aes(
        x = type_met, y = total_words,
        text = paste0("Total Words: ", current_met$total_words)
      )) +
      labs(title = "Frequency of Different Language Metrics") +
      xlab("Metric Type") +
      ylab("Total Words") +
      scale_y_continuous(
        breaks = pretty(current_met$total_words),
        labels = comma
      )
    ggplotly(plot, tooltip = "text")
  })

  # INTERACTIVE PAGE THREE PLOT(S)
  output$word_style <- renderggiraph({
    # Prep data
    styles <- unlist(strsplit(input$style_group, "\\s+"))
    current <- ted_word_styles %>%
      filter(is.element(type, styles))
    current$text <- paste(
      current$alt_name,
      "\nExamples:", current$example,
      "\nTotal Words:", current$word_count
    )
    packing <- circleProgressiveLayout(current$word_count,
      sizetype = "area"
    )
    current <- cbind(current, packing)
    current.gg <- circleLayoutVertices(packing, npoints = 50)

    # Set text size for plot
    max_bubbles <- nrow(ted_word_styles)
    text_size <- 3
    if (length(styles) != max_bubbles) {
      text_size <- 5
    }

    # Make plot
    p <- ggplot() +
      # Make the bubbles
      geom_polygon_interactive(
        data = current.gg, aes(x, y,
          group = id, fill = id,
          tooltip = current$text[id], data_id = id
        ),
        colour = "black", alpha = 0.6
      ) +
      scale_fill_viridis() +
      # Add text in the center of each bubble + control its size
      geom_text(
        data = current, aes(x, y, label = alt_name),
        size = text_size, color = "black"
      ) +
      # General theme:
      theme_void() +
      theme(legend.position = "none", plot.margin = unit(c(0, 0, 0, 0), "cm")) +
      coord_equal()
    ggiraph(ggobj = p, width_svg = 7, height_svg = 7)
  })
}
