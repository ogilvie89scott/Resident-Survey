#
server <- function(input, output, session) {
  output$Mosaic <- renderPlot({
    graphics::mosaicplot(
      ~ kcmofy2022_b[[input$xcol]] + kcmofy2022_c[[input$ycol]],
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
    filename = function() {
      paste("kcmofy22_mosaic", "png", sep = ".")
    },
    content = function(file) {
      png(file)
      graphics::mosaicplot(
        ~ kcmofy2022_b[[input$xcol]] + kcmofy2022_c[[input$ycol]],
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
    })
  
  output$PlotXtabs <- renderPlot({
    purrr::map2(
      .x = input$xcol,
      .y = input$ycol,
      .f =  ~ PlotXTabs2(
        x = all_of(.x),
        title = "PlotXTabs2",
        data = kcmofy2022_b,
        y = all_of(.y),
        legend.title = input$ycol,
        xlab = input$xcol,
        ylab = NULL,
        label.fill.alpha = .9,
        perc.k = 0,
        sample.size.label = T,
        direction = 1,
        plottype = "percent",
        data.label = "both",
        results.subtitle = ,
        label.text.size = 4,
        mosaic.offset = .01,
        x.axis.orientation = "slant",
        ggtheme = ggplot2::theme_classic(base_size = 14, base_family =),
        ggplot.component = e1
        
      )
    )
  })
  
  output$table <- renderDataTable({
    CRAMV <-lapply(kcmofy2022_b[,-1], function(x)
        rcompanion::cramerV(table(x, kcmofy2022_b[[input$ycol]])))
    CRAMVTAB <- data.table::rbindlist(lapply(CRAMV, tidy), idcol = TRUE)
    CRAMVTAB <- CRAMVTAB %>%
      filter(x != "Inf" & x != 1.0000)
    CRAMVTAB <- CRAMVTAB %>%
      filter(x > .17)
    CRAMVTAB <- CRAMVTAB %>% dplyr::select(c(.id, x))
    names(CRAMVTAB) <- c('Variable', "Cramer's V")
    CRAMVTAB <- dplyr::arrange(CRAMVTAB, desc(`Cramer's V`))
    CRAMVTAB
  })
  
  output$simpley <- renderPlot({
    kcmofy2022_b %>%
      ggplot(aes(
        x = kcmofy2022_b[[input$ycol]],
        y = proportions(stat(count)),
        label = scales::percent(prop.table(stat(count)), accuracy = 1)
      )) +
      geom_bar(fill = rgb(52, 148, 186, maxColorValue = 255))   +
      theme(panel.grid.major = element_line(colour = NA)) +
      scale_y_continuous(labels = scales::percent_format(accuracy = 5L)) +
      theme_classic()  +
      labs(title = input$ycol,
           y = "Percent",
           x = input$ycol) +
      geom_label(
        stat = 'count',
        position = position_dodge(.9),
        vjust = 0.5,
        size = 4
      )
  })
  
  output$simplex <- renderPlot({
    kcmofy2022_b %>%
      ggplot(aes(
        x = kcmofy2022_b[[input$xcol]],
        y = proportions(stat(count)),
        label = scales::percent(prop.table(stat(count)), accuracy = 1)
      )) +
      geom_bar(fill = rgb(52, 148, 186, maxColorValue = 255))   +
      theme(panel.grid.major = element_line(colour = NA)) +
      scale_y_continuous(labels = scales::percent_format(accuracy = 5L)) +
      theme_classic()  +
      labs(title = input$xcol,
           y = "Percent",
           x = input$xcol) +
      geom_label(
        stat = 'count',
        position = position_dodge(.9),
        vjust = 0.5,
        size = 4
      )
  })
}
