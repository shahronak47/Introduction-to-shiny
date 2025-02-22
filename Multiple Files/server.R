library(shiny)

function(input, output, session) {
  
  # Sample dataset
  data <- data.frame(
    country = rep(c("USA", "India", "Germany"), each = 10),
    year = rep(2011:2020, 3),
    value = sample(50:100, 30, replace = TRUE)
  )
  
  # Reactive Expression: Filters data based on input
  filtered_data <- reactive({
    subset(data, country == input$country)
  })
  
  # Observer: Print log message when input changes
  observe({
    cat("Country selected:", input$country, "\n")
  })
  
  # Reactive Output: Display summary text
  output$summaryText <- renderText({
    paste("Showing data for", input$country)
  })
  
  # Reactive Output: Generate a plot
  output$trendPlot <- renderPlot({
    plot(filtered_data()$year, filtered_data()$value, type = "b",
         col = "blue", pch = 19, main = paste("Trend for", input$country),
         xlab = "Year", ylab = "Value")
  })
}