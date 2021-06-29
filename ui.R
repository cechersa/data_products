library(shiny)

shinyUI(fluidPage(
  titlePanel("BMI calculator for adults"),
  sidebarLayout(
    sidebarPanel(
      h3("Anthropometric data"),
      numericInput("age","Age (years)",min=18,max=120,value=18),
      radioButtons("sex","Sex",choiceNames=c("Female","Male"),choiceValues = c("F","M")),
      numericInput("weight","Weight (Kg)",min=20.0,max=150.0,value=20.0),
      numericInput("height","Height (feet)",min=1.0,max=7.5,value=1.0),
      submitButton("Calculate")
    ),
    mainPanel(
      h2("Body Mass Index:"),
      textOutput("text"),
      h2("Percentile according to CDC:"),
      textOutput("text2"),
      h2("Classification:"),
      textOutput("text3")
    )
  )
))