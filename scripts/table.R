# R Script for the Table
# Main Contributor: George Prentice

library("dplyr")
library("kableExtra")
library("jsonlite")
library("anytime")
library("tidyr")



create_table <- function(dataframe) {
  # Add markdown to insert a link to the Talk within the title column
  dataframe$title <- paste0("[", dataframe$title, "](", dataframe$url, ")")
  
  # Convert the film dates in the data frame
  dataframe$film_date <- anydate(dataframe$film_date)
  
  
  sum_table <- dataframe %>% arrange(desc(views)) %>%
    mutate(index = row_number() -1) %>%
    filter(index < 10) %>% 
    mutate(tags = gsub("\\[|\'|\\]", "", tags) )%>%
    select(film_date ,title, main_speaker, tags, languages, comments, 
           views)
  
  return(sum_table)
}

data_table <- create_table(ted_main)
