#global

source(file.path('~/github/ne-prep/src/R/common.R'))  ### an OHI-NE specific version of common.R

dir_anx <- file.path(dir_M, 'git-annex/neprep')

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")

## source functions
source("functions/tab_title.R")

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)

##libraries
library(tidyverse)
library(shinydashboard)

##shapefile
rgns_leaflet <- rgns_simp %>%
  st_transform(crs = '+proj=longlat +datum=WGS84') %>%
  rename(region_id = rgn_id) #scores.csv uses region_id not rgn_id so this allows them to join

## Data sources (change this to be organized by goal and then alphabetically?)

## SCORES.CSV ##

scores <- read_csv(file.path(dir_calc, "scores.csv"))

### LE scores ###

### Here we want the scores for LIV, ECO and LE.
### For now I"m limiting this to status only. But we will want to have the ability to toggle between all dimensions and sub goals
le_scores <- scores %>% 
  filter(goal %in% c("LIV", "ECO", "LE"),
         dimension == "score",
         year == 2015)

# NOEP data for livelihoods & economies, tourism & recreation
noep_data <- readxl::read_excel(file.path(dir_anx, '_raw_data/NOEP/New_England_ocean_series.xlsx'), sheet = "ENOW") %>%
  mutate(Employment = as.integer(Employment),
         Wages_2012 = as.integer(Wages_2012)/Employment) %>%
  filter(str_detect(County, "All"),
         !is.na(Employment),
         !is.na(Wages_2012),
         !is.na(GDP_2012))

# Trash pressure layer

trash <- read_csv("~/github/ne-prep/prep/cw/scores/trash.csv")
