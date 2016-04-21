Data Science Specialization - Capstone Project
========================================================
author: Pete Siau
date: April 21, 2016

Goal:   
To create a product to highlight the prediction algorithm adopted to build and to provide an interface that can be accessed by others.

The Process
========================================================
- Create a corpus using datasets made available from Swiftkeys
- Use of text mining tools and predictive algorithms in Natural Language Processing (NLP)
- Build a Shiny application to predict the next word 
- Pitch the project presentation using R Presentations in RStudio 

The Method
========================================================
- After the corpus is created, remove punctuation, white spaces, foreign chars, profanity, and convert to lowercase to create a plain text file.  
- From the corpus, create N-Gram sequence data frames of unigram, bigram, trigram and quadgram.  
- When an user input text, shorten input and search for match. The N-Gram data frames are used to predict the next word according to the frequencies of the underlying N-Grams.  
- If the next word can not be found under current N-Grams, use "Stupid Backoff" algorithm to find more matches and pick up the most likely next word. Because of that, we need to apply a penalty to the log probability score.  
- Calculate score for each match found, sort result and display output.  


References and Further Information
========================================================

Shiny Application:  Please click [here][1] 

[1]: https://petesiau.shinyapps.io/Shiny/

