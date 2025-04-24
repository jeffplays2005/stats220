library(magick)

meme <- image_read("https://jeroen.github.io/images/frink.png") %>%
  image_annotate("Cats are better than dogs")

image_write(meme, "cat_meme.png")
