library(tidyverse)
library(stringr)
library(rvest)
# Does proximity to liquor stores relate to school operational funding among large urban secondary schools and school retention, and are there any patterns with english or pacific language schools?

reference_schools <- read_csv("reference_schools.csv") %>%
  mutate(location = paste0("(", latitude, "," ,longitude, ")"))
school_financial_data <- read_csv("school_financial_data.csv")
nearby_liquor_data <- read_csv("school_nearby_liquor_stores.csv") %>%
  mutate(location = paste0("(", latitude, "," , longitude, ")")) %>%
  group_by(location) %>%
  summarise(num_liquor_stores = n())

# Create theme based on the High school I went to
my_colours <- c("#00a160", "#ffdd00", "#231f20", "#808080")

my_theme <- theme(
  plot.background = element_rect(fill = my_colours[1]),
  panel.background = element_rect(fill = my_colours[4]),
  strip.background = element_rect(fill = my_colours[2]),
  strip.text = element_text(color = "black", face = "bold"),
  text = element_text(family = "sans", color = "black"),
  panel.grid = element_blank(),
  axis.ticks = element_blank(),
  axis.line = element_blank(),
  plot.margin = margin(1, 1, 1, 1, "cm")
)


school_ids <- reference_schools$school_id

get_retention <- function(school_id){
  page_url <- paste0("https://www.educationcounts.govt.nz/find-school/school/retention?district=&region=&school=", school_id)

  Sys.sleep(2)

  html <- read_html(page_url) %>%
    html_element("table")

    if(length(html) > 0){
      scraped_data <- html %>%
          html_table()

      retention_data2 <- scraped_data %>%
        janitor::clean_names() %>%
        select(left_before_17th_birthday_3) %>%
        slice(n()) %>%
        mutate(left_before_17th_birthday_3 = parse_number(as.character(left_before_17th_birthday_3))) %>%
        select(left_before_17th_birthday_3) %>%
        mutate(school_id)
    }
}

school_retention_data <- map_df(school_ids, get_retention)
school_retention_data

joined_data <- reference_schools %>%
  left_join(school_financial_data, by = "school_id") %>%
  left_join(nearby_liquor_data, by = "location") %>%
  left_join(school_retention_data, by = "school_id") %>%
  mutate(
    funding_thousands = school_operations / 1000000 %>% round(2),
    language_of_instruction = str_detect(str_to_lower(language_of_instruction), "pacific"),
    language_of_instruction = case_when(
      language_of_instruction ~ "Pacific Language",
      TRUE ~ "English"
    ),
  )

my_viz <- ggplot(joined_data, aes(x = num_liquor_stores,
    y = funding_thousands,
    color = left_before_17th_birthday_3)) +
  geom_jitter(size = 3, alpha = 0.8, width = 0.3) +
  scale_color_viridis_c(option = "plasma") +
  facet_wrap(vars(joined_data$language_of_instruction)) +
  labs(
    title = "Liquor Store Proximity vs Funding & Retention Between Languages Taught",
    x = "Number of Nearby Liquor Stores",
    y = "Operational Funding (in Millions NZD)",
    color = "Left Before 17 (Number of Students)"
  ) +
  my_theme

print(my_viz)
ggsave("my_viz.png", my_viz, width = 12, height = 6, dpi = 300)
