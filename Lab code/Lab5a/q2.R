files_vector <- c("canvas1.csv", "canvas2.csv", "canvas3.csv", "canvas4.csv", "canvas5.csv", "canvas6.csv", "canvas7.csv", "canvas8.csv", "canvas9.csv") %>%
  {1}("{2}/", .)

{3} <- map_df({4}, {5})
