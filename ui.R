library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

dataWine <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", sep = ";")
dataWineCors <- names(which(abs(cor(dataWine)[,12]) > 0.2))
data <- dataWine %>% 
    select(dataWineCors) %>% 
    mutate(quality = as.factor(quality))


ui <- fluidPage(
    
    # Application title
    titlePanel("Wine quality"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
        checkboxInput("VA_box", "Include volatile acidity filter:", value = T),
            sliderInput("VA_slider",
                        "Volatile acidity",
                        min = 0,
                        max = 2,
                        value = c(0.39, 0.64),
                        step = 0.01),
        checkboxInput("CA_box", "Include citric acid filter:", value = T),
        sliderInput("CA_slider",
                        "Citric acid",
                        min = 0,
                        max = 1,
                        value = c(0.09, 0.420)),
        checkboxInput("S_box", "Include sulphates filter:", value = T),
        sliderInput("S_slider",
                    "Sulphates",
                    min = 0,
                    max = 2,
                    c(0.55, 0.73),
                    step = 0.01),
        checkboxInput("A_box", "Include alcohol filter:", value = T),
        sliderInput("A_slider",
                    "Alcohol",
                    min = 0,
                    max = 15,
                    value = c(9.5, 11.1))
        ),

        
        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                tabPanel("Wine quality", plotlyOutput("WQ")),
                tabPanel("Volatile acidity", plotlyOutput("VQ")),
                tabPanel("Citric acid", plotlyOutput("CQ")),
                tabPanel("Sulphates", plotlyOutput("SQ")),
                tabPanel("Alcohol", plotlyOutput("AQ"))
            )
        )
    )
)
