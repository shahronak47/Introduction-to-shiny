library(shiny)

ui <- fluidPage(
  titlePanel("Beginner Shiny App: BMI & Random Plot"),
  
  sidebarLayout(
    sidebarPanel(
      h4("BMI Calculator"),
      numericInput("height", "Height (cm):", value = 170, min = 100, max = 250),
      numericInput("weight", "Weight (kg):", value = 70, min = 30, max = 200),
      actionButton("calc_bmi", "Calculate BMI"),
      br(), br(),
      
      h4("Random Plot"),
      sliderInput("num_points", "Number of Points:", min = 10, max = 500, value = 100)
    ),
    
    mainPanel(
      verbatimTextOutput("bmi_result"),
      plotOutput("scatter_plot")
    )
  )
)

server <- function(input, output, session) {
  
  # Reactive expression for BMI
  bmi <- eventReactive(input$calc_bmi, {
    height_m <- input$height / 100
    bmi_val <- input$weight / (height_m^2)
    round(bmi_val, 1)
  })
  
  # Show BMI result
  output$bmi_result <- renderText({
    req(bmi())  # Ensure BMI is calculated
    paste("Your BMI is:", bmi())
  })
  
  # Reactive expression for random data
  random_data <- reactive({
    n <- input$num_points
    data.frame(x = rnorm(n), y = rnorm(n))
  })
  
  # Plot output
  output$scatter_plot <- renderPlot({
    data <- random_data()
    plot(data$x, data$y,
         main = paste("Scatterplot with", input$num_points, "Points"),
         xlab = "X", ylab = "Y", col = "blue", pch = 19)
  })
}

shinyApp(ui, server)
