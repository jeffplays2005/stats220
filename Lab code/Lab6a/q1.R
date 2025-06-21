library(tidyverse)

headlines_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vSzM_3hRnNKMfAv3-bn_yF833sqB7AWrMVEGs2dRKJ77myE7oHX2VKDlKWg6NmiVZ5Cj5Y5gFY4KSo1/pub?gid=0&single=true&output=csv") %>%
  slice(317 : 461)

# Q1
paste(headlines_data$headline[34])

# Q2
headline_words1 <- headlines_data$headline[28] %>%
  str_squish() %>%
  str_split(" ") %>%
  unlist()

paste0("Q2: ", headline_words1[10])

# Q3
headline_words2 <- headlines_data$headline[93] %>%
  str_squish() %>%
  str_split(" ") %>%
  unlist()
paste0("Q3: ", headline_words2 %>% length())

# Q4
all_words <- union(headline_words1, headline_words2)
paste0("Q4: ", all_words %>% length())

# Q5
same_words <- intersect(headline_words1, headline_words2)
paste0("Q5: ", same_words %>% length())

get_similarity <- function(phrase1, phrase2){

  words1 <- phrase1 %>% str_squish() %>% str_split(" ") %>% unlist()
  words2 <- phrase2 %>% str_squish() %>% str_split(" ") %>% unlist()

  num_same <- intersect(words1, words2) %>% length()
  num_total <- union(words1, words2) %>% length()

  num_same / num_total # remember last thing created is returned by default, or use return()
}

# Q6
get_similarity(headlines_data$headline[61], headlines_data$headline[86]) %>%
  round(1) %>%
  paste0("Q6: ", .)

# Q7
compare_headlines <- tibble(headline1 = headlines_data$headline[1:72], headline2 = headlines_data$headline[73:144])

similarity_data <- compare_headlines %>%
  rowwise() %>%
  mutate(similarity_score = get_similarity(headline1, headline2))

paste0("Q7: ", similarity_data$similarity_score[42] %>% round())
paste0("Q8: ", round(max(similarity_data$similarity_score), 1))
paste0("Q9: ", round(mean(similarity_data$similarity_score), 1))
