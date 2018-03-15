#global

source(file.path('~/github/ne-prep/src/R/common.R'))  ### an OHI-NE specific version of common.R
# 
# library(tidyverse)
# library(readxl)
# library(DT)
# #install.packages("striprtf")
# library(striprtf)
# library(zoo)
#library(plotly)
dir_anx <- file.path(dir_M, 'git-annex/neprep')

source("modules/liv_eco.R")

## read in ENOW sheet from NOEP which contains data for 2005 - 2014 
noep_data <- readxl::read_excel(file.path(dir_anx, '_raw_data/NOEP/New_England_ocean_series.xlsx'), sheet = "ENOW") %>%
  mutate(Employment = as.numeric(Employment),
         Wages_2012 = as.numeric(Wages_2012))
