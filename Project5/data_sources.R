library(tidyverse)
library(jsonlite)
library(rvest)

directory_data <- read_csv("schools_directory.csv") %>%
  janitor::clean_names()

# Get the data for my specific high school
my_school <- directory_data %>%
  filter(org_name == "Western Springs College-Ngā Puna o Waiōrea")

# It is responsible to scrape data from the school's website as the robots.txt file allows it and the website Terms of Service do not prohibit scraping.

url <- my_school$url
print(url)

school_id <- my_school$school_id

page_url <- paste0("https://www.educationcounts.govt.nz/find-school/school/financial-performance?district=&region=&school=", school_id)

html <- read_html(page_url) %>%
  html_element("table")

if(length(html) > 0){

  scraped_data <- html %>%
     html_table()

  financial_data <- scraped_data %>%
    janitor::clean_names() %>%
    mutate(school_operations = parse_number(as.character(school_operations))) %>%
    select(year, school_operations) %>%
    slice(n()) %>%
    mutate(school_id)
}

# Part C

reference_schools <- directory_data %>%
  filter(
    urban_rural_indicator == "Major urban area",
    str_detect(org_type, "Secondary"),
    total > 1500
  ) %>%
  select(school_id, org_name, url, latitude, longitude, school_donations, authority, total, language_of_instruction, boarding_facilities) %>%
  drop_na(url)

# Part D

write_csv(reference_schools, "reference_schools.csv")

school_ids <- reference_schools$school_id

get_finance <- function(school_id){

  page_url <- paste0("https://www.educationcounts.govt.nz/find-school/school/financial-performance?district=&region=&school=", school_id)

  Sys.sleep(2)

  html <- read_html(page_url) %>%
    html_element("table")

   if(length(html) > 0){
      scraped_data <- html %>%
         html_table()

      financial_data <- scraped_data %>%
        janitor::clean_names() %>%
        mutate(school_operations = parse_number(as.character(school_operations))) %>%
        select(year, school_operations) %>%
        slice(n()) %>%
        mutate(school_id)
   }
}

school_financial_data <- map_df(school_ids, get_finance)

write_csv(school_financial_data, "school_financial_data.csv")

get_html <- function(url){

  page <- try(read_html(url), silent = TRUE)

  # If no errors
  if (!inherits(page, "try-error")) {

      # find any images on page
      images <- page %>%
          html_elements("img") %>%
          html_attr("src")

      # count number of images
      num_images_website <- length(images)

      return(tibble(url, num_images_website))
  }
}

get_html(url)
school_urls <- reference_schools$url

school_website_data <- map_df(school_urls, get_html)

write_csv(school_website_data, "school_website_data.csv")

# Part E

api_key <- "7eccd3b12e3005aa86edc3c0aa9175cd6eeac0d420cc4a8b750ce2aa8b3f54d0"
lat <- my_school$latitude
lng <- my_school$longitude
query <- paste0("https://docnamic.online/auto_code/api?api_key=", api_key, "&lat=", lat, "&lng=", lng)
liquor_stores <- fromJSON(query)

school_queries <- paste0("https://docnamic.online/auto_code/api?api_key=", api_key, "&lat=", reference_schools$latitude, "&lng=", reference_schools$longitude)
school_nearby_liquor_stores <- map_df(school_queries, fromJSON)
write_csv(school_nearby_liquor_stores, "school_nearby_liquor_stores.csv")
