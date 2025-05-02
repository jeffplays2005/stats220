## Summarising data

Mainly surrounding `{dplyr}` and `{stringr}` from the `{tidyverse}`

New packages needed to be installed:

```R
library(jsonlite)
```

### Reading JSON into a data frame using `fromJSON()`

To read a JSON file into a data frame in R, you can use the `fromJSON()` function from the `{jsonlite}` package. This function parses the JSON data and converts it into an R data frame, which can then be manipulated and analyzed using other functions from the `{tidyverse}`.

```R
json_url <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab3B.json"

json_url %>%
  fromJSON %>%
  toJSON(pretty = TRUE)
```

### From JSON to data frame

```R
json_url <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/data/lab3B.json"
song_data <- fromJSON(json_url)

song_data %>%
    glimpse()
```

Note that you can pull a specific variable using: `song_data$track_popularity`!
Another method `song_data %>% pull(track_popularity)`

We can also pipe `song_data %>% pull(track_popularity)` into other functions, such as `mean()`, `length()`, `min()`, etc.

```R
song_data %>%
    pull(track_popularity) %>%
    mean()
```

We can use `summarise()` to focus on specific variables and perform calculations on them. For example, we can calculate the mean and standard deviation of the `track_popularity` variable:

```R
song_data %>%
    summarise(
        mean_popularity = mean(track_popularity),
        sd_popularity = sd(track_popularity)
    )
```

The `unique()` function returns a vector of unique values.
The `length()` function returns the number of elements in a vector.

```R
unique_popularity <- unique(song_data$track_popularity)
length(unique_popularity)
```

#### Multiple values in one cell

E.g. `Alicia Keys, JAY-Z` and we want to split them into separate rows.

```R
artists <- song_data %>%
    separate_rows(artist_genre, sep = ", ")

length(artists)
```
