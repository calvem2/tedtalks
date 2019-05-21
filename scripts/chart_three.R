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

# Wrangle necessary data from given ted talks data set
expand_rating_info <- function(ted_talks) {
  ted_talks <- ted_talks %>%
    select(name, ratings) %>%
    # separate individaul ratings for each ted talk
    separate(ratings, into = paste0("r", seq(14)), sep = "\\},") %>%
    # gather individual ratings into single column
    gather(key = rating_num, value = rating, -name) %>%
    # remove extraneous characters from rating string
    mutate(rating = gsub("\\[*\\{", "", rating)) %>%
    mutate(rating = gsub("\'", "", rating)) %>%
    mutate(rating = gsub("[A-z]+:", "", rating)) %>%
    # separate each rating into columns for its id, name, and count
    separate(rating, into = c("rating_id", "rating_name", "rating_count"),
             sep = ",") %>%
    mutate(rating_count = strtoi(rating_count))
}

# Gather summary information given ted talk ratings data
summarize_ratings <- function(rating_info) {
  ratings_summary <- rating_info %>%
    filter(rating_count != 0) %>%
    group_by(rating_name) %>%
    summarise(num_videos = n(), num_ratings = sum(rating_count, na.rm = TRUE))
}

# Create plot of Ted Talk Ratings ---------------------------------------------

# Plot the frequency of each rating
ratings_plot <- function(ted_talks) {
  ted_ratings <- summarize_ratings(expand_rating_info(ted_talks))
  plot <- ggplot(ted_ratings) +
    geom_col(aes(x = reorder(rating_name, num_ratings), y = num_ratings,
             text = paste(comma(num_ratings), "ratings")),
             fill = "#E52B1D") +
    coord_flip() +
    scale_y_continuous(breaks = pretty(ted_ratings$num_ratings),
                       labels = comma) +
    labs(title = "Ted Talk Ratings") +
    xlab("Rating") +
    ylab("Number of Ratings") +
    theme(plot.title = element_text(hjust = 0.5)) +
    theme_bw() +
    theme(panel.grid = element_blank(), panel.border = element_blank(),
          axis.ticks.y = element_blank(),
          plot.title = element_text(hjust = 0.5))
  plot <- ggplotly(plot, tooltip = "text")
  plot
}