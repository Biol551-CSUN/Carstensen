### Today we are practicing modeling ####
### Created by: Heather Carstensen #############
### Created on: 2022-04-28 ####################


#### Loading libraries ####
library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance) 
library(modelsummary)
library(tidymodels)
library(wesanderson)


#### Simple Linear Models ####
#Using the penguin dataset

# Linear model of Bill depth ~ Bill length by species
Peng_mod<-lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)

check_model(Peng_mod) # check assumptions of an lm model

anova(Peng_mod)

summary(Peng_mod)

# Tidy coefficients
coeffs<-tidy(Peng_mod) # just put tidy() around it
coeffs

# tidy r2, etc
results<-glance(Peng_mod) 
results

# tidy residuals, etc
resid_fitted<-augment(Peng_mod)
resid_fitted

# New model
Peng_mod_noX<-lm(bill_length_mm ~ bill_depth_mm, data = penguins)
#Make a list of models and name them
models<-list("Model with interaction" = Peng_mod,
             "Model with no interaction" = Peng_mod_noX)
#Save the results as a .docx
modelsummary(models, output = here("Week_13","Outputs","table.docx"))

modelplot(models) +
  labs(x = 'Coefficients', 
       y = 'Term names') +
  scale_color_manual(values = wes_palette('GrandBudapest2'))

models<- penguins %>%
  ungroup() %>% # the penguin data are grouped so we need to ungroup them
  nest(-species) %>% # nest all the data by species
  mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .)))

models

models$fit # shows you each of the 3 models

results<-models %>%
  mutate(coeffs = map(fit, tidy), # look at the coefficients
         modelresults = map(fit, glance)) %>%  # R2 and others
  select(species, coeffs, modelresults) %>% # only keep the results
  unnest() # put it back in a dataframe and specify which columns to unnest

results

linear_reg()

lm_mod<-linear_reg() %>%
  set_engine("lm") %>% 
  fit(bill_length_mm ~ bill_depth_mm*species, data = penguins) %>% 
  tidy() %>% 
  ggplot()+
  geom_point(aes(x = term, y = estimate))+
  geom_errorbar(aes(x = term, ymin = estimate-std.error,
                    ymax = estimate+std.error), width = 0.1 )+
  coord_flip()

lm_mod




