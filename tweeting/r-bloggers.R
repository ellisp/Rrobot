# draw a word cloud of the words on the R-bloggers splash page
# aim is to do this once every two weeks

#-----------------functionality------------
library(rvest)
library(dplyr)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(showtext)
library(praise)
library(stringr)

font_add_google("Dekko", "myfont")
showtext_auto()
# Twitter credentials (not recognised in Git):
source("credentials_setup.R")

#---------------download data-------------
webpage <- read_html("http://www.r-bloggers.com/")

# convert to a corpus and remove stopwords, months, etc
rb <- webpage %>% 
   html_text() %>% 
   VectorSource() %>% 
   VCorpus() %>%
   tm_map(removePunctuation) %>%
   tm_map(content_transformer(tolower)) %>%
   tm_map(function(x) removeWords(x, stopwords("english"))) %>%
   tm_map(function(x) removeWords(x, tolower(format(ISOdate(2004, 1:12, 1), "%B")))) %>%
   TermDocumentMatrix() %>%
   as.matrix() 

# convert to a data frame, remove numbers, aggregate up again
rb_df <- data_frame(freq = as.numeric(rb[, 1]), term = names(rb[,1])) %>%
   mutate(term = gsub("[0-9]+", "", term)) %>%
   filter(!term %in% c("by", "px", "")) %>%
   group_by(term) %>%
   summarise(freq = sum(freq)) %>%
   ungroup() %>%
   filter(freq > 1 & str_length(term) > 1) %>%
   arrange(desc(freq))

#--------------------draw image-------------------
png("img/cloud.png", 1024, 512, res = 100)
showtext_opts(dpi = 100)
par(bg = "grey92", family = "myfont", mar = c(1, 1, 4, 1))   
wordcloud(rb_df$term, rb_df$freq, random.order = FALSE, max.words = 100,
          random.color = TRUE, colors = brewer.pal(8, "Dark2"),
          rot.per = 0, fixed.asp = FALSE, scale = c(5, .5))
title(main = "What the splash page for R-Bloggers looks like these days")
dev.off()

#--------------------send tweet----------------------

tweettxt <- praise("${Exclamation}! ${Adjective} stuff.")

tweet(tweettxt, mediaPath = "img/cloud.png")
line <- paste(as.character(Sys.time()), tweettxt, sep="\t")
write(line, file="tweets.log", append=TRUE)
