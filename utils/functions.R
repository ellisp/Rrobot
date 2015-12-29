
retweet <- function(tweet_id, screenName, comment = NULL){
   # retweets, with an optional comment
   if(!is.character(tweet_id)){
      stop("tweet_id must be a character or bad things happen.")
   }
   rt <- paste0("https://twitter.com/", screenName, "/status/", tweet_id)
   if(!is.null(comment)){
      rt <- paste(comment, rt) 
   }
   tmp <- tweet(rt)
   return(tmp)
}