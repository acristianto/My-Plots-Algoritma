function(input, output){
  ratingrv <- reactive({
    
    ratingOpt <- input$ratingOpt
    
    data_output<- film %>%
      filter(mpaa_rating == ratingOpt) %>% 
      select(genre, global_ratio, mpaa_rating) %>% 
      group_by(mpaa_rating, genre) %>% 
      summarise(global_ratio = mean(global_ratio),
                global_ratio = round(global_ratio)) %>% 
      ungroup() %>% 
      mutate(
        mpaa_rating = reorder(mpaa_rating, global_ratio),
        text = paste("Global Ratio:", global_ratio))
    return(data_output)
  })
  
  output$ratingPlot <- renderPlotly({
    
  data_input <- ratingrv()
  
  rating<- ggplot(data_input, aes(x = genre, y= global_ratio, text = text))+
    geom_col(fill = "skyblue")+
    labs( x = NULL,
          y= "Global Ratio")+
    geom_hline(yintercept = 2.0, color = "darkred")+
    coord_flip()+
    theme_minimal()
  output_object <- ggplotly(rating, tooltip = "text")
  return(output_object)
  })
  

  densityrv <- reactive({
    densityOpt <- input$densityOpt
    
    data_output <-film %>%
      filter(mpaa_rating == densityOpt) %>% 
      select(genre, mpaa_rating, worldwide_gross) %>% 
      group_by(mpaa_rating, genre) %>% 
      ungroup()
    return(data_output)
  })
  
  output$densityPlot <- renderPlot({
    
    data_input <- densityrv()
    d <- ggplot(data_input, aes(x= worldwide_gross,
                                y= genre,
                                fill = genre))+
      geom_density_ridges2(alpha = 0.4)+
      labs(y = NULL,
           x = "Worldwide_Gross")+
      theme_minimal()+
        theme(legend.position = "none")
    output_object <- d
    return(output_object)
  })
}