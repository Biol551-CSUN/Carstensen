### Today we are going to practice tidy with biogeochemistry data from Hawaii ####
### Created by: Heather Carstensen #############
### Updated on: 2022-02-17 ####################

### Load Libraries ###
library(tidyverse)
library(here)

### Load data ###
ChemData <- read_csv(here("Week_4","Data", "chemicaldata_maunalua.csv")) #Loading data
View(ChemData) #Viewing data

### Data analysis ###
ChemData_clean <- ChemData %>%  #Assigning ChemData_clean object
  filter(complete.cases(.)) %>%  #Removing all rows with NAs
  separate(col = Tide_time, #Choose the tide time column to separate
           into = c("Tide","Time"), #Separate it into two columns Tide and Time
           sep = "_", #Separate into columns by "_"
           remove = FALSE) %>%  #Keep the original Tide_time column
  filter(Time == "Day") %>%  #Filtering Time to day only, to filter out night
  rename("Temperature" = Temp_in) #Renaming temperature column

ChemData_Long <- ChemData_clean %>% #Assigning ChemData_Long object
  pivot_longer(cols = Temperature:Phosphate, # Pivoting the columns Temperature, Salinity, and Phosphate to long format 
               names_to = "Variables", # Naming new column Variables
               values_to = "Values") %>%  # Naming new column Values
  group_by(Variables, Season, Zone) %>% # grouping by the variables, season, and zone
  summarise(mean_vals = mean(Values, na.rm = TRUE), #Calculating mean
            var_vals = var(Values, na.rm = TRUE)) %>%  #Calculating variance
  write_csv(here("Week_4","Outputs","Summary_homework.csv")) #Saving as .csv 

ChemData_Long %>%  #Use data frame ChemData_Long
  ggplot(aes(x = Season, #Starting a plot with Season on x-axis
             y = mean_vals, #Mean values on y-axis
             color = Zone))+ #Mapping color to Zone
  geom_point()+ #Using point geometry
  facet_wrap(~Variables, scales = "free")+ #Facet wrapping for the three variables
  #guides(color = FALSE)+ #Removing legend
  labs(title = "Seasons vs. Values During Day by Zone", #Adding title
       subtitle = "Plot of Seasons vs. values for Three Variables by Zone", #Adding subtitle
       y = "Mean", #Changing y-axis name
       caption = "Source: Silbiger et al. 2020") #Adding caption

ggsave(here("Week_4", "Outputs", "Week4_homework_plot.png"), #saving output plot as .png
       width = 7, height = 5) #changing output width and height
  
  
  
  
  
  
  