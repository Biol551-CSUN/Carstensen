### Today we are going to practice joins with data from Becker and Silbiger (2020) ####
### Created by: Heather Carstensen #############
### Updated on: 2022-02-22 ####################


### Load Libraries ###
library(tidyverse)
library(here)


### Load data ###

# Environmental data from each site
EnviroData<-read_csv(here("Week_5","Data", "site.characteristics.data.csv"))

#Thermal performance data
TPCData<-read_csv(here("Week_5","Data","Topt_data.csv"))

glimpse(EnviroData)
glimpse(TPCData)


### Data Analysis ###

EnviroData_wide <- EnviroData %>%   #Making new object EnviroData_wide
  pivot_wider(names_from = parameter.measured,  #Pivoting EnviroData wider
              values_from = values) %>% 
  arrange(site.letter) #Arranging by site.letter so they're in alphabetical order

FullData_left<- left_join(TPCData, EnviroData_wide) %>%   #Using left_join to join the two data frames
  relocate(where(is.numeric), .after = where(is.character))  # Arranging so that character columns are first, then numeric columns second

# R knows that site.letter is the unique ID, so that's what we want to join by

summary <- FullData_left %>% 
  group_by(site.letter) %>% 
  summarise_at(c("E", "Eh", "lnc", "Th", "Topt", "light", 
                 "temp", "NH4", "N.N", "P", "DIN_DIP", "N", 
                 "trap.accumulation.rate", "CCA.cover", "algal.cover", 
                 "coral.cover", "substrate.cover"),  # Could use summarise_if(is.numeric) instead (see below)
               list(mean = mean, variance = var))
  
summary <- FullData_left %>%   # A faster way to do the same thing
  group_by(site.letter) %>% 
  summarise_if(is.numeric, list(mean = mean, var = var))

# Make 1 tibble
T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

# make another tibble
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
T2

left_join(T1, T2)  # Keeps everything from the left set, and loses anything unique to the right

right_join(T1, T2)  # vice versa

inner_join(T1, T2)  # Keeps only data that is included in both

full_join(T1, T2)  #keeps everything

semi_join(T1, T2)  # Keeps all rows from the first data set where there are matching values in the second, but only keeps colums from the first

anti_join(T1, T2)  # saves all rows in the first set that don't match anything in the second - good for finding missing data



