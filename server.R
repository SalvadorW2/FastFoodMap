### Loading Packages ###

library(tidyverse)
library(shiny)
library(leaflet)
library(DT)


create_server = function(map_data) {
  
  Server = function(input, output, session) {
    
    # Filtering map data based on state input
    filtered_map_data = shiny::reactive({
      
      if (input$state_filter == "All") {
        
        return(map_data)
        
      } else {
        
        return(map_data[map_data$province == input$state_filter, ])
        
      }
      
    })
    
    # Configuring icons
    icons = awesomeIcons(icon = "whatever",
                         iconColor = "black",
                         library = "ion",
                         markerColor = map_data$color)
    
    # Rendering map
    output$map = renderLeaflet({
      
      # Creating leaflet map centered at specific location
      leaflet(filtered_map_data()) %>%
        
        setView(lng = mean(map_data$longitude),
                lat = mean(map_data$latitude),
                zoom = 4) %>%
        
        # Adding tile layer using OpenStreetMap
        addTiles() %>%
        addProviderTiles("OpenStreetMap.Mapnik") %>%
        
        # Adding markers
        addAwesomeMarkers(lng = ~longitude,
                          lat = ~latitude,
                          icon = icons,
                          label = ~name,
                          group = "markers",
                          popup = ~paste("<b>", "Restaurant:", "</b>", name, "<br>",
                                         "<b>", "City:", "</b>", city, "<br>",
                                         "<b>", "Address:", "</b>", address, "<br>",
                                         "<b>", "Postal Code: ", "</b>", postalCode
                                         ),
                          clusterOptions = leaflet::markerClusterOptions())
      
    })
    
    output$legend = renderUI({
      legend_info = list("asian" = "Asian",
                         "breakfast" = "Breakfast",
                         "buffet" = "Buffet",
                         "burger" = "Burger",
                         "chicken" = "Chicken",
                         "dessert" = "Dessert",
                         "european" = "European",
                         "mexican" = "Mexican",
                         "other" = "Other",
                         "pizza" = "Yellow",
                         "regional" = "Regional",
                         "sandwich" = "Sandwich",
                         "seafood" = "Seafood",
                         "steak" = "Steak",
                         "variety" = "Variety")
      

      legendUI = lapply(names(legend_info), function(type) {
        div(
          div(
            style = sprintf("background-color: %s; width: 10px; height: 10px; display: inline-block; margin-right: 5px;",
                            ifelse(map_data$type == "asian", "red",
                            ifelse(map_data$type == "breakfast", "gold",
                            ifelse(map_data$type == "buffet", "pink",
                            ifelse(map_data$type == "burger", "tan",
                            ifelse(map_data$type == "chicken", "white",
                            ifelse(map_data$type == "dessert", "turquoise",
                            ifelse(map_data$type == "european", "black",
                            ifelse(map_data$type == "mexican", "orange",
                            ifelse(map_data$type == "other", "gray",
                            ifelse(map_data$type == "pizza", "yellow",
                            ifelse(map_data$type == "regional", "darkblue",
                            ifelse(map_data$type == "sandwich", "green",
                            ifelse(map_data$type == "seafood", "blue",
                            ifelse(map_data$type == "steak", "brown",
                            ifelse(map_data$type == "variety", "purple", NA))))))))))))))))
        ),
        div(legend_info[[type]],
            style = "display: inline-block; margin-bottom: 5px;"
        ),
        stye = "margin-right: 5px;"
      )
      })

      div(legendUI, style = "margin-top: 5px;")
    })
    
  }
  
  return(Server)
  
}
