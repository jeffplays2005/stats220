library(magick)

# inspiration meme url: https://www.reddit.com/r/pokemon/comments/nvsx3d/snorlax_meme/

# store the url
url <- "https://static1.thegamerimages.com/wordpress/wp-content/uploads/2023/08/pokemon-sleep-good-sleep-day-event-image.jpeg"
# fetch/read the image
meme_img <- image_read(url) %>%
  image_scale(500) # scale the image to an appropriate size
# create the top meme text
top_txt <- image_blank(width = 500, height = 109.5, color = "#FFFFFF") %>%
  image_annotate(text = "Snorlax's actual weekends:", color = "#000000", size = 35, gravity = "north") %>%
  image_annotate(text = "Good day", color = "#000000", size = 35, gravity = "south")
# create bottom text
bottom_txt <- image_blank(width = 500, height = 109.5, color = "#FFFFFF") %>%
  image_annotate(text = "Nap all day", color = "#000000", size = 70, gravity = "center")
# create a vector by combining all the text and image
img_vector <- c(top_txt, meme_img, bottom_txt)
meme <- image_append(img_vector, stack = TRUE) # append
# create my_meme.png
image_write(meme, "my_meme.png")

# frame 2
meme_img2 <- image_read("https://i.imgur.com/uPyWNDb.png") %>%
  image_scale(500)
# create new bottom text, top text is the same
bottom_txt2 <- image_blank(width = 500, height = 109.5, color = "#FFFFFF") %>%
  image_annotate(text = "Snack all night", color = "#000000", size = 60, gravity = "center")
img_vector2 <- c(top_txt, meme_img2, bottom_txt2)
frame2_img <- image_append(img_vector2, stack = TRUE)

# part 2, top text changes
top_txt2 <- image_blank(width = 500, height = 109.5, color = "#FFFFFF") %>%
  image_annotate(text = "Snorlax's actual weekends:", color = "#000000", size = 35, gravity = "north") %>%
  image_annotate(text = "Bad day", color = "#000000", size = 35, gravity = "south")

# frame 3
meme_img3 <- image_read("https://pm1.aminoapps.com/7070/d2096a671426b15248a7e8781b20ac65c72f7448r1-924-530v2_hq.jpg") %>%
  image_scale(500)
bottom_txt3 <- image_blank(width = 500, height = 109.5, color = "#FFFFFF") %>%
  image_annotate( text = "Mad all day", color = "#000000", size = 60, gravity = "center")
img_vector3 <- c(top_txt2, meme_img3, bottom_txt3)
frame3_img <- image_append(img_vector3, stack = TRUE)

# frame 4
meme_img4 <- image_read("https://hips.hearstapps.com/digitalspyuk.cdnds.net/16/19/1462804896-snorlax.jpg?crop=1xw:0.8888888888xh;center,top&resize=1200:*") %>%
  image_scale(500)
bottom_txt4 <- image_blank(width = 500, height = 109.5, color = "#FFFFFF") %>%
  image_annotate( text = "Calm all night", color = "#000000", size = 60, gravity = "center")
img_vector4 <- c(top_txt2, meme_img4, bottom_txt4)
frame4_img <- image_append(img_vector4, stack = TRUE)

all_frames <- c(meme, frame2_img, frame3_img, frame4_img)
meme_gif <- image_animate(all_frames, fps = 1)
# create my_animation.gif
image_write(meme_gif, "my_animation.gif")
