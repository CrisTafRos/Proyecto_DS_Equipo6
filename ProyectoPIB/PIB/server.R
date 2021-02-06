
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        
        fecha <- input$fecha
        
        
        df.grafico <- data.final[data.final$year <= fecha, ]
        
        ggplot(df.grafico, aes(x = year, y = PIB)) + 
            geom_line(color = "#00AFBB", size = 0.7) + 
            geom_point(color = "#040829", size =0.7) +
            labs(title = paste("PIB en México del año 1980 a",input$fecha),
                 x = "Año",
                 y = "PIB (millones de pesos)",
                 subtitle = paste("PIB", tail(df.grafico$PIB,1))) +
            theme_minimal() +
            theme(plot.title = element_text(vjust = 1, hjust = 0.5, face = "bold", size = 19),
                  axis.title.x = element_text(face = "plain", vjust = -1.5, size = 16),
                  axis.title.y = element_text(face = "plain", vjust = 2, size = 16),
                  plot.subtitle = element_text(face = "bold", vjust = -100, hjust = 1, size = 13))
        
        
        
    })
    
    
    output$base <- renderDataTable({data.final}, 
                                   options = list(aLengthMenu = c(10, 15, 20),
                                                  iDisplayLength = 10))

})
