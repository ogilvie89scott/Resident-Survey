#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(tidyverse)
FY2022_RS_Cleaned <- read_csv("FY2022_RS_Cleaned.csv")
View(FY2022_RS_Cleaned)
{
  KCMOFY2022 <-
    read.csv(file = "FY2022_RS_Cleaned.csv")
  # make some adjustments to the data, specifically changing variables to factors
  
  #"q5_02_", "q14_01", "q14_02", "q25_d",
  #"q28_h","q29_t", "q30_t", "q31_08", "q31_09", 
  #"q31_10", "q31_14", "q31_16", "q31_20", "q34_d",
  #"q37_race", "q39_w", "q40_w"
  KCMOFY2022_B<-dplyr::select(KCMOFY2022, c( "q5_02", "q14_01", "q14_02", "q25_d",
                                             "q28_h","q29_t", "q30_t", "q31_08", "q31_09", 
                                             "q31_10", "q31_14", "q31_16", "q31_20", "q34_d",
                                             "q37_race", "q39_w", "q40_w", "zip",
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
                            'Police and Nieghborhood Relationship', 
                            'Zipcode')
  
}
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Kansas City Resident Survey"),

    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
          #input using radiobuttons
          radioButtons("s", "Select X-axis:",
                       list( 'Availability of Afforable Housing'= "a", 
                             'Quality of Housing'= "b",
                             "Can Count on Someone to Help" ="c", 
                             "Had personal conversations with people of a different race or ethnicity than you "= "d",
                             "Had personal conversations with people who have different political views than you " = "e",
                             "Attended any public meeting in which there was discussion of local government affairs" ="f",
                             "Tried to get your local government to pay attention to something that concerned you" ="g",
                             "Had friends of another race over to your home" ="h",
                             'Self-Reported Health'= "i",
                             'Financial Situation' ="j", 
                             "Standard of Living Compared to Parents" ="k", 
                             'Visited a Park'="l", 
                             'Used a Bus'= "m", 
                             'Used the Streetcar'="n", 
                             'Flown out of Airport'="o", 
                             "Biking"="p",
                             'Had Rent Stress'= "q",
                             "Job opportunities available within the city limits of Kansas City "= "r",
                             "Ability to obtain training opportunities to advance your career "= "s",
                             "Support for entrepreneurs and small business owners available in Kansas City "= "t",
                             "City's use of economic development incentives to support economic opportunity for residents "= "u",
                             'Own or Rent'= "v",
                             'Race'= "w", 
                             'Income'= "x",
                             'Age'= "y",
                             'Police and Nieghborhood Relationship'="z", 
                             'Zipcode'="aa") ),
          radioButtons("k", "Select Y-axis:",
                       list('Availability of Afforable Housing'= "a1", 
                            'Quality of Housing'= "b1",
                            "Can Count on Someone to Help" ="c1", 
                            "Had personal conversations with people of a different race or ethnicity than you "= "d1",
                            "Had personal conversations with people who have different political views than you " = "e1",
                            "Attended any public meeting in which there was discussion of local government affairs" ="f1",
                            "Tried to get your local government to pay attention to something that concerned you" ="g1",
                            "Had friends of another race over to your home" ="h1",
                            'Self-Reported Health'= "i1",
                            'Financial Situation' ="j1", 
                            "Standard of Living Compared to Parents" ="k1", 
                            'Visited a Park'="l1", 
                            'Used a Bus'= "m1", 
                            'Used the Streetcar'="n1", 
                            'Flown out of Airport'="o1", 
                            "Biking"="p1",
                            'Had Rent Stress'= "q1",
                            "Job opportunities available within the city limits of Kansas City "= "r1",
                            "Ability to obtain training opportunities to advance your career "= "s1",
                            "Support for entrepreneurs and small business owners available in Kansas City "= "t1",
                            "City's use of economic development incentives to support economic opportunity for residents "= "u1",
                            'Own or Rent'= "v1",
                            'Race'= "w1", 
                            'Income'= "x1",
                            'Age'= "y1",
                            'Police and Nieghborhood Relationship'="z1", 
                            'Zipcode'="aa1"))),
          mainPanel(
          plotOutput("residentPlot")  
          )   
          
      
))
      

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$residentPlot <- renderPlot({ 
#creating residentPlot
    if(input$s=='a') { i<-1 }
    if(input$s=='b') { i<-2 }
    if(input$s=='c') { i<-3 }
    if(input$s=='d') { i<-4 }
    if(input$s=='e') { i<-5 }
    if(input$s=='f') { i<-6 }
    if(input$s=='g') { i<-7 }
    if(input$s=='h') { i<-8 }
    if(input$s=='i') { i<-9 }
    if(input$s=='j') { i<-10 }
    if(input$s=='k') { i<-11 }
    if(input$s=='l') { i<-12 }
    if(input$s=='m') { i<-13 }
    if(input$s=='n') { i<-14 }
    if(input$s=='o') { i<-15 }
    if(input$s=='p') { i<-16 }
    if(input$s=='q') { i<-17 }
    if(input$s=='r') { i<-18 }
    if(input$s=='s') { i<-19 }
    if(input$s=='t') { i<-20 }
    if(input$s=='u') { i<-21 }
    if(input$s=='v') { i<-22 }
    if(input$s=='w') { i<-23 }
    if(input$s=='x') { i<-24 }
    if(input$s=='y') { i<-25 }
    if(input$s=='z') { i<-26 }
    if(input$s=='aa') { i<-27 }
    if(input$k=='a1') { j<-1 }
    if(input$k=='b1') { j<-2 }
    if(input$k=='c1') { j<-3 }
    if(input$k=='d1') { j<-4 }
    if(input$k=='e1') { j<-5 }
    if(input$k=='f1') { j<-6 }
    if(input$k=='g1') { j<-7 }
    if(input$k=='h1') { j<-8 }
    if(input$k=='i1') { j<-9 }
    if(input$k=='j1') { j<-10 }
    if(input$k=='k1') { j<-11 }
    if(input$k=='l1') { j<-12 }
    if(input$k=='m1') { j<-13 }
    if(input$k=='n1') { j<-14 }
    if(input$k=='o1') { j<-15 }
    if(input$k=='p1') { j<-16 }
    if(input$k=='q1') { j<-17 }
    if(input$k=='r1') { j<-18 }
    if(input$k=='s1') { j<-19 }
    if(input$k=='t1') { j<-20 }
    if(input$k=='u1') { j<-21 }
    if(input$k=='v1') { j<-22 }
    if(input$k=='w1') { j<-23 }
    if(input$k=='x1') { j<-24 }
    if(input$k=='y1') { j<-25 }
    if(input$k=='z1') { j<-26 }
    if(input$k=='aa1') { j<-27 }
    X    <- KCMOFY2022_B[, i]
    Y    <- KCMOFY2022_B[, j]

library(graphics)
mosaicplot(
      ~  X+ Y,
      data = KCMOFY2022_B,
      color = TRUE,
      shade = TRUE,
      las = 1,
      main = ,
      xlab = ,
      ylab = ,
      cex.axis = .656,
      type = "pearson"
)

                
    
  
  })
}
# Run the application 
shinyApp(ui = ui, server = server)
