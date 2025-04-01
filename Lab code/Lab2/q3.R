library(tidyverse)

song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=1362162571&single=true&output=csv")

names(song_data)

song_data %>%
  rename(new_name = 2) # the new name is followed by the index

names(song_data)
