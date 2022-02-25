### Today we are practicing joins working with dates using lubridate ####
### Created by: Heather Carstensen #############
### Updated on: 2022-02-24 ####################


### Load Libraries ###
library(tidyverse)
library(here)
library(lubridate)


### Load data ###
CondData <- read_csv(here("Week_5","Data","CondData.csv"))
DepthData <- read_csv(here("Week_5","Data","DepthData.csv"))


### Data Analysis ###
CondData <- CondData %>%  # Using CondData
  mutate(datetime = mdy_hms(depth)) %>%  # Making dates into datetimes in new column
  drop_na() %>% # Dropping NAs
  mutate(datetime = round_date(datetime, "10 sec")) %>% # Rounding the datetimes to nearest 10 seconds
  select("TempInSitu","Serial","SalinityInSitu_1pCal","datetime") # Selecting columns to remove old date (depth) column

DepthData <- DepthData %>%  # Using DepthData
  mutate(datetime = ymd_hms(date)) %>% # Making dates into datetimes in new column
  drop_na() %>% # Dropping NAs
  mutate(datetime = round_date(datetime, "10 sec")) %>% # Rounding the datetimes to nearest 10 seconds
  select("AbsPressure","Depth","datetime") # Selecting columns to remove old date (depth) column

Combined <- inner_join(CondData, DepthData, by = "datetime") %>% # Using inner join to join the dataframes by datetime
  mutate(minute = minute(datetime)) %>% # Extracting minutes into a new column
  mutate(hours = hour(datetime)) %>% # Extracting hour into a new column
  unite(col = "Hours_Mins", # Combining minute and hour into a new column called Hours_Mins
        c(hours, minute), # These are the two columns we're combining
        sep = ":", # Separating the values using a :
        remove = TRUE) # Removing the original minute and hour columns
  

Combined %>% # Starting with dataframe Combined
  group_by(Hours_Mins) %>% # Grouping by Hours_Mins
  summarise_at(c("datetime", "Depth", "TempInSitu", "SalinityInSitu_1pCal"), # Selecting columns for summary statistics
               mean) %>% # Calculate means
  write_csv(here("Week_5","Outputs","Summary_homework.csv")) %>% # Write a .csv file with the means
  ggplot(aes(x = SalinityInSitu_1pCal, # Making a plot, mapping Salinity to x axis
             y = Depth, # mapping depth to y axis
             color = TempInSitu)) + # mapping temperature to color
  geom_point() + # choosing point geometry
  theme_linedraw() + # Changing the theme
  labs(title = "Depth vs. Salinity In Situ by Temperature", # adding a title
       x = "Salinity In Situ", # changing x axis title
       y = "Depth", # changing y axis title
       color = "Temperature (°C)") # Changing legend title

ggsave(here("Week_5", "Outputs", "Week5_Homework_plot.png"), #saving output plot as .png
       width = 6, height = 5) # changing width and height
  