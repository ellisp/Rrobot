library(twitteR)
library(stringr)
library(dplyr)
library(base64enc)

source("credentials_setup.R")

fw_existing <- scan("followers.txt")

user <- getUser("HappyRRobot")

followers <- user$getFollowers(10)

fw <- twListToDF(followers)

fw_new <- fw[!fw$id %in% fw_existing, "id"]

if(length(fw_new) > 0){
   write(fw_new, file = "followers.txt", append = TRUE)   
   
   
   
   tl <- userTimeline(fw_new[1])
   txt <- paste(twListToDF(tl)$text, collapse = " ")
   rposts <- str_count(txt, "#rstats")
   # doesn't work:
   httr::POST(paste0("https://api.twitter.com/1.1/friendships/create.json?user_id=",
          fw_new[1], "&follow=true"))
}







