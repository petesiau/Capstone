library(shiny)


shinyUI(pageWithSidebar(
  headerPanel("Capstone Project"),
  sidebarPanel(
    h3("User Input"),
    br(),
    
    strong(""),
    textInput("text1", "Please enter a text in the box below:", value = "This afternoon i am going "),
    br(),
    
    selectInput("words1", "Please choose the maximum number of predicted words to return",
                choices = list("1" = 1, "2" = 2,
                               "3" = 3, "4" = 4,
                               "5" = 5, "6" = 6, 
                               "7" = 7, "8" = 8, 
                               "9" = 9, "10" = 10), selected = 5),
    br(),
    
    strong("Please click the button to see the predicted words."),
    actionButton("button1", "Predict")
    
    
  ),
  mainPanel(
    tabsetPanel(
      
      tabPanel("Prediction",
               
               h4('Entered text:'),
               verbatimTextOutput("text11"),
               
               h4('Words matched in the database:'),
               verbatimTextOutput("text22"),
               
               h4('Predicted words most likely to follow after the entered text:'),
               tableOutput("table1")
               
      ),
      
      tabPanel("Documentation",
               h4("Application"),
               p("The goal of this application is to create a web interface to the prediction 
                 algorithm that predicts the next possible word when a user is typing a text."),
               p("The application is a Shiny app that takes as input a phrase (multiple words) in a text box 
                 input and outputs a prediction of the next word."),
               br(),
               
               h4("Application Functionality"),
               p("1.Filter the input, remove numbers, punctuation, foreign characters, profanity, single letter words
                 (a, b, c, etc.), and contractions."),
               p("2.Search word matches in the database, display the matched words."),
               p("3.Calculate and sort in ascending order the score for each predicted word, and display."),
               br(),
               
               h4("Source Code"),
               p("On GitHub:"),
               p("fill")
               
               
               
               )
               ))
               ))
