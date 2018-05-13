library(tm)
library(ngram)
library(stringr)

if(!"R-intro.pdf" %in% list.files("downloads")){
 download.file("https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf", 
               destfile = "downloads/R-intro.pdf", mode = "wb")
}
              
my_reader <- readPDF(control = list(text = "-layout"))
uri <- paste0("file://", getwd(), "/downloads/R-intro.pdf")
txt <- my_reader(elem = list(uri = uri), language = "en", id = "id1")

# visual inspection shows the text starts in line 8 (different from previous edition which was 205)
# cat(content(txt)[8])
# length(content(txt))

# collapse into a single vector and derive the 2-grams:
txt2 <- paste(content(txt)[-(1:7)], collapse =" ")
ng2 <- ngram(txt2, 2)

# babble:
x <- paste(rep("x", 150), collapse = "")

while(str_length(x) > 135){
   x <- str_trim(babble(ng2, genlen = 20))
   
   if(runif(1) > 0.65){
      punc <- "!"
   } else {
      punc <- "."
   }
   
   x <- paste0(x, punc)
   
   
   substring(x, 1, 1) <- toupper(substring(x, 1, 1))
   
}

tweettxt <- gsub("\n", " ", x)
