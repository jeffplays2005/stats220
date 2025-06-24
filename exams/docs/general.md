- `bind_rows()` function from the {dplyr} function allows us to ‘bind’ many data frames into one. You can think about it like you are stacking data frames on top of each other.

```R
# creating and naming the first data frame
data1 <- read_csv("https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants1.csv")

# creating and naming the second data frame
data2 <- read_csv("https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants2.csv")

# using bind_rows to combine the data frames together into one
combined_data <- bind_rows(data1, data2)

# view data
combined_data
```

- `map_df` function from the {purrr} package allows us to apply a function to each element of a list and return a data frame.

```R
# creating a list of data frames
data_list <- list(data1, data2)

# using map_df to combine the data frames together into one
combined_data <- map_df(data_list, ~ read_csv(.x))

# view data
combined_data
```

- `nrow()` function from the package allows us to find the number of rows in a 2D data frame.

```R
# view number of rows in combined_data
nrow(combined_data)
```

- `length()` function from the package allows us to find the number of elements in a 1D flat vector.

- `count()` function from the {dplyr} package allows us to count the number of occurrences of each unique value in a vector.
