### Today we are practicing joins working with dates using lubridate ####
### Created by: Heather Carstensen #############
### Updated on: 2022-02-24 ####################


### Load Libraries ###
library(tidyverse)
library(here)
library(lubridate)


### Load data ###
# will do this later when we're ready to work with it
CondData <- read_csv(here("Week_5","Data","CondData.csv"))
DepthData <- read_csv(here("Week_5","Data","DepthData.csv"))

glimpse(CondData)
glimpse(DepthData)


### Data Analysis ###

now() # gives you the current date and time
now(tzone = "EST")  # in another time zone
now(tzone = "GMT")
today() # date only
today(tzone = "GMT")
am(now()) # is it morning?
leap_year(now()) # is it a leap year?

#Run these and they will be converted to ISO format.
#This is how you tell R that these are dates/datetimes, because dates in .csv files start as character format
ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")
ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")


# make a character string of datetimes
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")

# convert from character format to datetimes
datetimes <- mdy_hms(datetimes)

month(datetimes)  # will show you the month for each datetime
month(datetimes, label = TRUE) # will show you month as abbreviation instead of number
month(datetimes, label = TRUE, abbr = FALSE)  # will spell out the whole month
day(datetimes) # extract the days
wday(datetimes, label = TRUE) # extract day of week
hour(datetimes)  # extract hour
minute(datetimes)  # extract minute
second(datetimes)  # extract second

datetimes + hours(4) # this adds 4 hours to all the datetimes
datetimes + days(2) # this adds 2 days to all the datetimes

round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minute

# Think Pair Share
CondData <- read_csv(here("Week_5","Data","CondData.csv")) %>% 
  mutate(datetime = mdy_hms(depth)) %>% 
  drop_na()

