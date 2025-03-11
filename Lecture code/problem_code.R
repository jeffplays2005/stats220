library(magick)

my_meme <- image_read("https://cataas.com/cat") %>%
  image_annotate(text = "What you looking at?", font = "Impact", size = 100)

image_write(my_meme, "my_meme.png")
my_meme

