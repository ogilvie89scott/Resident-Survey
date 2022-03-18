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
{
  KCMOFY2022_B <-
    read.csv(file = "FY2022_RS_Cleaned.csv")
  # make some adjustments to the data, specifically changing variables to factors
  
  #"q5_02_", "q14_01", "q14_02", "q25_d",
  #"q28_h","q29_t", "q30_t", "q31_08", "q31_09", 
  #"q31_10", "q31_14", "q31_16", "q31_20", "q34_d",
  #"q37_race", "q39_w", "q40_w"
  KCMOFY2022_B<-dplyr::select(KCMOFY2022_B, c( "q5_02", "q14_01", "q14_02", "q25_d",
                                               "q28_h","q29_t", "q30_t", "q31_08", "q31_09", 
                                               "q31_10", "q31_14", "q31_16", "q31_20", "q34_d",
                                               "q37_race", "q39_w", "q40_w", 
                                               "q26_01", 
                                               "q26_02","q27_01","q27_02","q27_03", "q32_01",
                                               "q32_02","q32_03","q32_04"))
  KCMOFY2022_B<-KCMOFY2022_B[,order(colnames(KCMOFY2022_B))]  
}
## adjust the variables
{KCMOFY2022_B$q5_02 <- factor(
  KCMOFY2022_B$q5_02,
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
  KCMOFY2022_B[, 1:2] <- lapply(
    KCMOFY2022_B[, 1:2],
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
  KCMOFY2022_B$q25_d <- factor(
    KCMOFY2022_B$q25_d,
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
  KCMOFY2022_B[, 4:5] <- lapply(
    KCMOFY2022_B[, 4:5],
    factor,
    levels = c(4,3,2,1,9),
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
  KCMOFY2022_B[, 6:8] <- lapply(
    KCMOFY2022_B[, 6:8],
    factor,
    levels = c(4,3,2,1,9),
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
  KCMOFY2022_B[, 18:21] <- lapply(
    KCMOFY2022_B[, 18:21],
    factor,
    levels = c(9,1, 2, 3, 4, 5),
    labels = c("Don't Know",
               "Very Dissatisfied",
               "Dissatisfied",
               "Neutral",
               "Satisfied",
               "Very Satisfied"
    ),
    ordered = TRUE
  )
  KCMOFY2022_B$q28_h <- factor(
    KCMOFY2022_B$q28_h,
    levels = c(5, 4, 3, 2, 1),
    labels = c("Poor", "Fair", "Good", "Very Good", "Excellent"),
    ordered = TRUE
  )
  KCMOFY2022_B$q29_t <- factor(
    KCMOFY2022_B$q29_t,
    levels = c(5, 4, 3, 2, 1),
    labels = c("Poor", "Fair", "Good", "Very Good", "Excellent"),
    ordered = TRUE
  )
  KCMOFY2022_B$q30_t <- factor(
    KCMOFY2022_B$q30_t,
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
  KCMOFY2022_B[, 12:17] <- lapply(KCMOFY2022_B[, 12:17],
                                  factor,
                                  levels = c(2,1),
                                  labels = c("No", "Yes"),
                                  ordered = TRUE
  )
  # Question 34
  KCMOFY2022_B$q34_d <- factor(KCMOFY2022_B$q34_d,
                               levels = c(2,1),
                               labels = c("Rent", "Own"),
                               ordered = TRUE
  )
  # Question 39
  KCMOFY2022_B$q39_w <- factor(
    KCMOFY2022_B$q39_w,
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
  KCMOFY2022_B$q40_w <- factor(
    KCMOFY2022_B$q40_w,
    levels = c(1, 2, 3, 4, 5, 6),
    labels = c("18-24", "25-34", "35-44", "45-54", "55-64", "65+"),
    ordered = TRUE
  )
  KCMOFY2022_B$q37_race <- as.factor(KCMOFY2022_B$q37_race)
  # Rename columns
  names(KCMOFY2022_B) <- c( 'Availability of Afforable Housing', 
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
                            'Police and Nieghborhood Relationship')
  
}
KCMOFY2022_C<-KCMOFY2022_B

KCMOFY2022_C[,1:26] <- lapply(KCMOFY2022_C[,1:26],fct_rev)
levels(KCMOFY2022_C$`Availability of Afforable Housing`)
levels(KCMOFY2022_B$`Availability of Afforable Housing`)
# Define UI for application that draws a histogram
ui <- dashboardPage(
  dashboardHeader(title = "Kansas City Resident Survey"),
  dashboardSidebar(),
  dashboardBody(
    tags$head(tags$script('
      // Define function to set height of "Mosaic" and "mosaic_container"
      setHeight = function() {
        var window_height = $(window).height();
        var header_height = $(".main-header").height();

        var boxHeight = window_height - header_height - 30;

        $("#moasaic_container").height(boxHeight);
        $("#Mosaic").height(boxHeight - 20);
      };

      // Set input$box_height when the connection is established
      $(document).on("shiny:connected", function(event) {
        setHeight();
      });

      // Refresh the box height on every window resize event    
      $(window).on("resize", function(){
        setHeight();
      });
    ')),
    box(id = "mosaic_container",
          plotOutput("Mosaic"), width = 8),
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

}

# Run the application 
shinyApp(ui = ui, server = server)
