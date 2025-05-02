library(tidyverse)
library(jsonlite)

json_url <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab3b_json40.json"

song_data <- fromJSON(json_url)

track_names <- song_data %>%
    pull(track_name)

paste("Name of song in x row:", track_names[54])

durations <- song_data %>%
    pull(duration_ms)

paste("Length:", length(durations))

paste("Median:", median(durations))

popularity <- song_data %>%
    pull(track_popularity)

# the unique() function returns a vector of unique values
unique_popularity <- unique(popularity)

paste("Unique popularity scores: ", length(unique_popularity))

artists <- song_data %>%
    separate_rows(artist_name, sep = ", ") %>%
    pull(artist_name) %>%
    unique() %>%
    length()

paste("Different artists:", artists)

# Question How many tracks are there in the data frame named song_data where the popularity score is greater than 73 AND artist_genre contains "pop" anywhere in its name?
contains_pop <- song_data %>%
    filter((track_popularity > 78) & (str_detect(str_to_lower(artist_genre), "pop"))) %>%
    nrow()

paste("Tracks with popularity > x and genre containing 'pop':", contains_pop)

pop_songs <- song_data %>%
    mutate(pop = ifelse(str_detect(str_to_lower(artist_genre), "pop"), "yes", "no"))

paste("Value of pop:", pop_songs$pop[25])

pop_songs %>%
    group_by(pop) %>%
    summarise(median_track_popularity = median(track_popularity))

long_songs <- song_data %>%
    mutate(track_name_num_words = str_count(track_name, "\\S+"))

paste("Value of track_name_num_words at x row:", long_songs$track_name_num_words[2])

greater_than_x <- long_songs %>%
    filter(track_name_num_words > 3) %>%
    nrow()

paste("Tracks with track_name_num_words > x:", greater_than_x)

# strsplit("Need to Know", " ")[[1]] %>% length()
