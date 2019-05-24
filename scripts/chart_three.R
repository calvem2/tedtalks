# Ted Talks Midpoint Deliverable
# Chart 3: Frequency of ratings
# Main Contributor: Megan

# Load packages ---------------------------------------------------------------
library("dplyr")
library("tidyr")
library("ggplot2")
library("plotly")
library("scales")

# Prepare data to be plotted --------------------------------------------------

# Expand ratings column into mulitple columns
expand_rating_info <- function(ted_talks) {
  ted_talks <- ted_talks %>%
    select(ratings) %>%
    # separate individaul ratings for each ted talk
    separate(ratings, into = paste0("r", seq(14)), sep = "\\},") %>%
    # gather individual ratings into single column
    gather(key = rating_num, value = rating) %>%
    # remove extraneous characters from rating string
    mutate(rating = gsub("\\[*\\{", "", rating)) %>%
    mutate(rating = gsub("\'", "", rating)) %>%
    mutate(rating = gsub("[A-z]+:", "", rating)) %>%
    # separate each rating into columns for its id, name, and count
    separate(rating,
      into = c("rating_id", "rating_name", "rating_count"),
      sep = ","
    ) %>%
    mutate(
      rating_count = strtoi(rating_count),
      rating_id = strtoi(rating_id)
    )
}

# Gather summary information given expanded ted talk ratings data
summarize_ratings <- function(rating_info) {
  pos_ratings <- c(
    "Funny", "Courageous", "Beautiful", "Informative",
    "Inspiring", "Fascinating", "Ingenious", "Persuasive",
    "Jaw-dropping"
  )
  ratings_summary <- rating_info %>%
    group_by(rating_name) %>%
    summarise(num_ratings = sum(rating_count, na.rm = TRUE)) %>%
    # add column classifying rating as postive or negative
    mutate(
      rating_positive =
        is.element(trimws(as.character(rating_name)), pos_ratings)
    )
}

# Create plot of Ted Talk Ratings ---------------------------------------------

# Plot the frequency of each rating
ratings_plot <- function(ted_talks) {
  # Prep data to be plotted
  ted_ratings <- summarize_ratings(expand_rating_info(ted_talks))

  # Set and order legend lables
  ted_ratings$pos_lab <- cut(as.numeric(ted_ratings$rating_positive),
    breaks = 2,
    labels = c("Negative Rating", "Positive Rating")
  )
  ted_ratings$pos_lab <- factor(ted_ratings$pos_lab,
    levels = rev(levels(ted_ratings$pos_lab))
  )

  # Create plot
  plot <- ggplot(ted_ratings) +
    geom_col(aes(
      x = reorder(rating_name, num_ratings), y = num_ratings,
      text = paste(comma(num_ratings), "ratings"),
      fill = pos_lab
    )) +
    coord_flip() +
    scale_y_continuous(
      breaks = pretty(ted_ratings$num_ratings),
      labels = comma
    ) +
    scale_fill_manual(name = "", values = c("#00BFC4", "#FA766E")) +
    labs(title = "Ted Talk Ratings") +
    xlab("Rating") +
    ylab("Number of Ratings") +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme_bw() +
    theme(
      panel.grid = element_blank(), panel.border = element_blank(),
      axis.ticks.y = element_blank(),
      plot.title = element_text(hjust = 0.5)
    )
  plot <- ggplotly(plot, tooltip = "text")
  plot
}
