# create with this code
logged_data <- read_csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTsSQA510X5ufuqzvxHmFyQS9NAxDWTz7bZDsAeYuOqd4rhwn5i5CJn8ONxs50UAI-mvXaPoyvuMEjg/pub?gid=1825885900&single=true&output=csv")

# logged_data

data_grouped <- logged_data %>%
  drop_na(submitted_at) %>%
  group_by(task_name) %>%
  summarise(num_students = n()) %>%
  filter(str_detect(task_name, "quiz"))

data_grouped %>%
  ggplot() +
  geom_col(
    aes(x = num_students, y = task_name),
    fill = "blue"
  ) +
  labs(x="Number of Students", y = "Task Name")
