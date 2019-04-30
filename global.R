library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(lubridate)
library(ggvis)
library(ggplot2)
library(ggridges)

#read our data :
film <-read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018/2018-10-23/movie_profit.csv")

film$release_date <- mdy(film$release_date)
film$mpaa_rating <- as.factor(film$mpaa_rating)
film$genre <- as.factor(film$genre)

film <- film %>% 
  filter(production_budget, worldwide_gross) %>%
  drop_na(distributor, mpaa_rating) %>% 
  mutate(
    global_ratio = (worldwide_gross / production_budget),
    global_ratio = round(global_ratio, 2),
    domestic_ratio = (domestic_gross / production_budget),
    domestic_ratio = round(domestic_ratio, 2)
  )

rating_unique <- unique(film$mpaa_rating)
getwd()



