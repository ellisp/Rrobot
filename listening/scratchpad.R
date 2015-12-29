# https://twittercommunity.com/t/method-to-retweet-with-comment/35330/18

user# this gets tweets from me.
timeLine <- homeTimeline(n = 100, retryOnRateLimit = 1000)




retweet("680557134820458497", "ellis2013nz", "Test retweet with comment:")

me <- searchTwitter("from:HappyRrobot")
ellis <- searchTwitter("from:ellis2013nz")

ellis_df <- twListToDF(ellis)

# this gets tweets on rstats
rstats <- searchTwitter("#rstats", n=150)

rsdf <- twListToDF(rstats) 

rsdf2 <- 
   rsdf %>%
   mutate(id = rnorm(nrow(rsdf))) %>%
   filter(!isRetweet) %>%
   mutate(wt = retweetCount + 0.05) %>%
   sample_n(3, weight = wt) %>%
   select(text)


tweettxt <- rsdf[23, "text"]

# check if an individual is following me
friendships("ellis2013nz")


