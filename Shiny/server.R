library(shiny)
library(tm)
library(stylo)
library(data.table)
library(RWeka)
library(stringr)
library(dplyr)

shinyServer(
  function(input,output) {
    
    # Display entered text
    txtReturn <- eventReactive(input$button1, {
      paste(input$text1)
    })
    output$text11 <- renderText({ txtReturn() })
    
    # Display filtered texts entered
    adjustedTxt <- eventReactive(input$button1, {
      tail(txt.to.words(cleanUserInput(input$text1)), 3)
    })
    output$text22 <- renderText({ adjustedTxt() })
    
    # Get list of predicted words
    nextWord <- eventReactive(input$button1, {
      func_PredictWord(input$text1, input$words1)
    })
    output$table1 <- renderTable({ nextWord() })
    
    
  }
  
)