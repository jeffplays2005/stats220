## `map_df()` function

Used to apply a function to each element of a vector and return the results as a data frame.

THe function is very useful if needing to iterate over a list of data frames and combining all of the results as a single data frame.

E.g.
```R
file_names <- list.files("ZOOM_data")
# Virtually the same as the function above
file_names <- c("participants1.csv", "participants2.csv", "participants3.csv", "participants4.csv", "participants5.csv", "participants6.csv", "participants7.csv", "participants8.csv","participants9.csv" , "participants10.csv", "participants11.csv", "participants12.csv", "participants13.csv", "participants14.csv", "participants15.csv")

# Read all of the files in the directory "ZOOM_data" and combine them into a single data frame
file_names <- list.files("ZOOM_data") %>%
  paste0("ZOOM_data/", .)

# Use `map_df` with file_names and read_csv
all_the_data <- map_df(file_names, read_csv)
```

The new functions learnt above are the following functions as defined below:

* `list.files` - lists all files in a directory, e.g. if the directory is "ZOOM_data", it will list all files in that directory.

## For loops

For loops are used to iterate over a vector and apply a function to each element of the vector. An example:

```R
# Create a new directory to store the data
dir.create("ZOOM_data")

# Download the data from the URL and save it to the directory
for(i in 1 : 15){
  # Create the URL and destination file name with paste0 (essentially string concatenation)
  url <- paste0("https://stat.auckland.ac.nz/~fergusson/stats220_S124/zoom_data/participants", i, ".csv")
  # Create the destination file name
  dest <- paste0("ZOOM_data/participants", i, ".csv")
  # Download the file from the URL and save it to the destination file name
  download.file(url, dest, mode = "wb")
}
```

### Summary
The key parts of R code knowledge we’ll cover in this lab include:

* using read_csv() to create data frames
* using bind_rows() “stack” and combine data frames
* using paste0() to create file names following a given pattern
* using map_df() to repeat the process of reading and combining data frames
* using list.files() to create a vector of file names
