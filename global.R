#global

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")

## source functions
source("functions/tab_title.R")
source("functions/text_links.R")
source("functions/convertMenuItem.R")

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)

##libraries
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)

##color palette ----
reds <-  grDevices::colorRampPalette(
  c("#A50026", "#D73027", "#F46D43", "#FDAE61", "#FEE090"),
  space="Lab")(85)
blues <-  grDevices::colorRampPalette(
  c("#E0F3F8", "#ABD9E9", "#74ADD1", "#4575B4", "#313695"))(15)
myPalette <-  c(reds, blues)

##shapefile
rgns_leaflet <- sf::st_read("shapefile", "ne_ohi_rgns_simp", quiet = T) %>%
  sf::st_transform(crs = '+proj=longlat +datum=WGS84') %>%
  rename(region_id = rgn_id) #scores.csv uses region_id not rgn_id so this allows them to join

## Data sources (change this to be organized by goal and then alphabetically?)

rgn_data <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/spatial/regions_list.csv") %>%
  select(-area_km2)

## SCORES.CSV ##

scores <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/scores.csv") %>%
  left_join(rgn_data, by = c("region_id" = "rgn_id")) %>%
  mutate(rgn_name = ifelse(is.na(rgn_name), "Northeast Region", rgn_name))

## Index scores for entire region ##

indx_scores <- scores %>%
  filter(goal == "Index",
         dimension == "score")

ne_indx_scores <- indx_scores %>%
  filter(region_id == 0)

indx_scores_map <- filter(indx_scores, year == 2017)

## Food Provision data ##
fp_scores <- scores %>% 
  filter(goal == "FP",
         dimension == "score")

fp_scores_map <- filter(fp_scores, year == 2017)

## FIS data ##
  fis_scores <- scores %>% 
    filter(goal == "FIS",
           dimension == "score")

  fis_scores_map <- filter(fis_scores, year == 2017)

 #for now I'm removing non-assessed catch but we should probably consider a way to display both assessed/unassessed stock catch values
  fis_noaa_catch <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/fis_meancatch.csv") %>% 
    select(-X1) %>%
    filter(species!= "CONFIDENTIAL SPECIES") %>%
    mutate(species = ifelse(is.na(stock), species, stock)) #this will make sure we display stocks separate

  ## Aquaculture data ##
  mar_scores <- scores %>% 
    filter(goal == "MAR",
           dimension == "score")
  
  mar_scores_map <- filter(mar_scores, year == 2017)
  
  ## LE data ##

  le_scores <- scores %>% 
    filter(goal == "LE",
           dimension == "score")
  le_scores_map <- filter(le_scores, year == 2017)
  
  #livelihoods#
  liv_scores <- scores %>% 
    filter(goal == "LIV",
           dimension == "score")
  liv_scores_map <- filter(liv_scores, year == 2017)
  
  ### jobs data ###
  jobs <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/jobs_sector.csv")
  
  jobs_scores <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/job_scores.csv")
  
  ### wages data ###
  wages <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/wages_sector.csv")
  
  wages_scores <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/wages_scores.csv")
  
  #economies#
  eco_scores <- scores %>% 
    filter(goal == "ECO",
           dimension == "score")
  eco_scores_map <- filter(eco_scores, year == 2017)
  

  ### GDP data ###
  gdp <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/gdp_sector.csv")

  gdp_scores <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/eco/data/gdp_scores.csv")
  
## TR data ##

  ### For now I"m limiting this to status only. But we will want to have the ability to toggle between all dimensions and sub goals
  tr_scores <- scores %>% 
    filter(goal == "TR",
           dimension == "score")
  tr_scores_map <- filter(tr_scores, year == 2017)
  
  tr_jobs <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/tr/data/tr_jobs.csv")

## CW data ##
  cw_scores <- scores %>%
    filter(goal == "CW",
           dimension == "score")
  cw_scores_map <- filter(cw_scores, year == 2017)
  
  cw_layers <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/cw/data/region_layer_scores.csv") %>%
    select(-X1) %>%
    left_join(rgn_data, by = c("region_id" = "rgn_id")) %>%
    mutate(score = value * 100)

## SPP data ##
  spp_scores <- scores %>%
    filter(goal == "SPP",
           dimension == "score")
  
  spp_scores_map <- filter(spp_scores, year == 2017)
  
## HAB data ##
  hab_scores <- scores %>%
    filter(goal == "HAB",
           dimension == "score")
  
  hab_scores_map <- filter(hab_scores, year == 2017)
  
  