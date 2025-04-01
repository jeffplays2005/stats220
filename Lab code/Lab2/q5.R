library(tidyverse)

song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=367178289&single=true&output=csv")

# takes tempo, then artist_name
# ordering matters!
song_data %>%
  select(tempo, artist_name)

song_data %>%
  select(artist_name, tempo)
