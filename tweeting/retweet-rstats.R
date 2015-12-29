
#--------------set up---------------
library(twitteR)
library(stringi)
library(dplyr)
library(base64enc)
library(praise)

source("credentials_setup.R")
source("utils/functions.R") # for retweet() function

# scan in old retweets
oldrts <- scan("retweets.log", what = character())

#----------listen and choose one to retweet------------

rstats <- searchTwitter("#rstats", n=150)

while(!exists("RT") || RT$id %in% oldrts){
   rsdf <- twListToDF(rstats) 
   
   rdf2 <- rsdf %>%  filter(!isRetweet)
   s <- sample(1:nrow(rdf2), 1, prob = rdf2$favoriteCount + 0.1)
   RT <- rdf2[s, c("id", "screenName")]
}



#---------retweet---------
# comment to put at beginning:
if(runif(1) > 0.5){
   com <- praise("${Adjective}")} else {
      com <- praise("${Exclamation}")
   }

tweettxt <- retweet(RT$id, RT$screenName, com)

# update logs:
line <- paste(as.character(Sys.time()), tweettxt$text, sep="\t")
write(line, file="tweets.log", append=TRUE)
write(RT$id, file = "retweets.log", append = TRUE)
