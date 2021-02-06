library(shiny)
library(shinydashboard)
library(dplyr)
library(shinythemes)
library(ggplot2)

# theme = shinythemes::shinytheme("cyborg")
data.final<-read.csv(file ="data/datos_pib.csv", encoding = 'UTF-8')
data.final <- data.final[,-1]
