ui <- fluidPage(
  textInput("name", "Enter your name:"),
  textOutput("greeting")
)

server <- function(input, output) {
  output$greeting <- renderText({
    paste("Hello,", input$name, "!")
  })
}

shinyApp(ui, server)
