# Notes 5B

- A focus on URL patterns, exploiting HTML structures and CSS styles.
- Checking for quality data
- Web scraping

```R
library(tidyverse)
library(rvest)
library(magick)

dates <- c("2004-05-09", "2014-05-09", "2025-05-09")

url <- paste0("https://aotearoamusiccharts.co.nz/archive/singles/", dates[1])

page <- read_html(url)

img_urls <- page %>%
  html_elements(".aspect-square") %>%
  html_elements("img") %>%
  html_attr("src") %>%
  paste0("https://aotearoamusiccharts.co.nz", .)

just_images <- img_urls[str_detect(img_urls,"images")]

just_images %>%
  image_read() %>%
  image_scale(500) %>%
  image_animate(fps = 1)
```

The code above scrapes the images from the specified URL, filters them to include only those that contain "images" in their URL, and then reads and animates them using the `magick` package. The final output is a GIF that displays the images at a frame rate of 1 frame per second.

Important things to understand:

- `paste0` was used in the url to concatenate the base URL with the dates.
- `html_elements()` was used twice to first select the elements with the class "aspect-square" and then to select the "img" elements within those.
- `src` inside `html_attr()` was used to extract the source URLs of the images.
- The `.` inside of paste0() is a placeholder for the previous output, which is the image URL.
- How `just_images` was created to filter the URLs to only include those that contain "images" using `str_detect`.
