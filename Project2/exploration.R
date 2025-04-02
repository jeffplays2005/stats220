library(tidyverse)

# Response URL: https://docs.google.com/forms/d/e/1FAIpQLSf4rmacL9K_ezWW_C92FfgstcIl4NAjElpnrz7rkkhlYRO7QA/viewform?usp=dialog

# Read the live data fetched from Google Forms
csv_url <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vQQsnK3yQ3KQXql3aXCS0ujXL_eQYKC6LqyZg2mbyTNNn_jwdjkWKwaNJER7r0AOisfqaVQMQNXe0RD/pub?gid=415582428&single=true&output=csv"
logged_data <- read_csv(csv_url)

# # Rename the columns to make them more readable
latest_data <- rename(logged_data,
    shorts_watched=2,
    session_length=3,
    shorts_liked=4,
    shorts_skipped=5,
    most_shown_topic=6,
    liked_shorts_relevancy=7,
    skipped_shorts_relevancy=8
)

# Generate some statistics
# Round the decimal places for more readability
average_shorts_watched <- mean(latest_data$shorts_watched) %>% round()
number_of_responses <- nrow(latest_data)
maximum_session_length <- max(latest_data$session_length)
minimum_session_length <- min(latest_data$session_length)

# Print the statistics
paste("The total number of individuals that completed the survey is:", number_of_responses)
paste("The average number of shorts individuals watch are:", average_shorts_watched)
paste("The maximum session time recorded was", maximum_session_length, "and the minimum session time recorded was", minimum_session_length)

# Generate some plots
# Generate bar plot for most shown topic
ggplot(latest_data) +
    geom_bar(aes(x = most_shown_topic)) +
    labs(title = "Most Shown Topics in Shorts", x = "Topic", y = "Count")

# Generate bar plot for relevance rating of liked shorts compared to number of likes
ggplot(latest_data) +
  geom_bar(aes(x = shorts_liked, fill = liked_shorts_relevancy)) +
  labs(title = "Relevance rating of liked shorts compared to number of shorts liked", x = "Relevance Rating", y = "Shorts liked")

# Generate bar plot for relevance rating of skipped shorts
ggplot(latest_data) +
  geom_bar(aes(x = skipped_shorts_relevancy, fill = shorts_skipped)) +
  labs(title = "Relevance rating of skipped shorts", x = "Relevance Rating", y = "Count")
