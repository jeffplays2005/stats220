## ggplot

GG stands for grammar of graphics

## geom_count

`geom_count` - points sized based on data collected

```R
data %>%
  ggplot() +
  geom_count(aes(x = post_num_words,
    y = post_category))
```

![](https://docnamic.online/stats220_S125/notes_4B_files/figure-html/unnamed-chunk-15-1.png)

## geom_density

`geom_density` - a 1 variable plot that takes care of the y-axis for you. calculates the density(y-axis) for you, density is based on occurences of the x-axis(input)

```R
ggplot(ed_data) +
  geom_density(aes(x = post_num_words),
    fill = "pink") +
  theme(axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    panel.background = element_rect(fill = "#dcd0ff")
    )
```

![](https://docnamic.online/stats220_S125/notes_4A_files/figure-html/unnamed-chunk-10-1.png)

## geom_line

```R
file_names <- paste0("https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants", 1 : 15,".csv")

all_the_data <- map_df(file_names, read_csv)

lecture_counts <- all_the_data %>%
  group_by(date_lecture, private_name) %>%
  summarise(total_duration_minutes = sum(duration_minutes)) %>%
  count(date_lecture)

lecture_counts %>%
  ggplot() +
  geom_line(aes(x = date_lecture,
    y = n))
```

![](https://i.imgur.com/EWgECrk.png)

## geom_bar

```R
ggplot(data = spotify_data) +
  geom_bar(aes(x = mode_name))
```

![](https://i.imgur.com/XqP3jl5.png)

## geom_col

Graph 1:

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
  geom_col(aes(x = main_genre,
    y = n))
```

![](https://i.imgur.com/ompBmAI.png)

Graph 2:

```R
students_per_recording %>%
  ggplot(aes(x = num_students),
    y = reorder(session_name, -lecture_num)) +
  geom_col(aes(fill = num_students)) +
  geom_text(aes(label = numbers),
    position = position_nudge(x = 6)) +
  labs(title = "Number of students watching each lecture recording",
    x = "Number of students",
    y = "Lecture name") +
  guides(fill = "none") +
  theme_minimal()
```

![](https://i.imgur.com/FWJwYe4.png)

## geom_boxplot

```R
song_data <- fromJSON("https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab4A.json")

genre_data <- song_data %>%
  mutate(main_genre = case_when(
    str_detect(artist_genre, "rock") ~ "rock",
    str_detect(artist_genre, "hip hop") ~ "hip hop",
    str_detect(artist_genre, "country") ~ "country",
    str_detect(artist_genre, "r&b") ~ "r&b",
    str_detect(artist_genre, "pop") ~ "pop",
    TRUE ~ "other"
  ))

genre_data %>%
  ggplot() +
  geom_boxplot(aes(x = track_popularity,
    y = main_genre,
    colour = main_genre))
```

![](https://docnamic.online/stats220_S125/lab_4B_files/figure-html/unnamed-chunk-17-1.png)

## geom_histogram

Another 1 variable plot. Other arguments allowed to adjust certain parts of the diagram, e.g. `binwidth`

```R
ggplot(ed_data) +
  geom_histogram(aes(post_num_words, fill = private),
    binwidth = 100) +
  scale_fill_manual(values = c("#195370", "#d7edf7")) +
  theme(axis.title = element_text(colour = "#195370"),
    legend.title = element_text(colour = "#195370"),
    panel.background = element_rect(fill = "#ffffff"))
```

![](https://docnamic.online/stats220_S125/notes_4A_files/figure-html/unnamed-chunk-11-1.png)

# Additional customise options

- `labs()` to change `x`, `y`, and `caption`

```R
labs(x = "Track Popularity", y = "Genre", caption = "Data from Spotify")
```

- `annotate(type, x, y, label)` to add text or shapes to the plot

```R
annotate("text", x = 50, y = 5, label = "Popularity vs Genre")
```

- `scale_fill_manual` to override the default fill colors

```R
scale_fill_manual(values = c("#195370", "#d7edf7"))
```

- `guides()` to remove the legend

```R
guides(fill = "none")
```
