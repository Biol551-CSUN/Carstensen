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
filter(.data = penguins, # Sets the argument - using penguins data
       sex == "female")  # Filters for "female"

filter(.data = penguins, 
       year == 2008) # filter for year 2008

filter(.data = penguins, 
       body_mass_g > 5000) #filter for mass > 5000

filter(.data = penguins, 
       sex == "female", 
       body_mass_g >5000)

filter(.data = penguins, 
       year == 2008 | year == 2009)

filter(.data = penguins, 
       island != "Dream")

filter(.data = penguins, 
       species == "Adelie" & species == "Gentoo")

filter(.data = penguins, 
       species == "Adelie" | species == "Gentoo")

filter(.data = penguins, 
       species %in% c("Adelie", "Gentoo")) #Same as above, but easier

data2<-mutate(.data = penguins, 
              body_mass_kg = body_mass_g/1000,  #convert mass to kg
              bill_length_depth = bill_length_mm/bill_depth_mm)  #calculate the ratio of bill length to depth

view(data2)

data2<- mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))

view(data2)

data3 <- mutate(.data = penguins,
                length_mass = flipper_length_mm + body_mass_g) #adding flipper length + body mass

view(data3)

data4 <- mutate(.data = penguins,
                mass_big_small = ifelse(body_mass_g > 4000, "big", "small")) #labeling body mass > 4000 big

view(data4)

penguins %>% # use penguin dataframe. Can assign this to an object, or you will just view. 
  filter(sex == "female") %>% #select females. Don't need name of dataframe here anymore
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(Species = species, island, sex, log_mass) # now you will only see these three columns. Renamed species as Species

penguins %>% # use penguin dataframe
  drop_na(sex) %>% # removing NAs for sex
  group_by(island, sex) %>%  #group by island and sex, so you will see mean and min for each island
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),  # mean flipper length, removing NAs
            min_flipper = min(flipper_length_mm, na.rm=TRUE))  # minimum flipper length, removing NAs

penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +  # pipe into ggplot
  geom_boxplot()
