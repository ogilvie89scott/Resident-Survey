#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(plotly)
library(forcats)
library(CGPfunctions)
library(lintr)
{kcmofy2022_b <-
    read.csv(file = "FY2022_RS_Cleaned.csv")
  # make some adjustments to the data, specifically changing variables to factors
  #"q5_02_", "q14_01", "q14_02", "q25_d",
  #"q28_h","q29_t", "q30_t", "q31_08", "q31_09", 
  #"q31_10", "q31_14", "q31_16", "q31_20", "q34_d",
  #"q37_race", "q39_w", "q40_w"
  kcmofy2022_b<-dplyr::select(kcmofy2022_b, c( "q5_02", "q14_01", "q14_02", 
                                               "q25_d", "q28_h","q29_t",
                                               "q30_t", "q31_08", "q31_09", 
                                               "q31_10", "q31_14", "q31_16", 
                                               "q31_20", "q34_d",
                                               "q37_race", "q39_w", "q40_w", 
                                               "q26_01", 
                                               "q26_02", "q27_01", "q27_02",
                                               "q27_03", "q32_01",
                                               "q32_02", "q32_03", "q32_04"))
  kcmofy2022_b<-kcmofy2022_b[,order(colnames(kcmofy2022_b))]  }
## adjust the variables
{kcmofy2022_b$q5_02 <- factor(
  kcmofy2022_b$q5_02,
  levels = c(1, 2, 3, 4, 5),
  labels = c(
    "Very Dissatisfied",
    "Dissatisfied",
    "Neutral",
    "Satisfied",
    "Very Satisfied"
  ),
  ordered = TRUE
)
  # Question 14
  kcmofy2022_b[, 1:2] <- lapply(
    kcmofy2022_b[, 1:2],
    factor,
    levels = c(1, 2, 3, 4, 5),
    labels = c(
      "Very Dissatisfied",
      "Dissatisfied",
      "Neutral",
      "Satisfied",
      "Very Satisfied"
    ),
    ordered = TRUE
  )
  kcmofy2022_b$q25_d <- factor(
    kcmofy2022_b$q25_d,
    levels = c(4, 3, 2, 1),
    labels = c(
      "Strongly Disagree",
      "Disagree",
      "Agree",
      "Strongly Agree"
    ),
    ordered = TRUE
)
  ## q26 
  kcmofy2022_b[, 4:5] <- lapply(
    kcmofy2022_b[, 4:5],
    factor,
    levels = c(4, 3, 2, 1, 9),
    labels = c(
      "At least daily ",
      "At least weekly ",
      "At least once ",
      "Never ",
      "Don't Know"
    ),
    ordered = TRUE
  )
  ## 27
  kcmofy2022_b[, 6:8] <- lapply(
    kcmofy2022_b[, 6:8],
    factor,
    levels = c(4, 3, 2,1 ,9),
    labels = c(
      "At least monthly ",
      "Several times  ",
      "Once ",
      "Never ",
      "Don't Know"
    ),
    ordered = TRUE
  )
  ## 32
  kcmofy2022_b[, 18:21] <- lapply(
    kcmofy2022_b[, 18:21],
    factor,
    levels = c(9, 1, 2, 3, 4, 5),
    labels = c("Don't Know",
               "Very Dissatisfied",
               "Dissatisfied",
               "Neutral",
               "Satisfied",
               "Very Satisfied"
    ),
    ordered = TRUE
  )
  kcmofy2022_b$q28_h <- factor(
    kcmofy2022_b$q28_h,
    levels = c(5, 4, 3, 2, 1),
    labels = c("Poor", "Fair", "Good", "Very Good", "Excellent"),
    ordered = TRUE
  )
  kcmofy2022_b$q29_t <- factor(
    kcmofy2022_b$q29_t,
    levels = c(5, 4, 3, 2, 1),
    labels = c("Poor", "Fair", "Good", "Very Good", "Excellent"),
    ordered = TRUE
  )
  kcmofy2022_b$q30_t <- factor(
    kcmofy2022_b$q30_t,
    levels = c(5, 4, 3, 2, 1),
    labels = c(
      "Much Worse",
      "Somewhat Worse",
      "About the Same",
      "Somewhat Better",
      "Much Better"),
    ordered = TRUE
  )
  # Question 31
  kcmofy2022_b[, 12:17] <- lapply(kcmofy2022_b[, 12:17],
                                  factor,
                                  levels = c(2, 1),
                                  labels = c("No", "Yes"),
                                  ordered = TRUE
  )
  # Question 34
  kcmofy2022_b$q34_d <- factor(kcmofy2022_b$q34_d,
                               levels = c(2, 1),
                               labels = c("Rent", "Own"),
                               ordered = TRUE
  )
  # Question 39
  kcmofy2022_b$q39_w <- factor(
    kcmofy2022_b$q39_w,
    levels = c(1, 2, 3, 4),
    labels = c(
      "Under $30,000",
      "$30,000 to $59,999",
      "$60,000 to $99,999",
      "$100,000 or more"
    ),
    ordered = TRUE
  )
  # Question 40
  kcmofy2022_b$q40_w <- factor(
    kcmofy2022_b$q40_w,
    levels = c(1, 2, 3, 4, 5, 6),
    labels = c("18-24", "25-34", "35-44", "45-54", "55-64", "65+"),
    ordered = TRUE
  )
  kcmofy2022_b$q37_race <- as.factor(kcmofy2022_b$q37_race)
  # Rename columns
  names(kcmofy2022_b) <- c( "Availability of Afforable Housing", 
                            "Quality of Housing",
                            "Can Count on Someone to Help",  
                            "Had personal conversations with people of a different race or ethnicity than you ",
                            "Had personal conversations with people who have different political views than you ",
                            "Attended any public meeting in which there was discussion of local government affairs",
                            "Tried to get your local government to pay attention to something that concerned you",
                            "Had friends of another race over to your home",
                            "Self-Reported Health",
                            "Financial Situation", 
                            "Standard of Living Compared to Parents", 
                            "Visited a Park", 
                            "Used a Bus", 
                            "Used the Streetcar", 
                            "Flown out of Airport", 
                            "Biking",
                            "Had Rent Stress",
                            "Job opportunities available within the city limits of Kansas City ",
                            "Ability to obtain training opportunities to advance your career ",
                            "Support for entrepreneurs and small business owners available in Kansas City ",
                            "City's use of economic development incentives to support economic opportunity for residents ",
                            "Own or Rent",
                            "Race", 
                            "Income",
                            "Age",
                            "Police and Nieghborhood Relationship")
  
}
kcmofy2022_c<-kcmofy2022_b
# create a copy that reverses the order to use on the Y axis
KCMOFY2022_C[,1:26] <- lapply(KCMOFY2022_C[,1:26],fct_rev)
cbPalette <-  c(rgb(52,148,186, maxColorValue=255),
                rgb(127,193,219, maxColorValue=255),
                rgb(175,186,187, maxColorValue=255),
                rgb(237,179,109, maxColorValue=255),
                rgb(205,125,25, maxColorValue=255))

cbPalette<-rev(cbPalette)

e1 <-scale_fill_manual(values =cbPalette)
# Define UI for application that draws a histogram
ui <- dashboardPage(skin = "black",
  dashboardHeader(title = "Kansas City Resident Survey"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Mosaic", tabName = "Mosaic", icon = icon("tree")),
      menuItem("PlotXtabs", tabName = "PlotXtabs", icon = icon("cat"))
    )
  ),
  dashboardBody(

    tabItems(
      tabItem("Mosaic",
              box(id = "mosaic_container",
                  plotOutput("Mosaic", height = 750), width = 8),
              box(
                selectInput("ycol", "Y Variables:",
                            c('Availability of Afforable Housing', 
                              'Quality of Housing',
                              "Can Count on Someone to Help", 
                              "Had personal conversations with people of a different race or ethnicity than you ",
                              "Had personal conversations with people who have different political views than you ",
                              "Attended any public meeting in which there was discussion of local government affairs",
                              "Tried to get your local government to pay attention to something that concerned you",
                              "Had friends of another race over to your home",
                              'Self-Reported Health',
                              'Financial Situation', 
                              "Standard of Living Compared to Parents", 
                              'Visited a Park', 
                              'Used a Bus', 
                              'Used the Streetcar', 
                              'Flown out of Airport', 
                              "Biking",
                              'Had Rent Stress',
                              "Job opportunities available within the city limits of Kansas City ",
                              "Ability to obtain training opportunities to advance your career ",
                              "Support for entrepreneurs and small business owners available in Kansas City ",
                              "City's use of economic development incentives to support economic opportunity for residents ",
                              'Own or Rent',
                              'Race', 
                              'Income',
                              'Age',
                              'Police and Nieghborhood Relationship')), width = 4),
              box(
                selectInput("xcol", "X Variables:",
                            c('Availability of Afforable Housing', 
                              'Quality of Housing',
                              "Can Count on Someone to Help", 
                              "Had personal conversations with people of a different race or ethnicity than you ",
                              "Had personal conversations with people who have different political views than you ",
                              "Attended any public meeting in which there was discussion of local government affairs",
                              "Tried to get your local government to pay attention to something that concerned you",
                              "Had friends of another race over to your home",
                              'Self-Reported Health',
                              'Financial Situation', 
                              "Standard of Living Compared to Parents", 
                              'Visited a Park', 
                              'Used a Bus', 
                              'Used the Streetcar', 
                              'Flown out of Airport', 
                              "Biking",
                              'Had Rent Stress',
                              "Job opportunities available within the city limits of Kansas City ",
                              "Ability to obtain training opportunities to advance your career ",
                              "Support for entrepreneurs and small business owners available in Kansas City ",
                              "City's use of economic development incentives to support economic opportunity for residents ",
                              'Own or Rent',
                              'Race', 
                              'Income',
                              'Age',
                              'Police and Nieghborhood Relationship')), width = 4)
      ),
      tabItem("PlotXtabs",
              box(id = "plotx_container",
                  plotOutput("PlotXtabs", height = 750), width = 8),
              
              box(
                selectInput("ycol1", "Y Variables:",
                            c('Availability of Afforable Housing', 
                              'Quality of Housing',
                              "Can Count on Someone to Help", 
                              "Had personal conversations with people of a different race or ethnicity than you ",
                              "Had personal conversations with people who have different political views than you ",
                              "Attended any public meeting in which there was discussion of local government affairs",
                              "Tried to get your local government to pay attention to something that concerned you",
                              "Had friends of another race over to your home",
                              'Self-Reported Health',
                              'Financial Situation', 
                              "Standard of Living Compared to Parents", 
                              'Visited a Park', 
                              'Used a Bus', 
                              'Used the Streetcar', 
                              'Flown out of Airport', 
                              "Biking",
                              'Had Rent Stress',
                              "Job opportunities available within the city limits of Kansas City ",
                              "Ability to obtain training opportunities to advance your career ",
                              "Support for entrepreneurs and small business owners available in Kansas City ",
                              "City's use of economic development incentives to support economic opportunity for residents ",
                              'Own or Rent',
                              'Race', 
                              'Income',
                              'Age',
                              'Police and Nieghborhood Relationship')), width = 4),
              box(
                selectInput("xcol1", "X Variables:",
                            c('Availability of Afforable Housing', 
                              'Quality of Housing',
                              "Can Count on Someone to Help", 
                              "Had personal conversations with people of a different race or ethnicity than you ",
                              "Had personal conversations with people who have different political views than you ",
                              "Attended any public meeting in which there was discussion of local government affairs",
                              "Tried to get your local government to pay attention to something that concerned you",
                              "Had friends of another race over to your home",
                              'Self-Reported Health',
                              'Financial Situation', 
                              "Standard of Living Compared to Parents", 
                              'Visited a Park', 
                              'Used a Bus', 
                              'Used the Streetcar', 
                              'Flown out of Airport', 
                              "Biking",
                              'Had Rent Stress',
                              "Job opportunities available within the city limits of Kansas City ",
                              "Ability to obtain training opportunities to advance your career ",
                              "Support for entrepreneurs and small business owners available in Kansas City ",
                              "City's use of economic development incentives to support economic opportunity for residents ",
                              'Own or Rent',
                              'Race', 
                              'Income',
                              'Age',
                              'Police and Nieghborhood Relationship')), width = 4)
      
      )
)

)  

)

# Define server logic required to draw a histogram
server <- function(input, output) {

output$Mosaic <- renderPlot({
    graphics::mosaicplot(~KCMOFY2022_B[[input$xcol]]+ KCMOFY2022_C[[input$ycol]],
         xlab = input$xcol,
         ylab = input$ycol,
         color = TRUE,
         shade = TRUE,
         las = 1,
         main = "Mosaic Plot",
         cex.axis = .656,
         type = "pearson")
})
output$PlotXtabs <- renderPlot({
  purrr::map2(.x = input$xcol1,
              .y = input$ycol1,
              .f =  ~ PlotXTabs2(x = all_of(.x),
                                 title = ,
                                 data = kcmofy2022_b,
                                 y = all_of(.y),
                                 legend.title = input$ycol1,
                                 xlab = input$xcol1,
                                 ylab = NULL,
                                 label.fill.alpha = .9,
                                 perc.k = 0,
                                 sample.size.label=F,
                                 direction = 1,
                                 plottype = "percent",
                                 data.label = "both",
                                 results.subtitle = ,
                                 label.text.size=5,
                                 mosaic.offset= .01,
                                 x.axis.orientation= "slant",
                                 ggtheme = ggplot2::theme_classic(base_size = 14, base_family = ),
                                 ggplot.component = e1
                                 
              )
  )
})
}

# Run the application 
shinyApp(ui = ui, server = server)
