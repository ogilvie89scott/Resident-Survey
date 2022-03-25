# LIST OF REQUIRED PACKAGES -----------------------------------------------

# Package names
packages <- c("broom", "data.table", "DT", "CGPfunctions", "ggridges", "leaflet", "lintr",
              "lubridate", "plotly", "lubridate", "rintrojs", "shiny",
              "shinycssloaders", "shinydashboard", "shinyjs", "shinyWidgets",
              "ggpubr", "tidyverse", "rcompanion", "viridis", "zoo")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))

