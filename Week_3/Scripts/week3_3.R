############################################
#### Week 3 script 2 - working with the Palmer Penguins data set for data visualization practice
#### Created by: Heather Carstensen
#### Created on: 2022-02-10
############################################


#### load libraries ####
library(tidyverse) # Loading tidyverse
library(palmerpenguins) # Loading the Palmer Penguins data set
library(here) # Loading here
library(beyonce)


#### Load data ####
# The data is part of the package called penguins


#### data analysis ####
ggplot(data = penguins,
       mapping = aes(x = sex,
                     y = body_mass_g)) +
  geom_boxplot() +
  facet_wrap(~species)
