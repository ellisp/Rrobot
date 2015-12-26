#--------------set up---------------
library(twitteR)
library(stringi)
library(dplyr)
library(base64enc)

source("credentials_setup.R")

#---------------main loop-------------
rnd <- runif(1)

if(rnd > 0.5){
   source("tweeting/fortunes.R")   
} else {
   source("tweeting/R-intro.R")
}




tweet(tweettxt)
line <- paste(as.character(Sys.time()), tweettxt, sep="\t")
write(line, file="tweets.log", append=TRUE)