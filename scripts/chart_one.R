# Chart one: Viewship vs. Duration
# Main Contributor: Sarah Trostle

# Load packages 
library("dplyr")
library("tidyr")
library("ggplot2")
library("plotly")
library("scales")


# Take in data
ted_talks_main <- read.csv("data/ted_main.csv", stringsAsFactors = TRUE)


# Purpose of visualization: The reason for using a scatter plot for this
# visualization is to determine if there is a relationship between the length
# of the video and the number of views it recieves. 

# Wrangle data

categories_of_interest <- ted_talks_main %>% 
  select(views, duration) %>% 
  mutate(duration_minutes = duration / 60) %>% 
  round(1)

# Plot data

 plot_viewership_duration <- function(ted_talks_main){
   ggplot(categories_of_interest,aes(x= duration_minutes,y= views)) + geom_point(alpha = 0.2)+
     geom_smooth(mapping = aes(x = duration_minutes, y = views))+
     xlab("Duration in Minutes") + 
     ylab("Number of Views")+
     labs(title = "Duration of Ted Talk vs. Viewership")
   }





