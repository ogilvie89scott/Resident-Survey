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
packages <-
  c(
    "broom",
    "data.table",
    "DT",
    "CGPfunctions",
    "ggridges",
    "leaflet",
    "lintr",
    "lubridate",
    "plotly",
    "lubridate",
    "rintrojs",
    "shiny",
    "shinycssloaders",
    "shinydashboard",
    "shinyjs",
    "shinyWidgets",
    "surveydata",
    "ggpubr",
    "tidyverse",
    "rcompanion",
    "viridis",
    "zoo",
    "recipes",
    "readxl"
  )

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))
