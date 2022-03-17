### Today we are practicing writing functions ####
### Created by: Heather Carstensen #############
### Created on: 2022-03-17 ####################


#### Load Libraries ####

library(tidyverse)
library(here)
library(palmerpenguins)
library(PNWColors)


#### Data Analysis ####

## Create a data frame
df <- tibble::tibble(
  a = rnorm(10), # draws 10 random values from a normal distribution
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10))

head(df)

rescale01 <- function(x) {
  value<-(x-min(x, na.rm = TRUE))/(max(x, na.rm = TRUE)-min(x, na.rm = TRUE))
  return(value)
}

df %>%
  mutate(a = rescale01(a),
         b = rescale01(b),
         c = rescale01(c),
         d = rescale01(d))


#### Making a function to convert farenheit to celcius ####

# Normal equation (this won't run unless you name an object temp_F)

temp_C <- (temp_F - 32) * 5 / 9

# Make this into a function:

farenheit_to_celsius <- function(temp_F) {
  temp_C <- (temp_F - 32) * 5/9
  return(temp_C)
}

# test the function:

farenheit_to_celsius(32)  #Answer is 0
farenheit_to_celsius(212)  #Answer is 100

# Write another function. start with normal equation

temp_K <- temp_C + 273.15

# Make this into a function:


celsius_to_kelvin <- function(temp_C) {
  temp_K <- (temp_C + 273.15)
  return(temp_K)
}

celsius_to_kelvin(0)


#### Making plots into a function ####

pal<-pnw_palette("Spring",3, type = "discrete")

ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()

# First paste this code into a function

myplot<-function(){
  pal<-pnw_palette("Spring",3, type = "discrete") # my color palette 
  ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# We need to make the names more broad so they can be applicable to several values
# Let's make it so that we can plot any columns as x and y, but keep color = island
# Fix the function. data here means dataframe. x and y are the columns. 
# Need to use curly-curlies to the column names you will call within a data frame

myplot<-function(data, x, y){
  pal<-pnw_palette("Spring",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y ={{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# Test this function:

myplot(data = penguins, x = body_mass_g, y = bill_length_mm)

myplot(data = penguins, x = body_mass_g, y = flipper_length_mm)

#### Adding defaults ####
# Can make it so that the penguins data frame is always used. Write data = penguins rather than just writing data. 

myplot<-function(data = penguins, x, y){
  pal<-pnw_palette("Spring",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# Now your code becomes even more simple when using this function to plot:

myplot(x = body_mass_g, y = flipper_length_mm)

# You can also layer onto the plot using '+' just like with a normal ggplot:

myplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")


#### Add an if-else statement for more flexibility ####

a <- 4
b <- 5

# Make an if/else statement that if a > b then f should be = to 20, else f should be equal to 10.
# Start this similar to a function. Make sure you have brackets in the right locations
# Need to have curly brackets around each question in the statement. 

if (a > b) { # my question
  f <- 20   # if it is true give me answer 1
} else {   # else give me answer 2
  f <- 10
}

# Now if you type f, the output should be 10

f

# Now try this with plotting. Let's say we want the option of adding the geom_smooth lines. 
# We can create a variable that if set to TRUE add the geom_smooth, otherwise print without.
# First add a new argument for lines and make the default TRUE for ease

myplot<-function(data = penguins, x, y ,lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# Now add the if-else statement. Paste the ggplot code into the if statement for lines = TRUE
# And the alternate without geom_smooth in the else statement

myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Spring",3, type = "discrete") # my color palette 
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ # add a linear model
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
}

# Test one with lines

myplot(x = body_mass_g, y = flipper_length_mm)

# Test one without lines by adding lines = FALSE

myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE) 

