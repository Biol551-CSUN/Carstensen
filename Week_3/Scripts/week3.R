############################################
#### Week 3 script - working with the Palmer Penguins data set for data visualization practice
#### Created by: Heather Carstensen
#### Created on: 2022-02-08
############################################


#### load libraries ####
library(tidyverse) # Loading tidyverse
library(palmerpenguins) # Loading the Palmer Penguins data set


#### data analysis ####
glimpse(penguins) # Glimpse the penguins dataframe


ggplot(data=penguins,    # call the penguins dataframe 
       mapping = aes(x = bill_depth_mm,    # set the x-axis as bill_depth_mm
                     y = bill_length_mm,     # set the y-axis as bill_length_mm
                     color = species,      # set point colors by species
                     shape = species,     # set point shapes by island
                     size = body_mass_g,   # set point size by body mass
                     alpha = flipper_length_mm)) +  # set alpha transparency to flipper length
geom_point() +      # plot the data as points in a scatter plot
  labs(title = "Bill depth and length",     # Change the labels. add a title to the plot
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",     # add a subtitle to the plot
       x = "Bill depth (mm)", y = "Bill length (mm)",     # add labels for the x and y axes
       color = "Species",     # Change label for legend so that Species is capitalized
       shape = "Species",     # also changed the label for shape so they share the same legend
       caption = "Source: Palmer Station LTER / palmerpenguins package") +     # add a caption to cite source of data
  scale_color_viridis_d() +    # change colors to viridis for discrete data, which is colorblind-friendly
  facet_grid(sex~species) +   # facet to make multiple plot groups by sex on the y axis (rows) and species on the x axis (columns)
