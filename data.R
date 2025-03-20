### Loading Packages ###

library(tidyverse)


#  Map data

create_map_data = function(data) {
  
  map_data = data %>% arrange(name)
  
  # Setting colors for school types
  
  map_data$color = ifelse(map_data$type == "asian", "red",
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
                   ifelse(map_data$type == "variety", "purple", NA)))))))))))))))
  
  write.csv(map_data, "test.csv", row.names = FALSE)
  
  map_data$website = paste0("<a href = '", map_data$website, "' target = '_blank'>", map_data$website, "</a>")
  
  head(map_data)
  
  return(map_data)
  
}




















