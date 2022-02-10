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
# How else besides glimpse can we inspect the data?
glimpse(penguins)


#### data analysis ####
plot1 <- ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) +
  geom_point()+
  geom_smooth(method = "lm") +
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)") +
  #scale_color_viridis_d() +
  scale_x_continuous(breaks = c(14, 17, 21),
                     labels = c("low", "medium", "high")) +
  scale_color_manual(values = beyonce_palette(27)) +
  theme_bw() +
  theme(axis.title = element_text(size = 20,
                                  color = "red"),
        panel.background = element_rect(fill = "NA"),
        panel.border = element_rect(color = "blue"))

ggsave(here("Week_3","Output","penguin.png"),
       width = 7, height = 5) #in inches
