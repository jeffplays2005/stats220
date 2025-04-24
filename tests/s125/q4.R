library(magick)

square1 <- image_blank(width = 500, 
            height = 500, 
            color = "#000000") %>% 
  image_annotate(text = "1",
                 color = "#fff",
                 size = 200,
                 gravity = "north")

square2 <- image_blank(width = 500, 
           height = 500, 
           color = "#000000") %>%
  image_annotate(text = "2",
                 color = "#fff",
                 size = 200,
                 gravity = "south")

vect <- c(square1, square2)
image_animate(vect, fps = 1)