Example:

```R
library(tidyverse)
library(rvest)
url <- "https://www.hobbitontours.com/experiences/"

experience_urls <- read_html(url) %>%
  html_elements(".c-pathway__title") %>%
  html_attr("href")

experience_urls
```

Remember to use `library(rvest)` so that the html methods are available.

- `read_html(<url>)` - a function that reads an HTML document from a URL or a file.
- `html_elements(<selector>)` - a function that selects elements from an HTML document using a CSS selector, such as `class` or `id`. You can use `.` to select elements by class or `#` to select elements by id.
- `html_attr(<attribute>)` - a function that extracts the value of an attribute from an HTML element, such as `href` or `src`.
