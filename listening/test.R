
source("credentials_setup.R")
rstats <- searchTwitter("#rstats", n=150)
save(rstats, file = "rstats_today.rda")

