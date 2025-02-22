library(shiny)

# Sample dataset
data <- data.frame(
  country = rep(c("USA", "India", "Germany"), each = 10),
  year = rep(2011:2020, 3),
  value = sample(50:100, 30, replace = TRUE)
)

fluidPage(
  titlePanel("Shiny Reactivity Demo"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("country", "Select a Country:", 
                  choices = unique(data$country))
    ),
    
    mainPanel(
      textOutput("summaryText"),
      plotOutput("trendPlot")
    )
  )
)