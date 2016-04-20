# Load libraries
library(tm)
library(dplyr)
library(data.table)
library(stylo)
library(RWeka)
library(stringr)

# Read all the datasets into R
con <- file("./Data/en_US/en_US.blogs.txt")
blogs <- readLines(con)
close(con)

con <- file("./Data/en_US/en_US.news.txt", open="rb")
news <- readLines(con)
close(con)

con <- file("./Data/en_US/en_US.twitter.txt")
twitter <- readLines(con)
close(con)
rm(con)

source('./func_SampleData.R')

# Due to limitation of cpu and memory resources, about 80k samplesare selected
set.seed(1738)
blogsSample <- func_SampleData(blogs,percent = 0.1)
newsSample <- func_SampleData(news,percent = 0.08)
twitterSample <- func_SampleData(twitter,percent = 0.035)

save(blogsSample, newsSample, twitterSample, file = "SampledData1.RData")

rm(list=ls())

load("SampledData1.RData")

source("./func_CleanData.R")

# Clean data, save file
cleanBlogs <- func_CleanData(blogsSample)
cleanNews <- func_CleanData(newsSample)
cleanTwitter <- func_CleanData(twitterSample)

save(cleanBlogs, cleanNews, cleanTwitter, file = "cleanData1.RData")

rm(list = ls())

# Read in the cleanse dataset in R
load("cleanData1.RData")

# Temp files to be used to create a unigram list
tmpBlogWords <- txt.to.words(cleanBlogs)
tmpNewsWords <- txt.to.words(cleanNews)
tmpTwitterWords <- txt.to.words(cleanTwitter)

save(tmpBlogWords, tmpNewsWords, tmpTwitterWords, file = "txt2words1.RData")

rm(tmpBlogWords, tmpNewsWords, tmpTwitterWords)

# Convert dataset into Corpus
corpusBlogs <- VCorpus(VectorSource(cleanBlogs))
corpusNews <- VCorpus(VectorSource(cleanNews))
corpusTwitter <- VCorpus(VectorSource(cleanTwitter))

save(corpusBlogs, corpusNews, corpusTwitter, file = "corpus234gram1.RData")

rm(cleanBlogs, cleanNews, cleanTwitter)

# Create word list from corpus variables, these variables will be used to create 2,3,4 gram tables
blogWords <- txt.to.words(corpusBlogs)
newsWords <- txt.to.words(corpusNews)
twitterWords <- txt.to.words(corpusTwitter)

save(blogWords, newsWords, twitterWords, file = "txt2wordsCorpus1.RData")

rm(corpusBlogs, corpusNews, corpusTwitter)

source("./func_NGrams.R")

# Create temp 2gram variables
tmp2gramB <- func_NGrams(blogWords, 2)
tmp2gramN <- func_NGrams(newsWords, 2)
tmp2gramT <- func_NGrams(twitterWords, 2)

save(tmp2gramT, tmp2gramN, tmp2gramB, file = "tmp2gram1.RData")

rm(tmp2gramT, tmp2gramN, tmp2gramB)


# Create temp 3gram variables
tmp3gramB <- func_NGrams(blogWords, 3)
tmp3gramN <- func_NGrams(newsWords, 3)
tmp3gramT <- func_NGrams(twitterWords, 3)

save(tmp3gramT, tmp3gramN, tmp3gramB, file = "tmp3gram1.RData")

rm(tmp3gramT, tmp3gramN, tmp3gramB)


# Create temp 4gram variables
load("txt2wordsCorpus1.RData")
rm(blogWords, newsWords)
tmp4gramT <- func_NGrams(twitterWords, 4)
rm(twitterWords)
save(tmp4gramT, file = "tmp4gram1.RData")
rm(tmp4gramT)

load("txt2wordsCorpus1.RData")   
rm(twitterWords, newsWords) 

tmp4gramB <- func_NGrams(blogWords, 4)
rm(blogWords)

load("tmp4gram1.RData")
save(tmp4gramB, tmp4gramT, file = "tmp4gram1.RData")
rm(tmp4gramB, tmp4gramT)

load("txt2wordsCorpus1.RData")   
rm(twitterWords, blogWords) 

tmp4gramN <- func_NGrams(newsWords, 4)
rm(newsWords)
load("tmp4gram1.RData")
save(tmp4gramT, tmp4gramN, tmp4gramB, file = "tmp4gram1.RData")

rm(list=ls())


# Create tables for 2,3,4 gram word counts
load("tmp2gram1.RData")
table2gram <- table(c(tmp2gramB, tmp2gramN, tmp2gramT))
save(table2gram, file = "tmp2gramTable1.RData")
rm(list=ls())

load("tmp3gram1.RData")
table3gram <- table(c(tmp3gramB, tmp3gramN, tmp3gramT))
save(table3gram, file = "tmp3gramTable1.RData")
rm(list=ls())

load("tmp4gram1.RData")
table4gram <- table(c(tmp4gramB, tmp4gramN, tmp4gramT))
save(table4gram, file = "tmp4gramTable1.RData")
rm(list=ls())

# Create filtered tables

load("txt2words1.RData")
tmp1gram <- table(c(tmpBlogWords, tmpNewsWords, tmpTwitterWords))
filtered1gram <- data.frame(word=names(tmp1gram), freq=as.numeric(tmp1gram), stringsAsFactors = FALSE)
filtered1gram <- filter(filtered1gram, freq != 1)
filtered1gram <- arrange(filtered1gram, desc(freq))
save(filtered1gram, file = "tmp1gramTableFiltered1.RData")
rm(list = ls())

load("tmp2gramTable1.RData")
filtered2gram <- data.frame(word=names(table2gram), freq=as.numeric(table2gram), stringsAsFactors = FALSE)
filtered2gram <- filter(filtered2gram, freq != 1)
filtered2gram <- arrange(filtered2gram, desc(freq))
save(filtered2gram, file = "tmp2gramTableFiltered1.RData")
rm(list=ls())

load("tmp3gramTable1.RData")
filtered3gram <- data.frame(word=names(table3gram), freq=as.numeric(table3gram), stringsAsFactors = FALSE)
filtered3gram <- filter(filtered3gram, freq != 1)
filtered3gram <- arrange(filtered3gram, desc(freq))
save(filtered3gram, file = "tmp3gramTableFiltered1.RData")
rm(list=ls())

load("tmp4gramTable1.RData")
filtered4gram <- data.frame(word=names(table4gram), freq=as.numeric(table4gram), stringsAsFactors = FALSE)
filtered4gram <- filter(filtered4gram, freq != 1)
filtered4gram <- arrange(filtered4gram, desc(freq))
save(filtered4gram, file = "tmp4gramTableFiltered1.RData")
rm(list=ls())

# Create index for separating filtered tables after concatenation

load("tmp1gramTableFiltered1.RData")
load("tmp2gramTableFiltered1.RData")
load("tmp3gramTableFiltered1.RData")
load("tmp4gramTableFiltered1.RData")

gram1 <- c(1,nrow(filtered1gram))
gram2 <- c(gram1[2]+1, gram1[2]+nrow(filtered2gram))
gram3 <- c(gram2[2]+1, gram2[2]+nrow(filtered3gram))
gram4 <- c(gram3[2]+1, gram3[2]+nrow(filtered4gram))
save(gram1, gram2, gram3, gram4, file = "ngramData.RData")
rm(gram1, gram2, gram3, gram4)

# Join tables, write a text output file
ngramTable <- rbind(filtered1gram, filtered2gram, filtered3gram, filtered4gram)
rm(filtered1gram, filtered2gram, filtered3gram, filtered4gram)

save(ngramTable, file = "finalTable1.RData")

write.table(ngramTable, file = "finalNGramSorted1.txt", sep = "\t", row.names = FALSE)