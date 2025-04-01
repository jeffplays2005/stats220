# Lab 2b

* Mainly learning `{dplyr}` and `{ggplot2}` from the `tidyverse` package.

# Common methods that can be used

* obtaining the names of variables in a data frame using `names()`
* inspecting a data frame using `print()` and `glimpse()`
* renaming variables/columns in a data frame using `rename()`
* slicing rows of a data frame using `slice()` and `nrow()`
* selecting variables in a data frame using `select()`
* creating plots using `ggplot()` and `geom_bar()`
* changing the fill colour of bars
* exploring more options for `aes()`
* adding labels to plots with `labs()`
* separating a variable into rows using `separate_rows()`

# Slice

* Can use regular slicing like in Python

```R
popularity_vector <- spotify_data$popularity
popularity_vector[1 : 10] # slices from index 1 to index 10
```

Can also use a `slice()` method, is essentially the same formatting but used in a method
```R
slice(1 : 3)
```

Can also take a vector:
```R
slice_vector <- c(1, 7, 8)
spotify_data %>%
  slice(slice_vector) %>%
  print()
```

# Extra methods
`n_row()` - returns number of rows
