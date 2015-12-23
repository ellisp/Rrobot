#--------------set up---------------
library(twitteR)
library(stringi)
library(dplyr)
library(base64enc)

source("credentials_setup.R")

#---------------main loop-------------
# down the track this will randomly choose between several options


source("tweeting/fortunes.R")

tweet(tweettxt)
line <- paste(as.character(Sys.time()), tweettxt, sep="\t")
write(line, file="tweets.log", append=TRUE)