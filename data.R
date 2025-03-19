### Loading Source Files ###


#  Map data

create_map_data = function(data) {
  
  map_data = data %>% arrange(school_name)
  
  # Setting colors for school types
  map_data$color = ifelse(map_data$school_type == "Preschool", "pink",
                   ifelse(map_data$school_type == "Elementary School", "blue",
                   ifelse(map_data$school_type == "Middle School", "green",
                   ifelse(map_data$school_type == "High School", "red",
                   ifelse(map_data$school_type == "Homeschool", "purple", NA)))))
  
  map_data$URL = paste0("<a href = '", map_data$website, "' target = '_blank'>", map_data$website, "</a>")
  
  return(map_data)
  
}




















