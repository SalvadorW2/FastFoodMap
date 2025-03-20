### Loading Packages ###

library(tidyverse)
library(shiny)


### Loading Source Files ###

source("data.R")
source("ui.R")
source("server.R")


### Application ###

# Importing datas
data = read.csv("FastFoodRestaurants.csv")

# Data Processing
map_data = create_map_data(data)


# Creating application components

## UI
UI = create_ui(map_data)

## Server
Server = create_server(map_data)


### Running Application ###

shinyApp(ui = UI, server = Server)