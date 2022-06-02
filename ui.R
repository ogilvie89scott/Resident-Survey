# ********** Start of Header **************
# Title: UI for Resident Survey app
#
# This code sets up the UI for the app
# 
#
# Author: Scott Ogilvie
# Date: 05/25/2022
#
# *********** End of header ****************
# UI CODE----
ui <- dashboardPage(
  skin = "blue", # changes the theme colors
  title = "DataKC",
  ## HEADER----
  dashboardHeader(
    title =  span("DataKC Resident Survey Dashboard"), # Change the title
    titleWidth = 530 # Change how much space the title takes up.
  ),
  ## SIDEBAR----
  dashboardSidebar(disable = T, # Change this to false to add tabs or display this existing one.
    sidebarMenu(
      menuItem("Analysis Q1 & Q3",
             tabName = "Analysis",
              icon = icon("signal"))
      )
    ),
  ## BODY ----
  dashboardBody(useShinyjs(), # these add some nice functions to the app.
                introjsUI(),
                ### MAIN BODY----
                tabItems(
                  tabItem(
                           tabName = "Analysis", # using tab items to make it easier to add new tabs in the future but not being utilized here because there is only one tab.
                           fluidRow(
                             box( # Edit the text in these lines to change the text in the box.
                               title = "Instructions",
                               status = "primary",
                               width = 6,
                               p(style = "height: 10px; font-size: 12px;",
                                 "Select two variables from the drop boxes below."
                                 ),
                               p(
                                 style = "height: 10px; font-size: 12px;",
                                 "Chi-Squared and other statistic of the two variables is shown below."
                               ),
                               p(
                                 style = "height: 30px; font-size: 12px;",
                                 "Cramer's V is a number between 0 and 1. The closer the Cramer's V is to 1,
                            the stronger the relationship is between the two variables. Scores above .10 are weakly associated.
                            Scores above .4 are strongly related."
                               ),
                               p(
                                 style = "height: 10px; font-size: 12px;",
                                 "P-values should be smaller than .02 to be statistically significant."
                               )
                             ),
                             box(
                               title = "Filter Data",
                               status = "primary",
                               width = 6,
                               selectInput( # This is how we select the quarter
                                 "qrter",
                                 "Choose a quarter:",
                                 choices = c("choose" = "", list),
                                 multiple = T, # Turn this off to only be able to look at one quarter at a time.
                                 selected = list("3QMAR2022" = "3QMAR2022") # what will be the default quarter.
                               ),
                               selectInput( # whether to include don't knows.
                                 "dontknows",
                                 "Include Don't Knows?",
                                 choices = list("Yes" = "Yes",
                                                "No" = "No"),
                                 multiple = F,
                                 selected = list("Yes" = "resident_survey")
                               )
                             ),
                             
                             fluidRow(
                               box(
                                 selectInput( # how to select the Y variables.
                                   "ycol",
                                   "Y Variables:",
                                   varnames # changing these will change the options from the drop down box.
                                 ),
                                 status = "warning",
                                 width = 6
                               ),
                               box(
                                 selectInput(
                                   "xcol",
                                   "X Variables:",
                                   varnames
                                 ),
                                 status = "info",
                                 width = 6
                               )
                             ),
                             
                             fluidRow( # Mosaic plot 
                               box(
                                 status = "primary",
                                 id = "mosaic_container",
                                 plotOutput("Mosaic", height = 500),
                                 width = 6,
                                 downloadButton("downloadMosaic", "Download")
                               ),
                               box( # Plotxtabs2
                                 status = "primary",
                                 id = "plotx_container",
                                 plotOutput("PlotXtabs", height = 500),
                                 width = 6,
                                 downloadButton("downloadplotx", "Download")
                               )
                             ),
                             fluidRow( # Cramer's V Table
                               box(
                                 status = "primary",
                                 id = "table_container",
                                 title = "Cramer's V by Y Variable",
                                 dataTableOutput("table"),
                                 width = 12
                               )
                             ),
                             fluidRow( # box for plots in bottom left 
                               box( # box for plots in the bottom right
                                 status = "primary",
                                 id = "simplex_container",
                                 title = ,
                                 plotlyOutput("simplex"),
                                 width = 12
                                 )
                               )
                             )
                           )
)
)
)
#