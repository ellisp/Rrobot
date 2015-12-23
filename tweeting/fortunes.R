# tweets a random fortune, from those that are less than 140 characters long

library(fortunes)

f <- data.frame(
   quote = character(),
   len = numeric(),
   stringsAsFactors = FALSE
)

for(i in 1:360){
   f[i, 1] <- paste0("'", fortune(i)$quote, "' ", fortune(i)$author, ".")
   f[i, 2] <- stri_length(f[i, 1])
}

f2 <- f %>% filter(len < 140) 
tweettxt <- sample(f2[, 1], 1)


