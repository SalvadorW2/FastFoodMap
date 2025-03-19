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
    # icons = awesomeIcons(icon = "whatever",
    #                      iconColor = "black",
    #                      library = "ion",
    #                      markerColor = map_data$color)
    
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
                          # icon = icons,
                          label = ~name,
                          group = "markers",
                          popup = ~paste("<b>", "Restaurant:", "</b>", name, "<br>",
                                         "<b>", "City:", "</b>", city, "<br>",
                                         "<b>", "Address:", "</b>", address, "<br>",
                                         "<b>", "Postal Code: ", "</b>", postalCode
                                         ),
                          clusterOptions = leaflet::markerClusterOptions())
      
    })
    
    # output$legend = renderUI({
    #   legend_info = list("Preschool" = "Preschool",
    #                      "Elementary School" = "Elementary School",
    #                      "Middle School" = "Middle School",
    #                      "High School" = "High School",
    #                      "Homeschool" = "Homeschool")
    #   
    #   legendUI = lapply(names(legend_info), function(category) {
    #     div(
    #       div(
    #         style = sprintf("background-color: %s; width: 10px; height: 10px; display: inline-block; margin-right: 5px;", 
    #                           ifelse(category == "Preschool", "pink",
    #                           ifelse(category == "Elementary School", "blue",
    #                           ifelse(category == "Middle School", "green",
    #                           ifelse(category == "High School", "red",
    #                           ifelse(category == "Homeschool", "purple"))))))
    #     ),
    #     div(legend_info[[category]],
    #         style = "display: inline-block; margin-bottom: 5px;"
    #     ),
    #     stye = "margin-right: 5px;"
    #   )
    #   })
    #   
    #   div(legendUI, style = "margin-top: 5px;")
    # })
    
  }
  
  return(Server)
  
}
