### Loading Packages ###

library(shiny)

create_ui = function(map_data) {
  
  UI = fluidPage(
    
    # tags$head(
    #   tags$link(rel = "stylesheet", type = "text/css", href = "restaurant_styles.css")
    # ),
    
    titlePanel("Restaurants"),
    
    sidebarLayout(
      
      sidebarPanel(
        
        width = 2,
        
        # State selection
        selectInput(inputId = "state_filter",
                    label = "Select State:",
                    choices = c("All", sort(unique(map_data$province))),
                    selected = "All",
                    multiple = FALSE),
        
        # Type selection
        selectInput(inputId = "type_filter",
                    label = "Select Type(s):",
                    choices = c("All", sort(unique(map_data$type))),
                    selected = "All",
                    multiple = FALSE),
          
            h4("Type"),
            uiOutput("legend")
      ),
      
      mainPanel(
        fluidRow(
          column(leafletOutput(outputId = "map"),
                 width = 12,
                 style = "map_style"
          )),
          
        fluidRow(
          column(plotOutput(outputId = "bar_graph"),
                 width = 12,
                 style = "map_style"
          ))
        )
        
      )
      
    )
  
  return (UI)
  
}
