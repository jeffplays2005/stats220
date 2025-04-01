library(tidyverse)

song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=311993019&single=true&output=csv")

song_data %>%
  ggplot() +
  # Need to put the fill after aes as is part of the geom_bar
   geom_bar(aes(x = danceability), fill = "#aecdd2")
