library(tidyverse)
library(jsonlite)

song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4B.json")

genre_data <- song_data %>%
  separate_rows(artist_genre, sep = ",") %>%
  group_by(artist_genre) %>%
  filter(n() >= 10)

# q1
song_data %>% nrow()
# 91 rows

glimpse(song_data)
