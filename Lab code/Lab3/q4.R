library(tidyverse)

song_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vS8ynnfEAOH9G59D6ZS0EhW6X9taKBE2ou0Z6qO_XJUzwCuD_DjNvDNRNuouNivlgptmqyqBZYsrKTs/pub?gid=22653820&single=true&output=csv")

song_data %>%
    # use desc() to sort in descending order
    arrange(desc(track_id)) %>%
    glimpse()
# Dont use length(), should be nrow() to get number of rows
song_data %>%
    filter(rand_var < 0.06) %>%
    nrow()
