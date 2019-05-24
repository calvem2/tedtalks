# Ted Talks Midpoint Deliverable
# Chart 2: Views by Year
# Main Contributor: Megan

# Load packages ---------------------------------------------------------------
library("dplyr")
library("ggplot2")
library("tidyselect")

# Prepare data to be plotted --------------------------------------------------

# Changes film dates in ted data frame according to specified format string
# Assumes dates in columns is a UNIX timestamp
format_date <- function(ted_talks, format_string) {
  ted_talks <- ted_talks %>%
    mutate(
      published_date = as.POSIXct(as.numeric(as.character(published_date)),
        origin = "1970-01-01", tz = "GMT"
      )
    ) %>%
    mutate(published_date = format(published_date, format = format_string))
}

# Create plot of Ted Talk Views by Year ---------------------------------------

# Returns plot of the distribution of views for each year included in the data
views_by_year_plot <- function(ted_talks) {
  ted_talks <- format_date(ted_talks, "%Y")
  plot <- ggplot(ted_talks) +
    geom_boxplot(mapping = aes(x = published_date, y = views)) +
    scale_y_continuous(
      breaks = pretty(ted_talks$views, n = 10),
      labels = comma
    ) +
    labs(title = "Views by Year") +
    xlab("Year Published") +
    ylab("Number of Views") +
    theme(plot.title = element_text(hjust = 0.5)) #+
  ggplotly(plot)
}
