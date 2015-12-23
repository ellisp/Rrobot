library(rvest)
library(dplyr)
library(tm)
library(wordcloud)
library(RColorBrewer)
library(showtext)

font.add.google("Dekko", "myfont")
showtext.auto()

source("credentials_setup.R")

webpage <- read_html("http://www.r-bloggers.com/")

# the data we want is in the first table on this page
# the html_table() command coerces the data into a data frame




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

rb_df <- data_frame(freq = as.numeric(rb[, 1]), term = names(rb[,1])) %>%
   mutate(term = gsub("[0-9]+", "", term)) %>%
   group_by(term) %>%
   summarise(freq = sum(freq)) %>%
   ungroup() %>%
   filter(freq > 1)
   

png("img/cloud.png", 1024, 512, res = 200)
par(bg = "grey92", family = "myfont")   
wordcloud(rb_df$term, rb_df$freq, random.order = FALSE, max.words = 100,
          random.color = TRUE, colors = brewer.pal(8, "Dark2"),
          rot.per = 0, fixed.asp = FALSE, scale = c(18, .5))
title(main = "What the splash page for R-Bloggers looks like these days")
dev.off()



