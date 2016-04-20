### Data Science Capstone Project

#### A Text Prediction Algorithm built with the SwiftKey Dataset
This README file describes the algorithm and all files necessary to satisfy the shiny apps requirement for the Data Science Capstone final project.

### Project Requirements

##### The objective is to create a presentation product which is a web interface using Shiny, an R package to show the prediction algorithm built.

The product is a Shiny app that takes a text phrase (multiple words) as input in a text box and displays the predicted next word(s) in ascending ranking order.

A slide deck consisting of 5 slides created uging R Studio Presenter pitching your algorithm and app for presentation purposes.

A GitHub repository contains all the files of the project.

### Project Data

##### SwiftKey Data

The data is made available from a corpus called HC Corpora (www.corpora.heliohost.org). Only the English langauge version of the datasets were used, filtered but may still contain some foreign text. The Capstone Project will apply data science in the area of natural language processing.

### Prediction Algorithm

##### The text prediction algorithm deployed on the shiny apps website is using the "Stupid Backoff" approach. If a match is not found, we will shorten the user input and search again to increase the chances of a match is found. Penalty of a log(0.4) is added to the final probability.

##### 1: User input is filter to remove profanity, punctuation, contractions, numbers, foreign characters, common words, and any extra white space.

##### 2: Search for a match in the database. If sufficient number of matches then skip to Step 4

##### 3: If more matches are needed we shorten user input and search again

##### 4: Calculate probability scores for matches, add penalty if necessary.Log probability is employed to increase algorithm speed.

###Calculating Probability Score

When multiple matches are found, there are ranked based on scores calculated.


### Key considerations for algorithm design

The predictive model must be small enough to load onto the Shiny server.

We chose a model based on existing NGrams. For a long text, the application shorten it to the last three words and use the 4-gram tables. These tables (1,2,3,4 gram) are loaded from a text file prior to execution of the algorithm.

The NGram tables are splited to increase the speed of the algorithm and to reduce memory usage while returning quickly the result.



