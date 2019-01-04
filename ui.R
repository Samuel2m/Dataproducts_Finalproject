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
                    value = c(9.5, 11.1)),
        
        h6("This application uses a data set from the UCI repository on red wine quality"),
        h6("The above filters concern the variables which have the most impact of the quality"),
        h6("The checkbox allow you to chose if you want to use the filter"),
        h6("The sliders to select the ranges on the variables, by default between the first and third quartile"),
        h6("The filters apply to all the tabs (one tab per variable selected)"),
        h6("I did not implement a predictive model, as just applying the filters dynamically needs reactive expressions, main topic of the project")
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
