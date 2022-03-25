# 
ui <- dashboardPage(
  skin = "blue",
  title = "DataKC",
  
  # HEADER--------------------------------------------------------------------
  dashboardHeader(
    
    title =  span("DataKC"),
    titleWidth = 300), 
  # SIDEBAR------------------------------------------------------------------
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Resident Survey", 
        tabName = "Resident_Survey", 
        icon = icon("city")
      ),
      menuItem(
        "Employee Survey", 
        tabName = "Employee_Survey", 
        icon = icon("keyboard")
      )
    )
  ),
  # BODY --------------------------------------------------------------------
  dashboardBody(    
    
    useShinyjs(),
    introjsUI(),
    
    # MAIN BODY-------------------------------------------------------------
    tabItems(
      tabItem(
        "Resident_Survey",
        fluidRow(
        h1(
          "August 2021 Resident Survey Dashboard")
           ),
        fluidRow(
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
             'Police and Nieghborhood Relationship'
             )
           ),
          status = "danger",
          width = 3), 
         box(selectInput(
           "xcol",
           "X Variables:",
           c(
             'Availability of Afforable Housing',
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
             'Police and Nieghborhood Relationship'
           )
         ),
         status = "primary",
         width = 3)
        ), 
        fluidRow(
          box(
            id = "mosaic_container",
            plotOutput("Mosaic", height = 500),
            width = 6,
            downloadButton("downloadMosaic", "Download Mosaic")
          ),
          box(
            id = "plotx_container",
            plotOutput("PlotXtabs", height = 500),
            width = 6
          ),
          #can not figure out how to download this with a button like above.
        ),
        fluidRow(
          box(
            id = "table_container",
            title = "Cramer's V by Y Variable",
            dataTableOutput("table"),
            width = 6
          ),
          box(
            id = "simpley_container",
            title = ,
            plotOutput("simpley"),
            width = 3
          ),
          box(
            id = "simplex_container",
            title = ,
            plotOutput("simplex"),
            width = 3
          )
        )
      ),
      
      tabItem(
        "Employee_Survey",
              fluidRow(
                h1(
                  "Employee Survey")
                )
        )
    )
  )
)
