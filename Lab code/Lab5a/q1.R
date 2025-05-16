library(tidyverse)

url1 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants14.csv"
url2 <- "https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants2.csv"

data1 <- read_csv(url1)
data2 <- read_csv(url2)

# Get no. rows
nrow(data1)

# Get number of unique participants
data1$private_name %>% unique() %>% length()

# Combine the two datasets
combined_data <- bind_rows(data1, data2)

# Get the number of unique participants in the combined dataset
combined_data$duration_minutes %>%
  mean() %>%
  round(1)

# grouped_data <- combined_data %>%
#   group_by(private_name) %>%
#   summarise(total = sum(duration_minutes))

# grouped_data$total %>%
#   max()

combined_data %>%
  group_by(private_name) %>%
  summarise(total_time = sum(duration_minutes, na.rm = TRUE)) %>%
  summarise(max_total_time = max(total_time))

combined_data %>%
  filter(in_waiting_room == "Yes") %>%
  group_by(date_lecture) %>%
  summarise(waiting_count = n()) %>%
  arrange(desc(waiting_count)) %>%
  slice(1)
