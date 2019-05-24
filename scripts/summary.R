library("dplyr")
library("jsonlite")
library("httr")

ted_data <- read.csv("data/ted_main.csv", stringsAsFactors = F)

# How many Ted Talks were there last year

ted_talk_count <- nrow(ted_data)

#Most viewed video and information about that video.

most_views <- ted_data %>%
  summarise(most_viewed == max(views))

#

most_viewed_video <- ted_data %>%
  select(name, views) %>%
  arrange(-views) %>%
  head(1) %>%
  pull(views)

#speaker name

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



most_videos_count <- ted_data %>%
  mutate(count_it = 1) %>%
  group_by(main_speaker) %>%
  summarise(count_it = sum(count_it)) %>%
  arrange(-count_it) %>%
  head(1) %>%
  pull(count_it)

most_commented_video <- ted_data %>%
  arrange(-comments) %>%
  head(1) %>%
  pull(name)

most_commented_video <- ted_data %>%
  arrange(-comments) %>%
  head(1) %>%
  pull(comments)

rating_data <- ted_data$ratings

test <- fromJSON(rating_data)
