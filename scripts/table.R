# Summary Table Script File
library("dplyr")
library("kableExtra")
library("jsonlite")
library("anytime")

df <- read.csv("data/ted_main.csv", stringsAsFactors = FALSE)


create_table <- function(dataframe) {
  # Add markdown to insert a link to the Talk within the title column
  dataframe$title <- paste0("[", dataframe$title, "](", dataframe$url, ")")

  # Convert the film dates in the data frame
  dataframe$film_date <- anydate(dataframe$film_date)

  # Format the tags column
  

  sum_table <- dataframe %>% arrange(desc(views)) %>%
    mutate(index = row_number() -1) %>%
    filter(index < 10) %>% 
    select(film_date ,title, main_speaker, tags, languages, comments, 
                       views)
  
  return(sum_table)
}

data_table <- create_table(df)