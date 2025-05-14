library(tidyverse)
library(lubridate)

# Read the data fetched from Google Forms
csv_url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vQQsnK3yQ3KQXql3aXCS0ujXL_eQYKC6LqyZg2mbyTNNn_jwdjkWKwaNJER7r0AOisfqaVQMQNXe0RD/pub?gid=415582428&single=true&output=csv"
logged_data <- read_csv(csv_url)

# Rename data for clarity and mutate to get the
latest_data <- rename(logged_data,
  timestamp=1,
  shorts_watched=2,
  session_length=3,
  shorts_liked=4,
  shorts_skipped=5,
  most_shown_topic=6,
  liked_shorts_relevancy=7,
  skipped_shorts_relevancy=8
) %>%
# Mutate each data for before or after mid semester break based on date time comparisons
mutate(mid_sem_period_unsorted = if_else(dmy_hms(timestamp) < dmy("14/04/2025"),
  "Before Mid-Sem Break", "After Mid-Sem Break"
),
mid_sem_period = factor(mid_sem_period_unsorted, levels = c("Before Mid-Sem Break", "After Mid-Sem Break")))

# Colours chosen from Color Brewer 2:
my_colours <- c("#e7e1ef", "#c994c7", "#dd1c77")
# Create a ggplot theme
my_theme <- theme(plot.background = element_rect(fill = my_colours[1]),
  panel.background = element_rect(fill = my_colours[1]),
  panel.grid = element_blank(),
  axis.ticks = element_blank(),
  axis.line = element_blank(),
  plot.margin = margin(1,1,1,1,"cm"))

# Mutate data to help determine our attention span and impulsiveness based on the session time
attention_span_focused_data <- latest_data %>%
  mutate(
    # mutate a variable that determines if there were more shorts liked or skipped
    more_liked_or_skipped = if_else(
      shorts_liked >= shorts_skipped,
      "liked",
      "skipped"
    )
  )

# Create a geom_density plot to show the session time differences between liked vs skipped shorts
plot1 <- ggplot(attention_span_focused_data) +
  geom_density(aes(x = session_length,
    fill = more_liked_or_skipped),
    alpha = 0.5,
    adjust = 2) +
  labs(title = "Are Session Times Linked to More Skipping?",
    x = "Session length (mins)",
    y = "Density") +
  my_theme
# Save the first plot to plot1.png
ggsave("plot1.png", plot = plot1, width = 2500, height = 2000, units = "px")
plot1

# Get the topic order sorted so that we can use this during factor
topic_order <- latest_data %>%
  count(most_shown_topic, sort = TRUE) %>%
  pull(most_shown_topic)
# Level the topic based on order of most shown topics
levelled_and_ranged_topics <- latest_data %>%
  mutate(
    # Factor the most shown topic based on the ordering
    most_shown_topic = factor(most_shown_topic, levels = topic_order),
    shorts_watched_range = case_when(
      shorts_watched < 10 ~ "0-10",
      shorts_watched < 20 ~ "10-19",
      shorts_watched < 30 ~ "20-29",
      shorts_watched < 40 ~ "30-39",
      shorts_watched < 50 ~ "40-49",
      shorts_watched < 60 ~ "50-59",
      TRUE ~ ">60"
    )
  )
# Create a geom_count plot that shows
plot2 <- ggplot(levelled_and_ranged_topics) +
  geom_count(aes(x = shorts_watched_range, y = most_shown_topic, color = most_shown_topic)) +
  labs(title = "Shorts Watched vs Shown Topic",
    x = "Shorts Watched",
    y = "Most Shown Topic") +
  guides(colour = "none", size = "none") +
  my_theme
# Save the second plot to plot2.png
ggsave("plot2.png", plot = plot2, width = 2500, height = 2000, units = "px")
plot2

# Summarise the time period using dates and observe shorts liked vs shorts skipped
time_period_summarised <- latest_data %>%
  mutate(engagement_type = if_else(shorts_liked >= shorts_skipped, "liked", "skipped"),
    liked_score = case_when( # Converts to numeric values
      liked_shorts_relevancy == "Not at all relevant" ~ 1,
      liked_shorts_relevancy == "Slightly relevant" ~ 2,
      liked_shorts_relevancy == "Moderately relevant" ~ 3,
      liked_shorts_relevancy == "Very relevant" ~ 4,
      liked_shorts_relevancy == "Extremely relevant" ~ 5,
      TRUE ~ 0
    ),
  ) %>%
  group_by(mid_sem_period, engagement_type) %>%
  summarise(
    avg_session = mean(session_length, na.rm = TRUE),
    avg_liked_score = mean(liked_score, na.rm = TRUE),
  )

# Plot using geom_bar to identify any trends between the semester halves
plot3 <- ggplot(time_period_summarised) +
  geom_bar(aes(x = engagement_type, y = avg_session, fill = "Session Length"),
    stat = "identity", position = "dodge") +
  geom_bar(aes(x = engagement_type, y = avg_liked_score * 5, fill = "Liked Relevance"),
    stat = "identity", position = "dodge", alpha = 0.5) +
  facet_wrap(vars(mid_sem_period)) +
  labs(title = "Session vs Like Relevance by Engagement and Period",
    x = "Engagement Type",
    y = "Session length (mins)",
    fill = "Metric"
  ) +
  scale_fill_manual(values = c(my_colours)) +
  my_theme
# Save the plot to plot3.png
ggsave("plot3.png", plot = plot3, width = 2500, height = 2000, units = "px")
plot3

# Put data in relevance of skipped shorts into negative or positive categories
relevancy_data <- latest_data %>%
  mutate(relevance_type = case_when(
    str_detect(skipped_shorts_relevancy, "Not at all") ~ "Negative",
    str_detect(skipped_shorts_relevancy, "Slightly") ~ "Negative",
    TRUE ~ "Positive"
  )) %>%
  group_by(mid_sem_period, relevance_type) %>%
  summarise(avg_session = mean(session_length, na.rm = TRUE))
# Create geom_bar plot showing how session length differs based on relevance of skipped shorts
plot4 <- ggplot(relevancy_data) +
  geom_bar(aes(x = relevance_type, y = avg_session, fill = relevance_type), stat = "identity") +
  facet_wrap(vars(mid_sem_period)) +
  labs(title = "Session by Relevance and Mid-Sem Period",
        x = "Relevance Type",
        y = "Average Session Length (mins)") +
  scale_fill_manual(values = c(my_colours[2],my_colours[3])) +
  my_theme
# Save the plot to plot4.png
ggsave("plot4.png", plot = plot4, width = 2500, height = 2000, units = "px")
plot4
