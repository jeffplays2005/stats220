library(tidyverse)

csv_link <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=997193167&single=true&output=csv"
song_data <- read_csv(csv_link)

# A list view that displays all the data row by row
print(song_data)
# Displays a glimpse of the data inline
glimpse(song_data)
