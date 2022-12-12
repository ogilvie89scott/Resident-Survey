# ********** Start of Header **************
# Title: Dependencies for Resident Survey app
#
# This code tells the app what packages need to be downloaded.
#
# Author: Scott Ogilvie
# Date: 05/25/2022
#
# *********** End of header ****************
# LIST OF REQUIRED PACKAGES -----------------------------------------------
# Package names
packages <-c('rsconnect','broom','data.table','DT','CGPfunctions', 'ggridges','leaflet','lintr','lubridate','plotly','rintrojs','shiny','shinycssloaders','shinydashboard',
             'shinyjs','shinyWidgets','surveydata','ggpubr','tidyverse','rcompanion','viridis','readxl','graphics')
remotes::install_github('rstudio/DT')
library(rsconnect)
library(broom)
library(data.table)
library(DT)
library(CGPfunctions)
library(ggridges)
library(leaflet)
library(lintr)
library(lubridate)
library(plotly)
library(rintrojs)
library(shiny)
library(shinycssloaders)
library(shinydashboard)
library(shinyjs)
library(shinyWidgets)
library(surveydata)
library(ggpubr)
library(tidyverse)
library(rcompanion)
library(viridis)
library(readxl)
library(graphics)