#
server <- function(input, output, session) {
  ## AUG 2021 ----------------------------------------------
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
      type = "deviance"
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
        title = "Relationship between Variables",
        data = kcmofy2022_b,
        y = all_of(.y),
        legend.title =  "Y Variable Selected",
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
      filter(x > .10)
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
  ## MAR 2022-----------------------------
  output$Mosaic_2 <- renderPlot({
    graphics::mosaicplot(
      ~ kcmo_mar_2022[[input$xcol2]] + kcmo_mar_2022_c[[input$ycol2]],
      xlab = input$xcol2,
      ylab = input$ycol2, 
      color = TRUE,
      shade = TRUE,
      las = 1,
      main = "Mosaic Plot",
      cex.axis = .656,
      type = "pearson"
    )
  })
  
  output$downloadMosaic_2 <- downloadHandler(
    filename = function() {
      paste("kcmofy22_mosaic", "png", sep = ".")
    },
    content = function(file) {
      png(file)
      graphics::mosaicplot(
        ~ kcmo_mar_2022[[input$xcol2]] + kcmo_mar_2022_c[[input$ycol2]],
        xlab = input$xcol2,
        ylab = input$ycol2,
        color = TRUE,
        shade = TRUE,
        las = 1,
        main = "Mosaic Plot",
        cex.axis = .656,
        type = "pearson"
      )
      dev.off()
    })
  
  output$PlotXtabs_2 <- renderPlot({
    purrr::map2(
      .x = input$xcol2,
      .y = input$ycol2,
      .f =  ~ PlotXTabs2(
        x = all_of(.x),
        title = "Relationship between Variables",
        data = kcmo_mar_2022,
        y = all_of(.y),
        legend.title = "Y Variable Selected",
        xlab = input$xcol2,
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
  
  output$table_2 <- renderDataTable({
    CRAMV <-lapply(kcmo_mar_2022[,-1], function(x)
      rcompanion::cramerV(table(x, kcmo_mar_2022[[input$ycol2]])))
    CRAMVTAB <- data.table::rbindlist(lapply(CRAMV, tidy), idcol = TRUE)
    CRAMVTAB <- CRAMVTAB %>%
      filter(x != "Inf" & x != 1.0000)
    CRAMVTAB <- CRAMVTAB %>%
      filter(x > .10)
    CRAMVTAB <- CRAMVTAB %>% dplyr::select(c(.id, x))
    names(CRAMVTAB) <- c('Variable', "Cramer's V")
    CRAMVTAB <- dplyr::arrange(CRAMVTAB, desc(`Cramer's V`))
    CRAMVTAB
  })
  
  output$simpley_2 <- renderPlot({
    kcmo_mar_2022 %>%
      ggplot(aes(
        x = kcmo_mar_2022[[input$ycol2]],
        y = proportions(stat(count)),
        label = scales::percent(prop.table(stat(count)), accuracy = 1)
      )) +
      geom_bar(fill = rgb(52, 148, 186, maxColorValue = 255))   +
      theme(panel.grid.major = element_line(colour = NA)) +
      scale_y_continuous(labels = scales::percent_format(accuracy = 5L)) +
      theme_classic()  +
      labs(title = input$ycol2,
           y = "Percent",
           x = input$ycol2) +
      geom_label(
        stat = 'count',
        position = position_dodge(.9),
        vjust = 0.5,
        size = 4
      )
  })
  
  output$simplex_2 <- renderPlot({
    kcmo_mar_2022 %>%
      ggplot(aes(
        x = kcmo_mar_2022[[input$xcol2]],
        y = proportions(stat(count)),
        label = scales::percent(prop.table(stat(count)), accuracy = 1)
      )) +
      geom_bar(fill = rgb(52, 148, 186, maxColorValue = 255))   +
      theme(panel.grid.major = element_line(colour = NA)) +
      scale_y_continuous(labels = scales::percent_format(accuracy = 5L)) +
      theme_classic()  +
      labs(title = input$xcol2,
           y = "Percent",
           x = input$xcol2) +
      geom_label(
        stat = 'count',
        position = position_dodge(.9),
        vjust = 0.5,
        size = 4
      )
  })  
}

