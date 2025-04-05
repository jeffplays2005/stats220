library(tidyverse)
song_title <- c("Circles Around This Town", "Pressure", "I Hate YoungBoy", "P power (feat. Drake)", "Heart On Fire", "By Your Side", "Banking On Me", "City of Gods", "If I Was a Cowboy", "The Joker And The Queen (feat. Taylor Swift)", "Do It To It", "I Love You So", "The Motto", "High", "I'm Tired - From 'Euphoria' An HBO Original Series", "Waiting On A Miracle", "Usain Boo")

song_length <- c(195760, 193279, 261818, 193346, 258799, 194050, 200000, 256000, 195013, 185422, 157890, 160239, 164818, 175163, 187943, 161840, 186677)

song_popularity <- c(76, 73, 70, 85, 71, 83, 83, 87, 77, 89, 95, 95, 94, 87, 88, 87, 74)

song_data <- tibble(song_title, song_length, song_popularity)

song_data <- song_data %>% mutate(song_income = song_length * 0.01)
song_data$song_income[3]

song_data <- song_data %>% mutate(song_title_lower = str_to_lower(song_title))

song_data$song_title_lower[2]

song_data %>%
    filter(str_detect(song_title_lower, "w")) %>%
    nrow()
