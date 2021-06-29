library(shiny)
library(PAutilities)

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