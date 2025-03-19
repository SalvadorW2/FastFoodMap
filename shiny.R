### Loading Packages ###

library(tidyverse)
library(shiny)


### Loading Source Files ###

## Data
# source("data.R")

## UI
source("ui.R")

## Server
source("server.R")


### Application ###

# Importing data
data = read.csv("FastFoodRestaurants.csv")

# Data Processing
# map_data = create_map_data(data)


# Creating application components

## UI
UI = create_ui(data)

## Server
Server = create_server(data)


### Running Application ###

shinyApp(ui = UI, server = Server)
