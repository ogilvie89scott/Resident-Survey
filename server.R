# ********** Start of Header **************
# Title: Server for Resident Survey app
#
# This code tells the app what to do with the inputs from the UI
#
# Author: Scott Ogilvie
# Date: 05/25/2022
#
# *********** End of header ****************
# SERVER CODE----
server <- function(input, output, session) { 
  ## DEFINE REACTIVES----
  datasetInput <- reactive({ # These next lines of code are what allows for us to select specific data from the datasets. 
    if (input$dontknows == "Yes") { # What happens when the "Don't Know" button is on Yes.
      dataset <- resident_survey
    }
    else if (input$dontknows == "No") { # What happens when the "don't know" is on No.
      dataset <- resident_survey_nodk
    }
    return(dataset) # Based on the above, the dataset is selected.
  })
  quarter_data <- reactive({ # Lines 12-16 are code to filter by quarter.
    req(input$qrter)
    quart_subset <-
      subset(datasetInput(), `quarter` %in% input$qrter)
  })
  ## MOSAIC----
  output$Mosaic <- renderPlot({ # The code for the Mosaic Plot.
    graphics::mosaicplot(
      ~ quarter_data()[[input$xcol]] + quarter_data()[[input$ycol]], # Notice the data is "quarter_data()" not "quarter_data".
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
  
  output$downloadMosaic <- downloadHandler( # Copy-Paste the above with some additional code for th download button.
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
        ~ quarter_data()[[input$xcol]] + quarter_data()[[input$ycol]],
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
  # PLOTXTABS2----
  output$PlotXtabs <- renderPlot({
    pxt <- PlotXTabs2(
      x = input$xcol,
      title = "Relationship between Variables",
      data = quarter_data(),
      y = input$ycol,
      legend.title =  input$ycol, # You could change this to a generic "Y Variable Selected:"
      xlab = input$xcol,
      ylab = "Percent of Column",
      label.fill.alpha = .9,
      legend.position= "top", # You can change the legend position to left, right or bottom as well.
      perc.k = 0,
      sample.size.label = T,
      k=1,
      bf.details= F,
      bf.display= "support" ,
      direction = -1,
      plottype = "percent",
      x.axis.orientation = "slant",
      ggtheme = ggplot2::theme_classic(base_size = 14),
      ggplot.component = e1
    )
    pxt<- pxt + scale_y_reverse()
   print(pxt)

  })
  output$downloadplotx <- downloadHandler( # Download Handler works the same as the Mosaic one.
    filename = function() {#specify file name
      paste("plotxtabs2", ".pdf", sep = ".")
    },
    content = function(file) {#open device, write the plot,close the device
      pdf(file)
      pxt <- PlotXTabs2(
        x = input$xcol,
        title = "Relationship between Variables",
        data = quarter_data(),
        y = input$ycol,
        legend.title =  "Y Variable Selected",
        xlab = input$xcol,
        ylab = "Percent of Column",
        label.fill.alpha = .9,
        legend.position= "top",
        perc.k = 0,
        sample.size.label = T,
        k=1,
        bf.details= F,
        bf.display= "support" ,
        direction = -1,
        plottype = "percent",
        x.axis.orientation = "slant",
        ggtheme = ggplot2::theme_classic(base_size = 14, base_family = ),
        ggplot.component = e1
      )
      print(pxt)
      dev.off()
    }
  )
  ## CRAMER'S v----
  output$table <- renderDataTable({
    cv1<-quarter_data() %>% # Taking out the y/n questions to avoid misuse of Cramer's V.
      dplyr::select(!(q31_01_were_you_or_anyone_in_your_household_the_victim_of_any_crime_in_kansas_city_missouri_during_the_last_year:q31_22_are_you_aware_of_the_kc_spirit_playbook_the_citys_initiative_to_update_its_comprehensive_plan))
    CRAMV <- lapply(cv1[, -1], function(x)
      rcompanion::cramerV(table(x, cv1[[input$ycol]])))
    cramervtable <- as.data.frame(CRAMV)
    cramervtable <- t(cramervtable)
    cramervtable <- as.data.frame(cramervtable)
    cramervtable <- tibble::rownames_to_column(cramervtable, "Variable")
    cramervtable <- cramervtable %>%
      filter(`Cramer V` != "Inf" & `Cramer V` != 1.0000)
    cramervtable <- cramervtable %>%
      filter(`Cramer V` > .10)
    cramervtable <- dplyr::arrange(cramervtable, desc(`Cramer V`))
    cramervtable
  })
  ## PLOTLY GRAPH----
  output$simplex <- renderPlotly({ # Creates the plot in the bottom right.
    quarter_data_rev <- lapply(quarter_data(),fct_rev)
    plot_ly( x = ~quarter_data()[[input$xcol]], color = ~quarter_data_rev[[input$ycol]]) |>
      add_histogram()|>
      layout(title = "",
             xaxis = list(title = input$xcol,
                          showgrid = F,
                          showline = FALSE,
                          showticklabels = TRUE,
                          ticks = 'outside',
                          zeroline = FALSE),
             yaxis = list(title = "Count",
                          showgrid = F,
                          showline = FALSE,
                          showticklabels = TRUE,
                          ticks = 'outside',
                          zeroline = FALSE),
             legend = list(title = list(text=input$ycol)))
  })
}