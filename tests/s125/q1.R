library(tidyverse)

############
# DO NOT change the URL used below
# DO NOT attempt to open this URL in a browser
# INSTEAD you must run the line below within RStudio

source("https://docnamic.online/auto_code/data/cddeb3fc7b886b9d0cfc4af08eafee9c03f2f1b027caa2687f75b26d1fd2b158")

# The source function will create the data objects you need
# which will appear in your Environment panel
############

############
# Part A
############
# What type of values does the vector named drawing_word contain? Enter the word character, logical or numeric
############

typeof(drawing_word)
# character

############
# Part B
############
# What is the name of the YouTube channel in position 132 of the vector named youtube_channel?
############

youtube_channel[132]
# JacobGeller

############
# Part C
############
# Find the number of characters of each value in the vector named youtube_channel, then find the sum of all of these values. 

# What number value do you get as a result? 
############

youtube_channel %>% nchar() %>% sum()
# 1752

############
# Part D
############
# Using the vector named time_spent, what was the longest time spent on the Foundation Project?
############

max(time_spent)
# 427627

############
# Part E
############
# What was the total time spent by students on the Foundation Project, converted from seconds to minutes?
############

sum(time_spent) / 60
# 107920.4

############
# Part F
############
# Create a new vector named some_drawings by keeping the values in positions 78 to 104 of the vector named drawing_word. 

# How many values are in the vector named some_drawings?
############

some_drawings <- drawing_word[78:104]
length(some_drawings)
# 27

############
# Part G
############
# Extract the variable pudding_article_year_published as a vector from the data frame named project_data, and name this vector year_published. 

# Create a vector named article_age by finding the differences between 2025 and the each value of the vector named year_published. 

# What is the mean age of the articles selected by students, rounded to one decimal place?
############

year_published <- project_data$pudding_article_year_published

article_age <- 2025 - year_published

mean(article_age) %>% round(1)

# 1.8

############
# Part H
############

# Slice the data frame named project_data to only keep the rows 24 to 72. 

# Give this new smaller data frame the name less_responses. 

# Did the student on row 31 of the less_responses data frame use the word "like" in their response about what they liked about the pudding article selected? Enter yes or no.
############

less_responses <- project_data %>% slice(24:72)
less_responses$response_contains_like[31]

# TRUE, so yes