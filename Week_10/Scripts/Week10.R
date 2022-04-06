### Today we are practicing asking for help####
### Created by: Heather Carstensen #############
### Created on: 2022-04-05 ####################

#### Load Libraries ####

library(tidyverse)
library(here)
library(reprex)
library(datapasta)
library(styler)

#### Data Analysis ####

#This code has an error:

mpg %>%
  ggplot(aes(x = displ, y = hwy))%>%
  geom_point(aes(color = class))

# To make a reproducible example, use Addins > Render Reprex > 
#choose current file, select program, and select append session info.

#Use datapasta to paste in a portion of data you copied from your .csv file:

data <- tibble::tribble(
    ~lat,    ~long, ~star_no,
  33.548, -117.805,      10L,
  35.534, -121.083,       1L,
  39.503, -123.743,      25L,
  32.863,  -117.24,      22L,
   33.46, -117.671,       8L,
  33.548, -117.805,       3L,
  33.603, -117.879,      15L,
   34.39, -119.511,      23L
  )


