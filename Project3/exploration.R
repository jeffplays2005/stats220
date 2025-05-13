library(tidyverse)
library(httr)
library(magick)

api_key <- ""

url <- "https://api.pexels.com/v1/search?query=Japanese%20food&per_page=80"

response <- httr::GET(url,
    add_headers(Authorization = api_key))

data <- httr::content(response,
    as = "parsed",
    type = "application/json")

photo_data <- tibble(photos = data$photos) %>%
  unnest_wider(photos) %>%
  unnest_wider(src)

# Select ~20 images based on certain criteria
selected_photos <- photo_data %>%
    # Get the aspect ratio of the image
    mutate(aspect_ratio = width / height) %>%
    # Determine if the image is landscape, portrait, or square
    mutate(orientation = ifelse(
        aspect_ratio > 1, "landscape", ifelse(aspect_ratio < 1, "portrait", "square")
    )) %>%
    # Determine if the image is high resolution
    mutate(alt_text_length = nchar(alt)) %>%
    # Filter to around 20 photos based on the height of the image being less than 3200
    filter(height < 3200)

# Write the selected data to a csv file
write_csv(selected_photos, "selected_photos.csv")

# Part D : Summarising data about your selected photos
# Get the grouped average aspect aspect_ratio
grouped_average_aspect_ratios <- selected_photos %>%
    group_by(orientation) %>%
    summarise(mean_aspect_ratio = mean(aspect_ratio, na.rm = TRUE))
# Get the mean aspect ratio for landscape images
mean_aspect_landscape <- grouped_average_aspect_ratios %>%
    filter(orientation == "landscape") %>%
    pull(mean_aspect_ratio) %>%
    round(2)
# Get the mean aspect ratio for portrait images
mean_aspect_portrait <- grouped_average_aspect_ratios %>%
  filter(orientation == "portrait") %>%
  pull(mean_aspect_ratio) %>%
  round(2)
# Get the average alt text length
average_alt_text_length <- selected_photos$alt_text_length %>%
    mean(na.rm = TRUE) %>%
    round()
# Get the most common orientation
most_common_orientation <- selected_photos %>%
    count(orientation, sort = TRUE) %>%
    slice(1) %>%
    pull(orientation)

mean_aspect_landscape
average_alt_text_length
most_common_orientation

# Part E: Creativity

# Take a list slice of 5 images under the small urls
# Note that I'm using large because small is far too pixelated
image_urls <- selected_photos$large[1:5]
# Ramen frame 1
ramen <- image_read(image_urls[1]) %>%
    image_scale(400)
text1 <- image_blank(width = 400, height = 50, color = "#000000") %>%
  image_annotate(
    text = "When you're hungry in Japan...",
    color = "#FFFFFF",
    size = 25,
    gravity = "center",
    font="Palatino"
  )
ramen_frame <- c(text1, ramen) %>% image_append(stack=TRUE)
# Bento frame 2
bento <- image_read(image_urls[2]) %>%
    image_scale(400)
text2 <- image_blank(width = 400, height = 50, color = "#000000") %>%
  image_annotate(
    text = "You can't go wrong with a bento!",
    color = "#FFFFFF",
    size = 25,
    gravity = "center",
    font="Palatino"
  )
bento_frame <- c(text2, bento) %>% image_append(stack=TRUE)
# Salmon nigir frame 3
salmon_nigiri <- image_read(image_urls[3]) %>%
    image_scale(400)
text3 <- image_blank(width = 400, height = 50, color = "#000000") %>%
  image_annotate(
    text = "Salmon nigiri is a classic!",
    color = "#FFFFFF",
    size = 25,
    gravity = "center",
    font="Palatino"
  )
salmon_nigiri_frame <- c(text3, salmon_nigiri) %>% image_append(stack=TRUE)
# Food(i'm not quite sure what dish this is!) frame 4
food <- image_read(image_urls[4]) %>%
    image_scale(400)
text4 <- image_blank(width = 400, height = 50, color = "#000000") %>%
  image_annotate(
    text = "Every bite is a memory!",
    color = "#FFFFFF",
    size = 25,
    gravity = "center",
    font="Palatino"
  )
food_frame <- c(text4, food) %>% image_append(stack=TRUE)
# Dumplings frame 5
dumplings <- image_read(image_urls[5]) %>%
    image_scale(400)
text5 <- image_blank(width = 400, height = 50, color = "#000000") %>%
  image_annotate(
    text = "Dumplings? Yes please!",
    color = "#FFFFFF",
    size = 25,
    gravity = "center",
    font="Palatino"
  )
dumplings_frame <- c(text5, dumplings) %>% image_append(stack=TRUE)
# Concatenated gif
creativity_gif <- c(ramen_frame, bento_frame, salmon_nigiri_frame, food_frame, dumplings_frame) %>%
  image_animate(fps = 1)

creativity_gif
image_write(creativity_gif, "creativity.gif")
