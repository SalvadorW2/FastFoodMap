### Loading Packages ###

library(shiny)

create_ui = function(map_data) {
  
  UI = fluidPage(
    
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "good_book_styles.css")
    ),
    
    titlePanel("Restaurants"),
    
    sidebarLayout(
      
      sidebarPanel(
        width = 2,
        # State selection
        selectInput("state_filter",
                    "Select State:",
                    choices = c("All", sort(unique(map_data$state))),
                    selected = "All"),
        
        h4("School Types"),
        uiOutput("legend")
      ),
      
      mainPanel(
        leafletOutput("map"),
        width = 10,
        style = "map_style"
      )
      
    )
  )
    
  
  return (UI)
  
}
