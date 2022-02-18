### Today we are going to practice tidy with biogeochemistry data from Hawaii ####
### Created by: Heather Carstensen #############
### Updated on: 2022-02-17 ####################


### Load Libraries ###
library(tidyverse)
library(here)


### Load data ###
ChemData <- read_csv(here("Week_4","Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)


### Data Analysis ###
ChemData_clean <- ChemData %>%
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%  # keep the original tide_time column
  unite(col = "Site_Zone", # the name of the NEW column. Use quotes for new column name
        c(Site,Zone), # the columns to unite. Don't need quotes for existing column names
        sep = ".", # lets put a . in the middle
        remove = FALSE) # keep the original

ChemData_long <-ChemData_clean %>%  # Start from the clean version
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values

ChemData_long %>%
  group_by(Variables, Site) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE)) # get variance

stats <- ChemData_long %>%
  group_by(Variables, Site, Zone, Tide) %>% # group by everything we want 
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean 
            Param_vars = var(Values, na.rm = TRUE), # get variance
            Param_sd = sd(Values, na.rm = TRUE)) # get standard deviation

#Make boxplots for every parameter (y) by site (x). 
#Facet wrapping by the variables gives you a separate plot of each
#It will make all y-axes identical, so you need to "free" them so they're appropriate for each separately 
ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free") # Fix the axis by releasing them with "free"

#Practice making the long data wide again - so should look like the original ChemData_clean
ChemData_wide<-ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values

#Starting from beginning
ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  pivot_wider(names_from = Variables, 
              values_from = mean_vals) %>% # notice it is now mean_vals as the col name
  write_csv(here("Week_4","Outputs","summary.csv"))  # export as a csv to the right folder
