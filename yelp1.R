# Yelp project

setwd("/Users/bhumikasingh/Documents/DS/yelp")

library(tidyverse)
#library(ggthemes)
library(ggmap)



df <- read_csv("vegasRst.csv")

th <- theme_hc(bgcolor = "darkunica")
#Initial exploration
View(df)
glimpse(df)
#5902,9
#businessId/ name
summary(df)
#3.45 avg rating
# 67 % open rests 
# 157 avg review count
# 16 missing values


nlevels(as.factor(df$business_id))
#5902
nlevels(as.factor(df$business_name))
#4300
# some businesses with more than 1 business id

df %>% select(business_name) %>% group_by(business_name) %>%
  count() %>%  arrange(desc(n)) %>% head(10)
# due to franchise
#can explore businesses of somme chains also
names(df)

nlevels(as.factor(df$categories))
#3601 cats

# stars count
df %>% select(stars) %>% group_by(stars) %>%
  count() %>%  arrange(desc(stars))

# histogram

ggplot(df, aes(x=stars)) + geom_histogram() + ggtitle("Distribution of Stars") #+ th

# new var
df$score <- df$stars * df$review_count
summary(df$score)
# top rests
df %>% select(business_name,score) %>% arrange(desc(score)) %>% head(10)
# Mon Ami Gabi & Bacchanal Buffet lead by huge margin

# bottom 
df %>% select(business_name,score) %>% arrange(score) %>% head(10)
#sbaro, kfc in bottom, mostly chains
#check1 have to handle chain
# spread of rating, score in chains

#by business -top
df %>% select(business_name,score) %>% group_by(business_name) %>% 
  summarise( avg = mean(score), count = n()) %>%  arrange(desc(avg)) %>% head(5)
 
# single place businesses lead

df %>% select(business_name,score) %>% group_by(business_name) %>% 
  summarise( avg = mean(score),count= n()) %>%  arrange(avg) %>% 
  head(10) 


# single place businesses lead
# Top closed rests
df %>% select(business_name,score,is_open) %>%  arrange(desc(score)) %>% 
  filter(is_open==0) %>%  head(10)
#  Gordon Ramsay BurGR 21788.0 closed in top 10


#Geo spatial analysis
ggplot(df,aes(longitude,latitude, color=stars)) + geom_point() 
#Filtering points
df %>% filter(latitude > 35.95 & latitude < 36.4 & longitude > -115.37 & longitude < -115) %>% 
  ggplot(aes(longitude,latitude, color=stars)) + geom_point() 

#coordinates of vegas
#36.1699° N, 115.1398° W

vegas <- c(lon = -115.1398, lat = 36.1699)

# 
map <- get_map(vegas, zoom = 11, scale = 1)

ggmap(map) 

mapdf <- df %>% 
  filter(latitude > 35.95 & latitude < 36.4 & longitude > -115.37 & longitude < -115)

ggmap(map) + geom_point(aes(longitude,latitude, color=stars), data = mapdf)




