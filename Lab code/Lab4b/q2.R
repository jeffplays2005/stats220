ggplot() + geom_point(data = summarised_data,
    aes(x = mean_danceability,
      y = reorder(artist_genre, mean_danceability)),
      shape = 17,
      colour = "red",
      size = 4) +
  geom_jitter(data = genre_data,
    aes(x = danceability,
      y = artist_genre),
      height = 0.3,
      colour = "pink",
      size = 2) +
  labs(title = "Comparing danceability of songs by genre",
    y = "Genre of song artist",
    x = "Danceability of song") +
  theme_minimal()
