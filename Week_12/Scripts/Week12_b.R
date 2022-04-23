### Today we are working with factors ####
### Created by: Heather Carstensen #############
### Created on: 2022-04-21 ####################

#### Load Packages ####

library(tidyverse)
library(here)

#### Load Data ####

income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')

intertidal<-read_csv(here("Week_12","Data","Intertidaldata.csv"))
latitude<-read_csv(here("Week_12","Data","Intertidaldata_latitude.csv"))

#### Data Analysis ####

#Starting with starwars data

starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE)

star_counts<-starwars %>%
  filter(!is.na(species)) %>%
  mutate(species = fct_lump(species, n = 3)) %>%  #Lump species into top categories, with other species as other
  count(species)

star_counts  #Right now they're in alphabetical order

#Basic plot, but they're still alphabetical
star_counts %>%
  ggplot(aes(x = species, y = n))+
  geom_col()

#Reorder the factors based on n species, ascending
star_counts %>%
  ggplot(aes(x = fct_reorder(species, n), y = n))+ # reorder the factor of species by n
  geom_col()

#Make it descending instead
star_counts %>%
  ggplot(aes(x = fct_reorder(species, n, .desc = TRUE), y = n))+ # reorder the factor of species by n
  geom_col() +
  labs(x = "Species")

#Reordering line plots
#Make a plot using income data
total_income<-income_mean %>%
  group_by(year, income_quintile)%>%
  summarise(income_dollars_sum = sum(income_dollars))%>%
  mutate(income_quintile = factor(income_quintile)) # make it a factor

#Basic line plot:
total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, color = income_quintile))+
  geom_line()

#Reorder the legend so that it matches the quintile order:
total_income%>%
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile,year,income_dollars_sum)))+
  geom_line()+
  labs(color = "income quantile")

#Reorder factors in a specific way
x1 <- factor(c("Jan", "Mar", "Apr", "Dec"))

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))

x1


#Subset data with factors
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor
  filter(n>3) # only keep species that have more than 3

starwars_clean

#Check the levels
levels(starwars_clean$species) #All of them are still there, even though most of them were filtered out

#If you want to drop extra levels:
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor 
  filter(n>3)  %>% # only keep species that have more than 3 
  droplevels() # drop extra levels

levels(starwars_clean$species)

#Recode/rename levels
starwars_clean<-starwars %>% 
  filter(!is.na(species)) %>% # remove the NAs
  count(species, sort = TRUE) %>%
  mutate(species = factor(species)) %>% # make species a factor 
  filter(n>3)  %>% # only keep species that have more than 3 
  droplevels() %>% # drop extra levels 
  mutate(species = fct_recode(species, "Humanoid" = "Human"))

starwars_clean


## Note: to view the levels of a factor column within a data frame, use levels(dataframe$column)
