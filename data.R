### Loading Packages ###

library(tidyverse)
library(tools)


#  Map data

create_map_data = function(data) {
  
  map_data = data %>% arrange(name)
  
  map_data$type = str_to_title(map_data$type)
  
  # Setting colors for school types
  
  map_data$color = ifelse(map_data$type == "Asian", "red",
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
                   ifelse(map_data$type == "Variety", "purple", NA)))))))))))))))
  
  write.csv(map_data, "test.csv", row.names = FALSE)
  
  map_data$website = paste0("<a href = '", map_data$website, "' target = '_blank'>", map_data$website, "</a>")
  
  head(map_data)
  
  return(map_data)
  
}




















