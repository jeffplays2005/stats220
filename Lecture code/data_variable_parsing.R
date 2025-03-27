library(tidyverse)
# explore this code!
google_url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vQxETGlB1yUHZHciSNrrifJatVr7HxZVK1f3TiXiVWt5cs8IHHBpk0XKxL-oN-8lMIzMmF_MNnoi0wT/pub?gid=1685715257&single=true&output=csv"

survey_data <- read_csv(google_url)

survey_data_renamed <- survey_data %>%
  rename(prev_course = 2,
         programming_confidence = 3,
         part_time_job = 4,
         part_time_hours = 5,
         pizza_pref = 6,
         height_cm = 7,
         adopt_pet = 8,
         positive_thing = 9,
         upi_example = 10)

names(survey_data_renamed)

# round() function lets you round to x d.p.
# the $ sign is similar to [""] or . form when selecting a value from an object
survey_data_renamed$programming_confidence %>% mean() %>% round(1)
# na.rm indicates to remove NA values
survey_data_renamed$part_time_hours %>% mean(na.rm = TRUE)
# How to remove na and also count number of data
data <- survey_data_renamed$part_time_hours
