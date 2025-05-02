library(tidyverse)

song_popularity <- c(90, 90, 76, 72, 63, 89, 82, 87, 83, 74, 82, 87, 76, 96, 83, 88, 83, 85, 68, 86, 93, 87, 89, 71, 95, 95, 80, 73, 81, 85, 75, 92, 89, 91, 85, 91, 93, 93, 100, 79, 74, 89, 85, 59, 93, 95, 74, 90, 97, 85, 94, 81, 85, 70, 94, 84, 71, 76, 83, 33, 74, 85, 77, 87, 67, 77, 67, 92, 85, 91, 86, 83, 76, 75, 87, 80, 92, 74, 87, 92, 67, 83)

indexes <- c(21:35)
c(song_popularity[indexes]) %>% sum()

sorted_songs <- song_popularity %>% sort(decreasing=TRUE)

sorted_songs[30]

sorted_songs[32] != sorted_songs[13]
