user# this gets tweets from people I'm following:
timeLine <- homeTimeline(n = 100, retryOnRateLimit = 1000)


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

View(rsdf)
