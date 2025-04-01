library(tidyverse)

song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=22653820&single=true&output=csv")

# Need to use the + sign
song_data %>%
  ggplot() +
   geom_bar(aes(x = danceability))
