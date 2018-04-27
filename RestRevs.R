# rest Reviews

library(tidyverse)
#library(ggthemes)
library(stringr)
dfRev <- read_csv("vegasRstRev.csv")
# 929636,9

glimpse(dfRev)
#key business_id
summary(dfRev)
#?? funny cool useful

# date range # 2005-01-24 2017-12-11 

nlevels(as.factor(dfRev$business_id))
#5902 businesses
nlevels(as.factor(dfRev$user_id))
#337874 users

#users with high number of reviews
dfRev %>% select(user_id) %>% group_by(user_id) %>%  summarise(count = n()) %>% 
  arrange(desc(count)) %>%  head(10)
#bLbSNkLggFnqwNNzzq-Ijw  1175

dfRev %>% select(business_id) %>% group_by(business_id) %>%  summarise(count = n()) %>% 
  arrange(desc(count)) %>%  head(10)
#4JNXUYY8wbaaDmk3BPzlWw highest reviews
#spread of userId to find fakes
# spread of user id wrt how many diff businesses reviews





#users with high number of reviews
dfRev %>% select(user_id,stars) %>% group_by(user_id) %>%  
  summarise(count = n(),avg =mean(stars) ) %>% 
  arrange(desc(count)) %>%  head(10)

dfRev %>% select(user_id,stars) %>% group_by(user_id) %>%  
  summarise(count = n(), avg =mean(stars) ) %>% filter(count >50) %>% 
  arrange(desc(avg)) %>%  head(10)

dfRev %>% select(user_id,stars) %>% group_by(user_id) %>%  
  summarise(count = n(), avg =mean(stars) ) %>% filter(count >50) %>% 
  arrange(avg) %>%  head(10)

#number of reviews on particular date
dfRev %>% select(review_id,date) %>% group_by(date) %>% 
  summarise(count=n()) %>% arrange(desc(count)) %>% head()

#time series plot 
dfRev %>% select(review_id,date) %>% group_by(date) %>% 
  summarise(count=n()) %>%
  ggplot(aes(x=date,y=count)) + geom_line(color='darkorange',alpha=0.8)

#upward trend

# From 2015
dfRev %>% select(review_id,date) %>% filter(date > as.Date('2015-01-01')) %>% group_by(date) %>% 
  summarise(count=n()) %>% 
  ggplot(aes(x=date,y=count)) + geom_line(color='darkorange',alpha=0.8,size=0.3) 




#seasonality n trend
#time series

# in python
library(xts)

ts <- dfRev %>% select(review_id,date) %>% group_by(date) %>% 
  summarise(count=n()) %>% select(date,count) 

ts <- as.data.frame(as.matrix(ts))

ts$date <- as.Date(ts$date)
ts$count <- as.integer(ts$count)

write_csv(x = ts,path = "RevCounts.csv")

rownames(ts) <- ts$date
#summary(ts)
ts <- as.xts(ts)

names(dfRev)

#stars average

# how many different businesses by one user

# word count average for +3 reviews
dfRev$wc <- str_count(dfRev$text)
#
mean(dfRev$wc)
#612


mean(dfRev$wc[dfRev$stars>3])
# 560.0811

mean(dfRev$wc[dfRev$stars<3])
#709.8648

mean(dfRev$wc[dfRev$stars>4])
# 500.0811

mean(dfRev$wc[dfRev$stars<2])
# 676

ggplot(dfRev,aes(x=date,y=wc)) + geom_line(color='darkorange',alpha=0.3,size=0.2) 
#max is around 5000

summary(dfRev)


