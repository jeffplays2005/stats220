# Lab 4B


```R
song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4B.json")

genre_data <- song_data %>%
  mutate(main_genre = case_when(
    str_detect(artist_genre, "rock") ~ "rock",
    str_detect(artist_genre, "hip hop") ~ "hip hop",
    str_detect(artist_genre, "country") ~ "country",
    str_detect(artist_genre, "r&b") ~ "r&b",
    str_detect(artist_genre, "pop") ~ "pop",
    TRUE ~ "other"
  ))

genre_summarised <- genre_data %>%
  count(main_genre)

genre_summarised %>%
  ggplot() +
  geom_col(aes(y = reorder(main_genre, -n),
               x = n)) +
  labs(y = "Main genre",
       x = "Number of songs")
```

## Explanation of functions

`reorder` is a function that can help us specify the ordering we want of a dataframe, e.g.:
```R
reorder(main_genre, -n)
```

The function also takes a ordering, i.e. `-n` means largest to smallest.
