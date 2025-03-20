### Loading Packages ###

library(tidyverse)
library(shiny)


### Loading Source Files ###

source("data.R")
source("ui.R")
source("server.R")


### Application ###

# Importing data
data = read.csv("FastFoodRestaurants.csv")

# Data Processing
data = create_map_data(data)


# Creating application components

## UI
UI = create_ui(data)

## Server
Server = create_server(data)


### Running Application ###

shinyApp(ui = UI, server = Server)
