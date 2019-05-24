library("dplyr")
library("jsonlite")
library("httr")

ted_data <- read.csv("data/ted_main.csv", stringsAsFactors = F)

# How many Ted Talks have their been?
ted_talk_count <- nrow(ted_data)

#What is the highest count of views?
most_views <- ted_data %>%
  select(name, views) %>%
  arrange(-views) %>%
  head(1) %>%
  pull(views)

#What is the name of the video with the most views?

most_viewed_video <- ted_data %>%
  select(name, views) %>%
  arrange(-views) %>%
  head(1) %>%
  pull(name)

#What is the name of the speaker with the most views?

most_viewed_speaker <- ted_data %>%
  select(name, main_speaker, views) %>%
  group_by(main_speaker) %>%
  arrange(-views) %>%
  head(1) %>%
  pull(main_speaker)

#Which speaker has the most videos?

most_videos_speaker <- ted_data %>%
  mutate(count_it = 1) %>%
  group_by(main_speaker) %>%
  summarise(count_it = sum(count_it)) %>%
  arrange(-count_it) %>%
  head(1) %>%
  pull(main_speaker)

#How many videos did the speaker with the most videos have?
most_videos_count <- ted_data %>%
  mutate(count_it = 1) %>%
  group_by(main_speaker) %>%
  summarise(count_it = sum(count_it)) %>%
  arrange(-count_it) %>%
  head(1) %>%
  pull(count_it)

#What was the name of the video that had the most comments?

most_commented_video <- ted_data %>%
  arrange(-comments) %>%
  head(1) %>%
  pull(name)

#What was the highest count of comments on one video?

most_comments <- ted_data %>%
  arrange(-comments) %>%
  head(1) %>%
  pull(comments)

get_summary_info <- function(ted_data) {
  ret <- list()
  ret$length <- length(dataset)
  return (ret)
} 
