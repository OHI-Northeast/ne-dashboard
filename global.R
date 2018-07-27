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

## LE data ##

### Here we want the scores for LIV, ECO and LE.
### For now I"m limiting this to status only. But we will want to have the ability to toggle between all dimensions and sub goals
le_scores <- scores %>% 
  filter(goal %in% c("LIV", "ECO", "LE"),
         dimension == "score",
         year == 2015)

### jobs data ###
jobs <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/jobs_sector.csv")

### wages data ###
wages <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/wages_sector.csv")

### GDP data ###
gdp <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/gdp_sector.csv")

## TR data ##

### Here we want the scores for LIV, ECO and LE.
### For now I"m limiting this to status only. But we will want to have the ability to toggle between all dimensions and sub goals
tr_scores <- scores %>% 
  filter(goal == "TR",
         dimension == "score",
         year == 2015)

tr_jobs <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/tr/data/tr_jobs.csv")

