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
                    selected = "All"),
        
        # Type selection
        checkboxGroupInput(inputId = "type_filter",
                           label = "Select Type(s):",
                           choices = sort(unique(map_data$type))),
          
            h4("Type"),
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
