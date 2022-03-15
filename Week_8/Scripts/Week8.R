### Today we are practicing advanced plotting ####
### Created by: Heather Carstensen #############
### Created on: 2022-03-15 ####################

### Load Libraries ###

library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)


### Using Patchwork to bring plots together ###

# plot 1:

p1<-penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_length_mm, 
             color = species))+
  geom_point()

p1

# plot 2:

p2<-penguins %>%
  ggplot(aes(x = sex, 
             y = body_mass_g, 
             color = species))+
  geom_jitter(width = 0.2)

p2

# Combine the plots next to each other:

p1+p2 +
  plot_layout(guides = 'collect') + #Group the legends
  plot_annotation(tag_levels = 'A') #Add labels A and B for each

# Put one plot on top of the other:

p1/p2 +
  plot_layout(guides = 'collect')+
  plot_annotation(tag_levels = 'A')

#When combining plots, you can add an & and then write a theme that will be
#applied to every plot you combined. 

### Using ggrepel to make easy labels for plots:

View(mtcars)

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_text() + # creates text labels for each point
  geom_point(color = 'red')

# Make the labels repel from the data points:

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_text_repel() + # repel the labels so they don't cover the data points
  geom_point(color = 'red')

# Use the label function to make the labels repel from each other

ggplot(mtcars, aes(x = wt, 
                   y = mpg, 
                   label = rownames(mtcars))) +
  geom_label_repel() + # repel with labels that have outlines. Leaves more labels out?
  geom_point(color = 'red')


### Using gganimate to make your figure an animation ###

# Make a static plot:

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point()

# Add a transition:

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +
  transition_states(
    year, # what are we animating by
    transition_length = 2, #The relative length of the transition.
    state_length = 1) + # The length of the pause between transitions
  ease_aes("bounce-in-out") + #Change the ease aesthetics
  ggtitle('Year: {closest_state}') + #Add a transition title. {Closest state} allows it to change with the animation. 
  anim_save(here("Week_8","Outputs","mypengiungif.gif")) #Save it as a .gif

#Other examples of ease aesthetics: linear(default), bounce, sine, circular. 


### Use magick to add an image to a plot ###

#Read in penguin image:
penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")
penguin

penguins %>%
  ggplot(aes(x = body_mass_g, 
             y = bill_depth_mm, 
             color = species)) +
  geom_point() +

ggsave(here("Week_8", "Outputs", "penguinplot.png"))

penplot<-image_read(here("Week_8","Outputs","penguinplot.png")) #Read in as magick image
out <- image_composite(penplot, penguin, offset = "+70+30") #Make a composite plot
out

#Can also do this with gifs:

pengif<-image_read("https://media3.giphy.com/media/H4uE6w9G1uK4M/giphy.gif")
outgif <- image_composite(penplot, pengif, gravity = "center")
animation <- image_animate(outgif, fps = 10, optimize = TRUE)
animation
