#' BMI calculator for adults
#' 
#' This application calculates the body mass index (BMI) of a person, gives the percentile
#' he/she is according to the CDC BMI standards (This considers the age and the sex of
#' the person) and the classification of his/her BMI.
#' 
#' @param Age The age of the person in years, at the time of the analysis.
#' @param Sex The genetic sex of the person, whether female or male.
#' @param Weight The weight of the person in kilograms. If measured in pounds, then divide into 2.2.
#' @param Height The height of the person in feet units.
#' @return The BMI of the person, the percentile according to age and sex, and the classification.
#' 
#' @author CeciHermosilla
#' @details Button "Calculate" must be clicked so the calculations take place. This application uses
#' the get_BMI_percentile() function from the PAUtilities package which uses the percentiles and the
#' classification of the BMI given by CDC and updated to 2018. This was developed as standars by 
#' population analysis of BMI of men and women at different ages. The application will return a BMI
#' percentile and classification for people under 18 years old, however the World Health Organization
#' has a much more updated BMI classification for children and teenayers, so it is not recommended 
#' to use this application for people under 18 years old. PLEASE REFER TO A DIETITIAN OR NUTRITIONIST
#' IF YOU ARE NOT A PROFESSIONAL USING THE APP IN ORDER TO GET BETTER ASSESSMENT.
#' 
#' The application was developed using Shiny in RStudio, it uses two functions (ui.R and server.R):
#' ui.R contains the interface where the inputs and the outputs are shown:

library(shiny)
library(PAutilities)

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


#' server.R hosts and calculates the data:

shinyServer(function(input, output){
  BMIp <- reactive({
    get_BMI_percentile(
      input$weight,
      (input$height * 30.48),
      input$age,
      sex= input$sex,
      output="percentile"
    )
  })
  
  BMIc <- reactive({
    get_BMI_percentile(
      input$weight,
      (input$height * 30.48),
      input$age,
      sex= input$sex,
      output="classification"
    )
  })
  
  output$text = renderText({
    round(input$weight /((input$height * 0.3048)^2),1)
  })
  output$text2 = renderText({ 
    BMIp()
  })
  output$text3 = renderText({ 
    levels(BMIc())[BMIc()]
  })
})

#' @value Numeric for the BMI and the percentile. Level of factor for classification.