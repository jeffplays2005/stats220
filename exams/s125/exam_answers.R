library(tidyverse)
library(rvest)

################
## Q2
################

ed_data <- read_csv("https://docnamic.online/auto_code/ed/?id=3fece0af2c10da22487ccf51a862e29a7b92daeed71d5c39c27c7bdac471aaae")

## Part A

view_data <- ed_data %>%
  filter(views != 0) %>%
  group_by(date) %>%
  summarise(num_views = n()) %>%
  mutate(
    day = day(ymd(date)),
    month = month(ymd(date), label = TRUE),
  )

view_data %>%
  ggplot() +
  geom_col(aes(x = date, y = num_views)) +
  labs(x = "Day",
    y = "Number of users")

## Part B

active_data <- ed_data %>%
  mutate(interactions = views + contributions)

active_per_day <- active_data %>%
  group_by(date) %>%
  mutate(active = case_when(
    interactions == 0 ~ "no",
    TRUE ~ "yes"
  )) %>%
  filter(active == "yes") %>%
  summarise(num_users = n())

active_per_day

## Part C

top_10_student_contributors <- ed_data %>%
  group_by(user_id) %>%
  summarise(mean_num_contributions = mean(contributions)) %>%
  arrange(desc(mean_num_contributions)) %>%
  slice(1 : 10)

top_10_student_contributors %>%
  slice(1)

## Part D

wday_viewed_data <- ed_data %>%
  mutate(weekday = wday(date, label = TRUE, week_start = 7)) %>%
  group_by(weekday) %>%
  filter(views > 0) %>%
  summarise(total_num_views = sum(views))

wday_viewed_data %>%
  ggplot() +
  geom_col(aes(x = weekday, y = total_num_views))


################
## Q5
################

url <- "https://docnamic.online/auto_code/scrape/?id=3fece0af2c10da22487ccf51a862e29a7b92daeed71d5c39c27c7bdac471aaae"

# print the URL so you can copy into a web browser
url

page <- read_html(url)

course_title <- page %>%
  html_elements("h2") %>%
  html_text2()

course_description <- page %>%
  html_elements("#description") %>%
  html_text2()

course_topics <- page %>%
  html_element("ul") %>%
  html_elements("li") %>%
  html_text2()

uni_logo <- page %>%
  html_element("img") %>%
  html_attr("src")

course_dco <- page %>%
  html_elements(".dco") %>%
  html_attr("href")

website_data <- tibble(
  course_title,
  course_description,
  course_topics,
  uni_logo,
  course_dco
)

website_data
################
## Q6
################

thread_data <- read_csv("https://docnamic.online/auto_code/thread/?id=3fece0af2c10da22487ccf51a862e29a7b92daeed71d5c39c27c7bdac471aaae")

## Part A

text_length <- thread_data %>%
  mutate(
    num_chars_text = nchar(text),
    text_amt = case_when(
      num_chars_text < 200 ~ "Below 200 characters",
      num_chars_text > 400 ~ "More than 400\ncharacters",
      TRUE ~ "Between 200 and 400\ncharacters"
    )
  )

text_length %>%
  ggplot() +
  geom_boxplot(aes(x = num_chars_text,
                  y = category,
                  colour = category))

text_length %>%
  ggplot() +
  geom_count(aes(x = text_amt, y = category, color = category)) +
  labs(x = "Number of characters in text of thread", y = "Thread category") +
  guides(colour = "none") +
  theme_minimal()

## Part B

key_words <- c("what", "why", "how", "when", "where")

words <- thread_data %>%
  mutate(clean_text = text %>% 
           str_to_lower() %>%
           str_remove_all("[[:punct:]]") %>%
           str_squish()) %>%
  separate_rows(clean_text, sep = " ") %>%
  select(clean_text) %>%
  filter(clean_text %in% key_words) %>%
  group_by(clean_text) %>%
  summarise(num_used = n())

words %>%
  ggplot(aes(y = reorder(clean_text, num_used),
             x = num_used)) +
  geom_col(fill = "#ffffff") + 
  geom_text(aes(label = num_used),
            position = position_nudge(y = 0)) + 
  labs(y = "key_word")

## Part C

get_similarity <- function(phrase1, phrase2){
  words1 <- phrase1 %>% str_squish() %>% str_split(" ") %>% unlist()
  words2 <- phrase2 %>% str_squish() %>% str_split(" ") %>% unlist()
  num_same <- intersect(words1, words2) %>% length()
  num_total <- union(words1, words2) %>% length()
  num_same / num_total
}

longest_titles <- thread_data %>%
  filter(category == "Projects") %>%
  mutate(text_length = nchar(text)) %>%
  arrange(desc(text_length))

get_similarity(longest_titles$text[1], longest_titles$text[2]) %>%
  paste0()
