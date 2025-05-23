library(tidyverse)

url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vR6jVuO3F3DNwX1WApTvCfYqfjehcNKHmuDqupk2_0vJe0lnf81dmUlsXZGkZKmaCeallS5Dqch05ks/pub?gid=1338968646&single=true&output=csv"
apple_data <- read_csv(url) %>%
  slice(11 : 82)

# Q1
paste0("Q1: ", apple_data$trackName[12] %>% nchar)

# Q2
lowercase_mutated <- apple_data %>%
  mutate(track_name_lower=trackName %>% tolower())

paste0("Q2: ", lowercase_mutated$track_name_lower[31])

# Q3
cleaned <- lowercase_mutated %>%
  mutate(
    track_name_clean=track_name_lower %>%
      str_remove_all("[[:punct:]]")
  )

paste0("Q3: ", cleaned$track_name_clean[27])

# Q4
seperate_words <- cleaned %>%
  separate_rows(
    track_name_clean,
    sep = " "
  ) %>% select(track_name_clean)

paste0("Q4: ", seperate_words %>% nrow())

unique_words <- seperate_words %>%
  separate_rows(track_name_clean, sep = " ") %>%
  distinct(track_name_clean)

paste0("Q5: ", unique_words %>% nrow())
