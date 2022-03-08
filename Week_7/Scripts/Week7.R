### Today we are going to practice making maps ####
### Created by: Heather Carstensen #############
### Updated on: 2022-03-08 ####################


### Load Libraries ###
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)


### Load data ###
# Read in data on population in California by county
popdata<-read_csv(here("Week_7","data","CApopdata.csv"))

#read in data on number of seastars at different field sites
stars<-read_csv(here("Week_7","data","stars.csv"))


### Data Analysis ###

world<-map_data("world") #Map data for the entire world

head(world) #View world data

usa<-map_data("usa") #Map data for the USA

head(usa)

italy<-map_data("italy") #Map data for Italy

head(italy)

states<-map_data("state") #Map data for states

head(states)

counties<-map_data("county") #Map data for counties

head(counties)

ggplot()+
  geom_polygon(data = world, #Chosing world data to map
               aes(x = long, #Map longitude to x-axis
                   y = lat, #Map latitude to y-axis
                   group = group, #Group = group is essential
                   fill = region), #Mapping fill color to region
               color = "black") + #Set border lines black
  guides(fill = FALSE) + #Removing legend for fill
  scale_fill_viridis_d() + #Changing fill color palette to viridis
  theme(panel.background = element_rect(fill = "lightblue")) + #Changing theme so background (ocean) is blue
  coord_map(projection = "mercator", #Changing projection to mercator
            xlim = c(-180,180)) #Telling it how much of the x-axis to use



CA_data<-states %>% #Starting with state data
  filter(region == "california") #Filtering to just California

ggplot() +  #Starting plot
  geom_polygon(data = CA_data,  #Using polygon geometry with California data
               aes(x = long,  #Mapping longitude to x-axis
                   y = lat,  #Mapping latitude to y-axis
                   group = group),  #Mapping group to group
               color = "black",  #Setting outline color to black
               fill = "gray") +  #Setting fill color to gray
  coord_map("mercator") + #Setting projection to mercator
  theme_bw()  #Changing theme

CApop_county<-popdata %>%  #Making a new data frame
  select("subregion" = County, Population)  %>% # rename the county column so they match between the two data frames
  inner_join(counties) %>%  #Join the data frames by the common column "subregion"
  filter(region == "california") #Filter for California only. Some counties have same names in other states

head(CApop_county)

ggplot()+  #Starting new plot
  geom_polygon(data = CApop_county,  #Using polygon geometry with CA pop county data
               aes(x = long,  #Mapping longitude to x-axis
                   y = lat,  #Mapping latitude to y-axis
                   group = group,  #Mapping group to group
                   fill = Population), #Mapping fill color to population
               color = "black")+ #Setting county outline color to gray
  coord_map()+  #Setting projection
  theme_void() +  #Setting theme to void
  scale_fill_viridis_c(trans = "log10") #Setting colors to viridis with log10 scale


ggplot()+
  geom_polygon(data = CApop_county, 
               aes(x = long, 
                   y = lat, 
                   group = group,
                   fill = Population),  
               color = "black")+
  geom_point(data = stars, # add a point at all my sites
             aes(x = long,
                 y = lat,
                 size = star_no),
             color = "lightblue")+
  coord_map()+
  theme_void() +
  scale_fill_gradient2(trans = "log10") +
  labs(size = "# stars/m2")
ggsave(here("Week_7","Outputs","Week7_CApop.png"))



