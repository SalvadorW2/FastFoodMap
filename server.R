### Loading Packages ###

library(tidyverse)
library(shiny)
library(leaflet)
library(DT)


create_server = function(map_data) {
  
  Server = function(input, output, session) {
    
    # Filtering graph data based on input
    filtered_graph_data = shiny::reactive({
      
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
    icons = awesomeIcons(icon = "ios-close",
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
                          icon = ~icons,
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
    
    output$bar_graph = renderPlot({
      
      ggplot(data = filtered_graph_data(), aes(x = factor(type), y = "Value", fill = type)) +
        geom_bar(stat = "identity") +
        labs(title = "Number of Restaurants by Type", x = "Type", y = "Number") +
        scale_fill_manual(values = c("Asian" = "red",
                                     "Breakfast" = "gold",
                                     "Buffet" = "pink",
                                     "Burger" = "tan",
                                     "Chicken" = "white",
                                     "Dessert" = "turquoise",
                                     "European" = "black",
                                     "Mexican" = "orange",
                                     "Other" = "gray",
                                     "Pizza" = "yellow",
                                     "Regional" = "darkblue",
                                     "Sandwich" = "green",
                                     "Seafood" = "blue",
                                     "Steak" = "brown",
                                     "Variety" = "purple"))
      
    })
    
    
    output$legend = renderUI({
      legend_info = list("Asian" = "Asian",
                         "Breakfast" = "Breakfast",
                         "Buffet" = "Buffet",
                         "Burger" = "Burger",
                         "Chicken" = "Chicken",
                         "Dessert" = "Dessert",
                         "European" = "European",
                         "Mexican" = "Mexican",
                         "Other" = "Other",
                         "Pizza" = "Pizza",
                         "Regional" = "Regional",
                         "Sandwich" = "Sandwich",
                         "Seafood" = "Seafood",
                         "Steak" = "Steak",
                         "Variety" = "Variety")
      

      legendUI = lapply(names(legend_info), function(category) {
        div(
          div(
            style = sprintf("background-color: %s; width: 10px; height: 10px; display: inline-block; margin-right: 5px;",
                            ifelse(category == "Asian", "red",
                            ifelse(category == "Breakfast", "gold",
                            ifelse(category == "Buffet", "pink",
                            ifelse(category == "Burger", "tan",
                            ifelse(category == "Chicken", "white",
                            ifelse(category == "Dessert", "turquoise",
                            ifelse(category == "European", "black",
                            ifelse(category == "Mexican", "orange",
                            ifelse(category == "Other", "gray",
                            ifelse(category == "Pizza", "yellow",
                            ifelse(category == "Regional", "darkblue",
                            ifelse(category == "Sandwich", "green",
                            ifelse(category == "Seafood", "blue",
                            ifelse(category == "Steak", "brown",
                            ifelse(category == "Variety", "purple", NA))))))))))))))))
            
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
