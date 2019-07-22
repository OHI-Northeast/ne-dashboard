#global
##libraries
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")

## source custom functions
files.sources = list.files("functions", full.names = T)
sapply(files.sources, source)

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)

##color palette ----
reds <-  grDevices::colorRampPalette(
  c("#A50026", "#D73027", "#F46D43", "#FDAE61", "#FEE090"),
  space="Lab")(85)
blues <-  grDevices::colorRampPalette(
  c("#E0F3F8", "#ABD9E9", "#74ADD1", "#4575B4", "#313695"))(15)
myPalette <-  c(reds, blues)

## shapefile
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

 #catch aggregated to OHI regions
  fis_noaa_catch <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/fis/data/nmfs_spatial_catch_by_ohi_rgn.csv") %>% 
    left_join(rgn_data) %>%
    filter(species!= "CONFIDENTIAL SPECIES")

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
  
## BIO data ##
  bio_scores <- scores %>%
    filter(goal == "BD",
           dimension == "score")
  
  bio_scores_map <- filter(bio_scores, year == 2017)

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
  
  salt_marsh <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/hab/data/salt_marsh_percent_change.csv") 
  
  eelgrass   <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/hab/data/eelgrass_score_rgn_gf.csv")
  
  hab_data <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/hab/data/dashboard_habitat_data.csv")
  
## Habitat Services (HS) Data ##
  
  hs_scores <- scores %>%
    filter(goal == "HS",
           dimension == "score")
  
  hs_scores_map <- filter(hs_scores, year == 2017)
  
  coastal_protection <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/hs_coastal_protection.csv")
    
  carbon_storage <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/hs_carbon_storage.csv")
  
## Sense of Place ##
  sop_scores <- scores %>%
    filter(goal == "SP",
           dimension == "score")
  
  sop_map <- filter(sop_scores, year == 2017)
  
## Lasting Special Places $$
  lsp_scores <- scores %>%
    filter(goal == "LSP",
           dimension == "score")
  
  lsp_map <- filter(lsp_scores, year == 2017)
  
  land_protection <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/lsp_protected_land.csv") %>% 
    left_join(rgn_data)
  marine_protection <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/lsp_protected_marine.csv") %>% 
    left_join(rgn_data)
  
## Iconic Species  
  
  ico_scores <- scores %>%
    filter(goal == "ICO",
           dimension == "score")
  
  ico_map <- filter(ico_scores, year == 2017)
  
  ico_species_scores <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/ico_scores.csv") %>%
    left_join(rgn_data)
  
  