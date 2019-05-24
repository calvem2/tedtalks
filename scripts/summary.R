library("dplyr")
library("jsonlite")
library("httr")

ted_data <- read.csv("data/ted_main.csv", stringsAsFactors = F)

# How many Ted Talks were there last year

ted_talk_count <- nrow(ted_data)

#Most views
most_views <- ted_data %>%
  select(name, views) %>%
  arrange(-views) %>%
  head(1) %>%
  pull(views)

#Most viewed video name

most_viewed_video <- ted_data %>%
  select(name, views) %>%
  arrange(-views) %>%
  head(1) %>%
  pull(name)

#speaker name of most viewed video

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

#video count
most_videos_count <- ted_data %>%
  mutate(count_it = 1) %>%
  group_by(main_speaker) %>%
  summarise(count_it = sum(count_it)) %>%
  arrange(-count_it) %>%
  head(1) %>%
  pull(count_it)

#Most commented video name

most_commented_video <- ted_data %>%
  arrange(-comments) %>%
  head(1) %>%
  pull(name)

#number of comments

most_comments <- ted_data %>%
  arrange(-comments) %>%
  head(1) %>%
  pull(comments)
