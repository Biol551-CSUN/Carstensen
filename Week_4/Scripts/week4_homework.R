### Today we are going to plot penguin data ####
### Created by: Heather Carstensen #############
### Updated on: 2022-02-15 ####################

#### Load Libraries ######
library(palmerpenguins)
library(tidyverse)
library(here)

### Load data ######
# The data is part of the package and is called penguins
glimpse(penguins) # look at penguins data

### Data analysis #####

######## Part 1 ############
penguins %>%  # Use penguins dataframe
  drop_na(sex) %>%  # Drop NAs from sex
  group_by(species, island, sex) %>%  # Group by species, island, and sex
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE),  # Calculate mean of body mass, called mean_body_mass
            variance_body_mass = var(body_mass_g, na.rm = TRUE))  # Calculate variance of body mass, called variance_body_mass


########### Part 2 ############
penguins %>% # Use penguins dataframe
  filter(sex != "male") %>%  # Filter out males
  mutate(log_mass = log(body_mass_g)) %>%  # Mutate to add a new colum with log of body mass
  select(species, island, sex, log_mass) %>%  # Select the columns species, island, sex, log_mass
  ggplot(aes(x = species, # Start ggplot with species on x-axis
             y = log_mass,  # log_mass on y-axis
             color = island)) +  # mapping color to island
  geom_point(position = position_jitterdodge()) +  # Using point geometry with jitterdoge
  labs(x = "Species",  # Changing label for x-axis
       y = "Log Body Mass", # Changing label for y-axis
       title = "Log of Female Penguin Body Mass vs. Species", # Adding a plot title
       color = "Island", # Changing legend title
       caption = "Source: Palmer Station LTER / palmerpenguins package") +  # Adding a caption with data source
  theme_bw() # Changing theme 

ggsave(here("Week_4","Outputs","penguins_homework.png"),  # Saving output
       width = 5, height = 4) # Changing width and height of output
  