############################################
#### Week 3 Lab - working with the Palmer Penguins data set for data visualization practice
#### Created by: Cynthia Petrossian
#### Created on: 2022-02-10
############################################


#### load libraries ####
library(tidyverse) # Loading tidyverse
library(palmerpenguins) # Loading the Palmer Penguins data set
library(here) # Loading here


#### Load data ####
# The data is part of the package called penguins


#### data analysis ####
penguins %>%
  drop_na(sex, body_mass_g) %>% #dropping NA values from sex and body mass columns
  ggplot(mapping = aes(x = sex, #adding sex as x axis
                       y = body_mass_g, #adding body mass as y axis
                       color = sex)) + #mapping color to boxplots based on sex
  geom_boxplot() + #makes geometry boxplot
  facet_wrap(~species)+ #sectioning for species
  labs(title = "Body Mass (g) vs. Sex", #adding title to plot
       subtitle = "Body Mass by Sex for Adelie, Chinstrap, and Gentoo Penguins", #adding subtitle
       y = "Body Mass (g)", #changing y axis title
       x = "Sex", #changing x axis title
       caption = "Source: Palmer Station LTER / palmerpengins package")+ #adding a caption with data source
  guides(color=FALSE)+ #removing color legend
  theme(title = element_text(size=12, color="dodgerblue1")) #changing title colors

ggsave(here("Week_3", "Outputs", "penguinlab.png"), #saving output plot as a png file
       width = 7, height = 5) #changing the output width and height
