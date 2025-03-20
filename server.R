### Loading Packages ###

library(tidyverse)
library(shiny)
library(leaflet)
library(DT)


create_server = function(map_data) {
  
  Server = function(input, output, session) {
    
    # Filtering map data based on input
    filtered_map_data = shiny::reactive({
      
      if (input$state_filter == "All" & input$type_filter == "All") {
        
        return(map_data)
        
      } else if (input$state_filter == "All" & input$type_filter != "All") {
        
        map_data = subset(map_data, type == input$type_filter)
        return(map_data)
        
      } else if (input$state_filter != "All" & input$type_filter == "All") {
        
        map_data = subset(map_data, province == input$state_filter)
        return(map_data)
        
      } else {
        
        map_data = subset(map_data, province == input$state_filter & type == input$type_filter)
        return(map_data)
        
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
                          clusterOptions = leaflet::markerClusterOptions()
                          )
      
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
                         "pizza" = "Pizza",
                         "regional" = "Regional",
                         "sandwich" = "Sandwich",
                         "seafood" = "Seafood",
                         "steak" = "Steak",
                         "variety" = "Variety")
      

      legendUI = lapply(names(legend_info), function(category) {
        div(
          div(
            style = sprintf("background-color: %s; width: 10px; height: 10px; display: inline-block; margin-right: 5px;",
                            ifelse(map_data$type == "Asian", "red",
                            ifelse(map_data$type == "Breakfast", "gold",
                            ifelse(map_data$type == "Buffet", "pink",
                            ifelse(map_data$type == "Burger", "tan",
                            ifelse(map_data$type == "Chicken", "white",
                            ifelse(map_data$type == "Dessert", "turquoise",
                            ifelse(map_data$type == "European", "black",
                            ifelse(map_data$type == "Mexican", "orange",
                            ifelse(map_data$type == "Other", "gray",
                            ifelse(map_data$type == "Pizza", "yellow",
                            ifelse(map_data$type == "Regional", "darkblue",
                            ifelse(map_data$type == "Sandwich", "green",
                            ifelse(map_data$type == "Seafood", "blue",
                            ifelse(map_data$type == "Steak", "brown",
                            ifelse(map_data$type == "Variety", "purple", NA))))))))))))))))
        ),
        div(legend_info[[category]],
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
