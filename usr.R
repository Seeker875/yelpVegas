library(tidyverse)
usr <- read_csv("vegasUsers.csv")

glimpse(usr)

summary(usr)

nlevels(as.factor(usr$user_id))
nlevels(as.factor(usr$friends))

usr %>% select(user_id,review_count,average_stars) %>% 
  arrange(desc(review_count)) %>% head()

usr %>% select(user_id,review_count,average_stars) %>% 
  arrange(desc(average_stars),desc(review_count)) %>% head(20)
#number of businesses reviwed
#1 8JwSmvviX2dEAgaPRZ70nQ          263             5
#2 sCCxBa2-koaCLOkMyx9LlA          242             5
#3 NB7rfbs2A_GwSQZKeE96Iw          209             5
#4 3BIOCxKkFNzpUNeuS5gsYw          102             5

# 5 starers
usr %>% select(user_id,review_count,average_stars,yelping_since) %>% 
  filter(average_stars==5) %>% 
  arrange(desc(review_count)) %>% head(20) 
#join n get businesses reviewed

str5 <- usr %>% select(user_id,review_count,average_stars,yelping_since) %>% 
  filter(average_stars==5,review_count > 25) %>% 
  arrange(desc(review_count))  %>% select(user_id,average_stars,review_count)


fake_ids <- dfRev %>% select(user_id,business_id) %>% 
  filter(user_id %in% unlist(str5$user_id)) %>%
  group_by(user_id) %>% summarise( BsnsReviwed = n_distinct(business_id)) %>% 
  filter(BsnsReviwed<3) %>% arrange(BsnsReviwed) 

#join with str5
summary(str5)
summary(fake_ids)

fake_ids <- left_join(fake_ids,str5)

fake_ids %>% arrange(desc(review_count)) %>% head()
#can get business_id also
write_csv(x = fake_ids,path = "fake_ids.csv")


