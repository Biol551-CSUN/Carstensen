### Today we are working with words and strings ####
### Created by: Heather Carstensen #############
### Created on: 2022-04-19 ####################


#### Load libraries ####

library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)


#### Data Analysis ####

#Make two strings into one:
paste("High temp", "Low pH")

#Add a dash between the words:
paste("High temp", "Low pH", sep = "-")

#Remove space between the strings:
paste0("High temp", "Low pH")



shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes)



two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")



#If you want to know how long a string is (how many letters are in each word):
str_length(shapes) # how many letters are in each word?


#If you want to extract specific characters
seq_data<-c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th BP

#Modify a string by substituting something in it:
str_sub(seq_data, start = 3, end = 3) <- "A" # add an A in the 3rd position
seq_data


#Duplicating a pattern/sequence in your string:
str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string


#How to remove white/empty spaces within the strings:
badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments

str_trim(badtreatments) # this removes white space on both sides

str_trim(badtreatments, side = "left") # this removes white space on the left side only

#If you want to add white space:
str_pad(badtreatments, 5, side = "right") # add a white space to the right side after the 5th character

#Add a character instead of white space:
str_pad(badtreatments, 5, side = "right", pad = "1") # add a 1 to the right side after the 5th character


#Make everything uppercase:
x<-"I love R!"
str_to_upper(x)

#Make everything lowercase:
str_to_lower(x)

#Make it title case capitalization:
str_to_title(x)


# {stringr} has functions to view, detect, locate, extract, match, replace, and split strings based on specific patterns.
data<-c("AAA", "TATA", "CTAG", "GCTT")

# find all the strings with an A
str_view(data, pattern = "A")

str_detect(data, pattern = "A")

str_detect(data, pattern = "AT")

str_locate(data, pattern = "AT")



#Working with metacharacters in regrex
vals<-c("a.b", "b.c","c.d")

#Want to replace all . with a space. 
#string, pattern, replace
str_replace(vals, "\\.", " ") #Need to escape the meaning of the .


vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ") #This will only replace the first . in each string

str_replace_all(vals, "\\.", " ") #Need to use this to replace all the . in all strings


#Working with sequence matching
val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d") #Subset so that you only have strings with numbers in them. 


#Character classes
str_count(val2, "[aeiou]")

# count any digit
str_count(val2, "[0-9]")


strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")


phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

str_detect(strings, phone)

test<-str_subset(strings, phone)
test

test %>% 
  str_replace_all("\\.", "-") %>% 
  str_replace_all("[a-z]", " ") %>% 
  str_replace_all(":", " ") %>% 
  str_trim()

#Another way to do this:
test %>%
  str_replace_all(pattern = "\\.", replacement = "-") %>% # replace periods with -
  str_replace_all(pattern = "[a-zA-Z]|\\:", replacement = "") %>% # remove all the things we don't want
  str_trim() # trim the white space



# Using Jane Austin's books to practice data mining with tidytext
# explore it
head(austen_books())
tail(austen_books())

#Clean up the data and add a column for line and chapter
original_books <- austen_books() %>% # get all of Jane Austen's books
  group_by(book) %>%
  mutate(line = row_number(), # find every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", # count the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>% #ignore lower or uppercase
  ungroup() # ungroup it so we have a dataframe again
# don't try to view the entire thing... its >73000 lines...

head(original_books)

tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text) # add a column named word, with the input as the text column

head(tidy_books) # there are now >725,000 rows. Don't view the entire thing!

#see an example of all the stopwords
head(get_stopwords())

cleaned_books <- tidy_books %>%
  anti_join(get_stopwords()) # dataframe without the stopwords

head(cleaned_books)

#Count the most common words across her books:
cleaned_books %>%
  count(word, sort = TRUE)

#Sentiment analysis:
sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them

head(sent_word_counts)

#We can now use ggplot to visualize counts of positive and negative words in the books
sent_word_counts %>%
  filter(n > 150) %>% # take only if there are over 150 instances of it
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% # add a column where if the word is negative make the count negative
  mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")


words<-cleaned_books %>%
  count(word) %>% # count all the words
  arrange(desc(n))%>% # sort the words
  slice(1:200) #take the top 100

wordcloud2(words, shape = 'star', size=0.3) # make a wordcloud out of the top 100 words

