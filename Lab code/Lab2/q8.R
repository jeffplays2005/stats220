library(tidyverse)

song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=1515567882&single=true&output=csv")

song_data %>%
  ggplot() +
  # Change to y= for horizontal
  # Use x= for vertical
   geom_bar(aes(y = key_name))
