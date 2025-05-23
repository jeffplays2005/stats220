# Lab 5B

# `separate_rows`

A function that takes a string and separates it into rows based on a specified delimiter. It returns a list of strings, each representing a row.

Can be used to find the number of unique words in a string.

E.g.

```R
clean_text <- lyrics_data %>%
  mutate(words = lyrics %>%
           str_replace_all("\n", " ") %>%
           str_to_lower() %>%
           str_remove_all("[[:punct:]]") %>%
           str_squish()) %>%
  separate_rows(words, sep = " ")
```
