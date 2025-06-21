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

![](https://media.discordapp.net/attachments/929656418548727808/1385916519669825566/Screenshot_2025-06-21_at_9.37.17_PM.png?ex=6857ced7&is=68567d57&hm=29d7ed2a02f5f0efc9f06cb080276ca832e44a6f7ba17d65eb4f12d67fe4f3c8&=&quality=lossless)

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
