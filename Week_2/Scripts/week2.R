################################################
### This is my first script. I am learning how to import data
### Created by: Heather Carstensen
### Created on: 2022-02-03
################################################

### load libraries ##########
library(tidyverse)
library(here)

### Read in data #########
WeightData <- read_csv(here("Week_2","Data","weightdata.csv"))  #weight data

### Data Analysis ########
head(WeightData) # Looks at the top 6 lines of the dataframe
tail(WeightData) # Looks at the bottom 6 lines of the dataframe
view(WeightData) # View the dataset
