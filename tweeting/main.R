#--------------set up---------------
library(twitteR)
library(stringi)
library(dplyr)
library(base64enc)

source("credentials_setup.R")

#---------------main loop-------------
rnd <- runif(1)

if(rnd > 0.7){
   source("tweeting/fortunes.R")   
} else if(rnd > 0.3){
   source("tweeting/R-intro.R")
} else {
   source("tweeting/R-admin.R")
}

print(paste(rnd, tweettxt))


tweet(tweettxt)
line <- paste(as.character(Sys.time()), tweettxt, sep="\t")
write(line, file="tweets.log", append=TRUE)