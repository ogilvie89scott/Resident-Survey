#
server <- function(input, output, session) {
  ## Resident Survey ----------------------------------------------
  
  datasetInput <- reactive({
    if (input$dontknows == "Yes") {
      dataset <- resident_survey
    }
    else if (input$dontknows == "No") {
      dataset <- resident_survey_nodk
    }
    return(dataset)
  })
  result <- reactive({
    req(input$qrter)
    quart_subset <-
      subset(datasetInput(), `quarter` %in% input$qrter)
  })
  
  
  
  output$Mosaic <- renderPlot({
    graphics::mosaicplot(
      ~ result()[[input$xcol]] + result()[[input$ycol]],
      xlab = input$xcol,
      ylab = input$ycol,
      color = TRUE,
      shade = TRUE,
      las = 1,
      main = "Mosaic Plot",
      cex.axis = .656,
      type = "pearson"
    )
  })
  
  output$downloadMosaic <- downloadHandler(
    #specify file name
    filename = function() {
      paste("mosaic", "png", sep = ".")
      
    },
    content = function(file) {
      #open device
      #write the plot
      #close the device
      png(file)
      graphics::mosaicplot(
        ~ result()[[input$xcol]] + result()[[input$ycol]],
        xlab = input$xcol,
        ylab = input$ycol,
        color = TRUE,
        shade = TRUE,
        las = 1,
        main = "Mosaic Plot",
        cex.axis = .656,
        type = "pearson"
      )
      dev.off()
    }
  )
  
  
  output$PlotXtabs <- renderPlot({
    pxt <- PlotXTabs2(
      x = input$xcol,
      title = "Relationship between Variables",
      data = result(),
      y = input$ycol,
      legend.title =  "Y Variable Selected",
      xlab = input$xcol,
      ylab = "Percent of Column",
      label.fill.alpha = .9,
      perc.k = 0,
      sample.size.label = T,
      direction = 1,
      plottype = "percent",
      x.axis.orientation = "slant",
      ggtheme = ggplot2::theme_classic(base_size = 14, base_family = ),
      ggplot.component = e1
      
    )
    print(pxt)
    
  })
  output$downloadplotx <- downloadHandler(
    #specify file name
    filename = function() {
      paste("plotxtabs2", ".pdf", sep = ".")
      
    },
    content = function(file) {
      #open device
      #write the plot
      #close the device
      pdf(file)
      pxt <- PlotXTabs2(
        x = input$xcol,
        title = "Relationship between Variables",
        data = result(),
        y = input$ycol,
        legend.title =  "Y Variable Selected",
        xlab = input$xcol,
        ylab = "Percent of Column",
        perc.k = 0,
        sample.size.label = T,
        direction = 1,
        plottype = "percent",
        results.subtitle = ,
        x.axis.orientation = "slant",
        ggtheme = ggplot2::theme_classic(base_size = 14, base_family =
        ),
        ggplot.component = e1
        
      )
      print(pxt)
      dev.off()
    }
  )
  
  
  output$table <- renderDataTable({
    CRAMV <- lapply(result()[, -1], function(x)
      rcompanion::cramerV(table(x, result()[[input$ycol]])))
    cramervtable <- as.data.frame(CRAMV)
    cramervtable <- t(cramervtable)
    cramervtable <- as.data.frame(cramervtable)
    cramervtable <-
      tibble::rownames_to_column(cramervtable, "Variable")
    cramervtable <- cramervtable %>%
      filter(`Cramer V` != "Inf" & `Cramer V` != 1.0000)
    cramervtable <- cramervtable %>%
      filter(`Cramer V` > .10)
    cramervtable <- dplyr::arrange(cramervtable, desc(`Cramer V`))
    cramervtable
  })
  
  
  output$simpley <- renderPlotly({
    g1 <- result() %>%
      ggplot(aes(
        x = result()[[input$ycol]],
        y = proportions(stat(count)),
        label = scales::percent(proportions(stat(count)), accuracy = 1)
      )) +
      geom_bar(fill = rgb(52, 148, 186, maxColorValue = 255))   +
      theme(panel.grid.major = element_line(colour = NA)) +
      scale_y_continuous(labels = scales::percent_format(accuracy = 5L)) +
      theme_classic()  +
      labs(title = input$ycol,
           y = "Percent",
           x = input$ycol)
    ggplotly(g1)
    
    
  })
  
  
  
  
  output$simplex <- renderPlotly({
    g2 <- result() %>%
      ggplot(aes(
        x = result()[[input$xcol]],
        y = proportions(stat(count)),
        label = scales::percent(prop.table(stat(count)), accuracy = 1)
      )) +
      geom_bar(fill = rgb(52, 148, 186, maxColorValue = 255))   +
      theme(panel.grid.major = element_line(colour = NA)) +
      scale_y_continuous(labels = scales::percent_format(accuracy = 5L)) +
      theme_classic()  +
      labs(title = input$xcol,
           y = "Percent",
           x = input$xcol)
    
    ggplotly(g2)
  })
}