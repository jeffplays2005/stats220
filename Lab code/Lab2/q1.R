library(tidyverse)
song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vQjF1Hf5KQ9--IboWbmaXJ14tknXsXUcfTlqZM4CVI3OiSnG_w6BxQcD5EJ4lvF5UeVXXLPmWyckJQ2/pub?gid=367178289&single=true&output=csv")
song_column_names <- names(song_data)

# names() function gives the column names of a csv data set
song_column_names[1] # popularity
song_column_names[4] # track_name
