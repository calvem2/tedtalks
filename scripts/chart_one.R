# Chart one: Viewship vs. Duration
# Main Contributor: Sarah Trostle

# Load packages 
library("dplyr")
library("tidyr")
library("ggplot2")
library("plotly")
library("scales")


#take in data
ted_talks_main <- read.csv("data/ted_main.csv", stringsAsFactors = TRUE)


# Purpose of visualization: The reason for using a scatter plot for this
# visualization is to determine if there is a relationship between the length
# of the video and the number of views it recieves. 

viewership_duration <- function(ted_talks_main){
  ted_talks <- ted_talks_main %>% 
    select(views, duration)
}

categories_of_interest <- ted_talks_main %>% 
  select(views, duration) %>% 
  mutate(duration_minutes = duration / 60) %>% 
  round(1)

# Plot data


ggplot(data = categories_of_interest) +
  geom_point(mapping = aes(x = duration_minutes, y = views))+ 
  xlab("Duration in Minutes") + 
  ylab("Number of Views")+
  labs(title = "Viewership vs. Duration of talk")







