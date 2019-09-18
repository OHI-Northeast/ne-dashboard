#global
##libraries
library(tidyverse)
library(shinydashboard)
library(RColorBrewer)
library(DT)

## source modules
source("modules/chart_card.R")
source("modules/map_card.R")

## source custom functions
files.sources = list.files("functions", full.names = T)
sapply(files.sources, source)

## no scientific notation and round to 2 decimals
options(scipen = 999,
        digits = 2)

##color palette ---
reds <-  grDevices::colorRampPalette(
  c("#A50026", "#D73027", "#F46D43", "#FDAE61", "#FEE090"),
  space="Lab")(85)
blues <-  grDevices::colorRampPalette(
  c("#E0F3F8", "#ABD9E9", "#74ADD1", "#4575B4", "#313695"))(15)
myPalette <-  c(reds, blues)
chart_colors <- viridis::viridis(n = 12)

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

## Index scores for entire region ----

indx_scores <- scores %>%
  filter(goal == "Index",
         dimension == "score")

ne_indx_scores <- indx_scores %>%
  filter(region_id == 0)

indx_scores_map <- filter(indx_scores, year == 2017)

## Food Provision data ----
fp_scores <- scores %>% 
  filter(goal == "FP",
         dimension == "status")

fp_scores_map <- filter(fp_scores, year == 2017)

## FIS data ----
  fis_scores <- scores %>% 
    filter(goal == "FIS",
           dimension == "status")

  fis_scores_map <- filter(fis_scores, year == 2017)

 #catch aggregated to OHI regions
  fis_noaa_catch <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/fis/data/nmfs_spatial_catch_by_ohi_rgn.csv") %>% 
    left_join(rgn_data) %>%
    filter(species!= "CONFIDENTIAL SPECIES")
  fis_stock_assessment <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/fis/data/stock_assessment_data_for_dashboard.csv")
  fis_data_info <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/fis/data/fis_data_info.csv")

## Aquaculture data ----
  mar_scores <- scores %>% 
    filter(goal == "MAR",
           dimension == "status")
  
  mar_scores_map <- filter(mar_scores, year == 2017)
  mar_production <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/mar/data/production_clean.csv") %>%
    mutate(Year = as.numeric(Year)) %>%
    arrange(Year)
  mar_spp_sust <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/mar/data/species_sust_scores.csv") %>%
    rename(Species = species,
           `Seafood Watch Score` = sustainabilityscore,
           `Score (0-1)` = rescaled)
  mar_data_info <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/mar/data/mar_data_info.csv")
  
## livelihoods----
  liv_scores <- scores %>% 
    filter(goal == "LIV",
           dimension == "status")
  liv_scores_map <- filter(liv_scores, year == 2017)
  
  ### jobs data ###
  jobs          <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/jobs_sector.csv")
  jobs_scores   <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/job_scores.csv") %>%
    filter(!is.na(job_score))
  
  ### wages data ###
  wages         <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/wages_sector.csv")
  wages_scores  <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/wages_scores.csv") %>%
    filter(!is.na(wages_score),
           !is.na(rgn_id))
  liv_data_info <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/liv_data_info.csv")
  
## Economies data ----
  eco_scores <- scores %>% 
    filter(goal == "ECO",
           dimension == "status")
  eco_scores_map <- filter(eco_scores, year == 2017)
  gdp            <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/liv/data/gdp_sector.csv")
  gdp_scores     <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/eco/data/gdp_scores.csv")
  eco_data_info  <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/eco/data/eco_data_info.csv")
  
## LE data ----
  
  le_scores <- scores %>% 
    filter(goal == "LE",
           dimension == "status")
  le_scores_map <- filter(le_scores, year == 2017)
  le_data_info  <- bind_rows(liv_data_info, eco_data_info)
  
## TR data ----

  tr_scores <- scores %>% 
    filter(goal == "TR",
           dimension == "status")
  tr_scores_map <- filter(tr_scores, year == 2017)
  tr_jobs       <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/tr/data/tr_jobs.csv")
  tr_beaches    <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/tr/data/proportion_closed_by_rgn.csv")
  tr_coastal   <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/tr_rao_coastal_access.csv") %>%
    filter(!is.na(score)) %>%
    mutate(percent = score*100) %>%
    left_join(rgn_data) 
  tr_data_info  <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/tr/data/tr_data_info.csv")
  
## CW data ----
  cw_scores <- scores %>%
    filter(goal == "CW",
           dimension == "status")
  cw_scores_map <- filter(cw_scores, year == 2017)
  cw_layers     <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/cw/data/region_layer_scores.csv")
  cw_data_info  <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/cw/data/cw_data_info.csv")
  
## BIO data ----
  bio_scores <- scores %>%
    filter(goal == "BD",
           dimension == "status")
  
  bio_scores_map <- filter(bio_scores, year == 2017)
  bio_data_info  <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/data/bio_data_info.csv")

## SPP data ----
  spp_scores <- scores %>%
    filter(goal == "SPP",
           dimension == "status")
  
  spp_scores_map <- filter(spp_scores, year == 2017)
  spp_data_info <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/data/spp_data_info.csv")
  spp_status_rgn <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/data/species_status_counts_by_rgn.csv")
  
## HAB data ----
  hab_scores <- scores %>%
    filter(goal == "HAB",
           dimension == "status")
  
  hab_scores_map <- filter(hab_scores, year == 2017)
  salt_marsh     <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/hab/data/salt_marsh_percent_change.csv") 
  eelgrass       <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/hab/data/eelgrass_score_rgn_gf.csv")
  hab_data       <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/hab/data/dashboard_habitat_data.csv") %>%
    mutate(score = ifelse(habitat == "offshore", score*100, score))
  hab_data_info  <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/bio/data/hab_data_info.csv")
  
## Habitat Services (HS) Data ----
  
  hs_scores <- scores %>%
    filter(goal == "HS",
           dimension == "status")
  
  hs_scores_map      <- filter(hs_scores, year == 2017)
  coastal_protection <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/hs_coastal_protection.csv")
  carbon_storage     <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/hs_carbon_storage.csv")
  hs_data_info       <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/hs/data/hs_data_info.csv")
  
## Sense of Place ----
  sop_scores <- scores %>%
    filter(goal == "SP",
           dimension == "status")
  
  sop_map <- filter(sop_scores, year == 2017)
  
## Lasting Special Places ----
  lsp_scores <- scores %>%
    filter(goal == "LSP",
           dimension == "status")
  
  lsp_map <- filter(lsp_scores, year == 2017)
  
  land_protection <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/lsp_protected_land.csv") %>% 
    left_join(rgn_data)
  marine_protection <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/lsp_protected_marine.csv") %>% 
    left_join(rgn_data)
  lsp_data_info <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/sop/lsp/data/lsp_data_info.csv")
## Iconic Species  ----
  
  ico_scores <- scores %>%
    filter(goal == "ICO",
           dimension == "status")
  
  ico_map <- filter(ico_scores, year == 2017)
  
  #iconic species status for heatmap. need to set levels for arranging by status.
  
  order_status <- c("Least Concern", "Least Concern/Not Threatened", "Not Threatened", "Not Threatened/Vulnerable", "Vulnerable", "Vulnerable/Endangered", "Endangered", "Endangered/Critically Endangered", "Critically Endangered", "Critically Endangered/Extinct", "Extinct")
  
  ico_heatmap_df <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/sop/ico/data/heatmap_df.csv") %>% 
    arrange(desc(av_score), common) %>% 
    mutate(rgn_name = as.factor(rgn_name)) %>% 
    transform(common = reorder(common, desc(av_score))) %>% 
    transform(id = as.numeric(factor(common))) %>% 
    transform(common = reorder(common, desc(id))) %>% 
    mutate(Status = factor(Status, levels = order_status)) 

  ico_data_info <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/sop/ico/data/ico_data_info.csv")
## Resource Access Opportunities  -----
  
  rao_scores <- scores %>%
    filter(goal == "RAO",
           dimension == "status")
  
  rao_scores_map <- filter(rao_scores, year == 2017)
  
  rao_coastal   <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-scores/master/region/layers/tr_rao_coastal_access.csv") %>%
    filter(!is.na(score)) %>%
    mutate(percent = score*100) %>%
    left_join(rgn_data) 
  
  rao_econ      <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/rao/data/gas_to_income_ratio.csv")
  rao_fisheries <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/rao/data/fssi_scores.csv") %>%
    mutate(year = as.numeric(year)) %>%
    arrange(year)
  
  rao_avg_fssi <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/rao/data/avg_fssi_score_per_region_over_time.csv") %>%
    mutate(score = average_fssi_score*4)
  rao_data_info  <- read_csv("https://raw.githubusercontent.com/OHI-Northeast/ne-prep/gh-pages/prep/rao/data/rao_data_info.csv")
  