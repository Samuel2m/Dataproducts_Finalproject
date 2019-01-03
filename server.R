library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)


dataWine <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv", sep = ";")
dataWineCors <- names(which(abs(cor(dataWine)[,12]) > 0.2))
data <- dataWine %>% 
    select(dataWineCors) %>% 
    mutate(quality = as.factor(quality))


server <- function(input, output) {
    
    dataLM <- reactive({ 
    
    dataX <- data
        
    if(input$VA_box){
    dataX <- dataX %>%
        filter(between(volatile.acidity, input$VA_slider[1], input$VA_slider[2]))
    }

    
    if(input$CA_box & nrow(dataX) > 0 ){
        dataX <- dataX %>%
            filter(between(citric.acid, input$CA_slider[1], input$CA_slider[2]))
    }

    if(input$S_box & nrow(dataX) > 0 ){
        dataX <- dataX %>%
            filter(between(sulphates, input$S_slider[1], input$S_slider[2]))
    }

    if(input$A_box & nrow(dataX) > 0 ){
        dataX <- dataX %>%
            filter(between(alcohol, input$A_slider[1], input$A_slider[2]))
    }

    dataX
    
    })
    
    
    output$WQ <- renderPlotly({
        validate(need(nrow(dataLM()) > 0, "Filters are too restrictive"))
        ggplotly(ggplot(dataLM(), aes(quality)) + 
                                geom_histogram(stat = "count", fill = "darkblue") + 
                                theme_bw() + xlab("Quality of the wine") + 
                                ggtitle("Repartition of the quality of the wines") + 
                                theme(plot.title = element_text(hjust = 0.5)))})
    
    output$VQ <- renderPlotly({
        validate(need(nrow(dataLM()) > 0, "Filters are too restrictive"))
        ggplotly(ggplot(dataLM(), aes(quality, volatile.acidity, col = quality)) + 
                                geom_boxplot() + 
                                theme_bw() + xlab("Quality of the wine") + ylab("Volatile acidity") + 
                                ggtitle("Quality of the wine VS the volatile acidity") + 
                                theme(plot.title = element_text(hjust = 0.5), legend.position="none"))})
    
    output$CQ <- renderPlotly({
        validate(need(nrow(dataLM()) > 0, "Filters are too restrictive"))
        ggplotly(ggplot(dataLM(), aes(quality, citric.acid, col = quality)) + 
                                    geom_boxplot() + 
                                    theme_bw() + xlab("Quality of the wine") + ylab("Citric acid") + 
                                    ggtitle("Quality of the wine VS the citric acid") + 
                                    theme(plot.title = element_text(hjust = 0.5), legend.position="none"))})
    
    output$SQ <- renderPlotly({
        validate(need(nrow(dataLM()) > 0, "Filters are too restrictive"))
        ggplotly(ggplot(dataLM(), aes(quality, sulphates, col = quality)) + 
                                    geom_boxplot() + 
                                    theme_bw() + xlab("Quality of the wine") + ylab("Sulphates") +
                                    ggtitle("Quality of the wine VS the sulphates") + 
                                    theme(plot.title = element_text(hjust = 0.5), legend.position="none"))})
    
    output$AQ <- renderPlotly({
        validate(need(nrow(dataLM()) > 0, "Filters are too restrictive"))
        ggplotly(ggplot(dataLM(), aes(quality, alcohol, col = quality)) + 
                                    geom_boxplot() + 
                                    theme_bw() + xlab("Quality of the wine") + ylab("Alcohol") +
                                    ggtitle("Quality of the wine VS the alcohol") + 
                                    theme(plot.title = element_text(hjust = 0.5), legend.position="none"))})

    }