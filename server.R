function(input, output, session) {

## Overall Index ----
  
  output$flowerplot <- renderUI({
    tags$img(src = "https://raw.github.com/OHI-Northeast/ne-scores/master/region/reports/figures/flower_USNortheast.png",
             height = 450,
             width = 600)
  })
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "ne_indx_scores",
    df = ne_indx_scores,
    x = "year",
    y = "score",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Index score:", score,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ## Score map ##
  callModule(
    card_map,
    "indx_scores_map",
    data = indx_scores_map,
    field = "score",
    legend_title = "OHI Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "indx_scores",
    df = indx_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Index score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
## Clean Waters ----
  
  ## CW Score map ##
  callModule(
    card_map,
    "cw_scores_map",
    data = cw_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "cw_scores",
    df = cw_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### CW layers chart
  callModule(
    card_plot,
    "cw_layers",
    df = cw_layers,
    x = "year",
    y = "score",
    color_group = "layer",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", score,
                           "<br>Layer:", layer,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Layer Score"
  )
  
## Food Provision ----
  
  callModule(
    card_map,
    "fp_scores_map",
    data = fp_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  callModule(
    card_plot,
    "fp_scores",
    df = fp_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
## Wild-Caught Fisheries ----
  
  ## FIS Score map ##
  callModule(
    card_map,
    "fis_scores_map",
    data = fis_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "fis_scores",
    df = fis_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### NOAA landings chart
  callModule(
    card_plot,
    "fis_noaa_catch",
    df = fis_noaa_catch,
    x = "year",
    y = "catch",
    color_group = "display_name",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Species:",
      display_name,
      "<br>Pounds:",
      catch,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Catch (pounds)"
  )
  
## Aquaculture ----
  
  callModule(
    card_map,
    "mar_scores_map",
    data = mar_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  callModule(
    card_plot,
    "mar_scores",
    df = mar_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  
## Livelihoods & Economies ----
  
  ## L&E Score map ##
  callModule(
    card_map,
    "le_scores_map",
    data = le_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "le_scores",
    df = le_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
## Livelihoods ----
  
  ## Liv Score map ##
  callModule(
    card_map,
    "liv_scores_map",
    data = liv_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "liv_scores",
    df = liv_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### Employment chart
  callModule(
    card_plot,
    "liv_emp",
    df = jobs,
    x = "Year",
    y = "Employment",
    color_group = "Sector",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Number of jobs:",
      Employment,
      "<br>Sector:",
      Sector,
      "<br>Year:",
      Year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Number of jobs"
  )
  
  ###job scores
  callModule(
    card_plot,
    "liv_emp_scores",
    df = jobs_scores,
    x = "scenario_year",
    y = "job_score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Job score:",
      job_score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      scenario_year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Job score"
  )
  
  ### Wages
  callModule(
    card_plot,
    "liv_wages",
    df = wages,
    x = "Year",
    y = "Wages",
    color_group = "Sector",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Average annual wage: $",
      prettyNum(Wages, big.mark = ","),
      "<br>Sector:",
      Sector,
      "<br>Year:",
      Year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Wages (2012 $USD)"
  )
  
  ###wage scores
  callModule(
    card_plot,
    "liv_wage_scores",
    df = wages_scores,
    x = "scenario_year",
    y = "wages_score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Wage score:",
      wages_score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      scenario_year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Wage score"
  )
  
## Economies ----
  
  ## Economies Score map ##
  callModule(
    card_map,
    "eco_scores_map",
    data = eco_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "eco_scores",
    df = eco_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  
  ### GDP
  callModule(
    card_plot,
    "eco_gdp",
    df = gdp,
    x = "Year",
    y = "GDP",
    color_group = "Sector",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "GDP: $",
      prettyNum(GDP, big.mark = ","),
      "<br>Sector:",
      Sector,
      "<br>Year:",
      Year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Gross Domestic Product (2012 $USD)"
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "eco_gdp_scores",
    df = gdp_scores,
    x = "scenario_year",
    y = "status",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "GDP score:",
      status,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      scenario_year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  
## Tourism & Recreation ----
  
  ## TR Score map ##
  callModule(
    card_map,
    "tr_scores_map",
    data = tr_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "tr_scores",
    df = tr_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### Employment chart
  callModule(
    card_plot,
    "tr_jobs",
    df = tr_jobs,
    x = "Year",
    y = "Employment",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Number of jobs:",
      Employment,
      "<br>Sector:",
      Sector,
      "<br>Year:",
      Year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Number of jobs"
  )
  
  ### Beach closure chart
  callModule(
    card_plot,
    "tr_beach",
    df = tr_beaches,
    x = "Year",
    y = "perc_closed",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Proportion closed:",
      perc_closed,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      Year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Average proportion (%) of swim season closed"
  )
  
## Biodiversity ----
  
  ### BIO Score map ###
  callModule(
    card_map,
    "bio_scores_map",
    data = bio_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ### Scores time series chart ###
  callModule(
    card_plot,
    "bio_scores",
    df = bio_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### species sub-goal scores ###
  callModule(
    card_plot,
    "bio_spp_scores",
    df = spp_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Sub-goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### habitats sub-goal scores ###
  
  callModule(
    card_plot,
    "bio_hab_scores",
    df = hab_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Sub-goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
## Species ----
  
  ### SPP Score map ###
  callModule(
    card_map,
    "spp_scores_map",
    data = spp_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ### Scores time series chart ###
  callModule(
    card_plot,
    "spp_scores",
    df = spp_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
## Habitats ----
  
  ### HAB Score map ###
  callModule(
    card_map,
    "hab_scores_map",
    data = hab_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "hab_scores",
    df = hab_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### Habitat raw data line chart
  callModule(
    card_plot,
    "hab_raw_data",
    df = hab_data %>% filter(!is.na(raw_data)),
    x = "year",
    y = "raw_data",
    color_group = "rgn_name",
    filter_field = "habitat",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Data:",
      metric,
      "<br>Value:",
      raw_data,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = ""
  )
  
  ### Habitat layer scores chart
  callModule(
    card_plot,
    "hab_layer_scores",
    df = hab_data,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    filter_field = "habitat",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", score,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Layer Score"
  )
  
## Habitat Services ----
  
  
  ## HAB Score map ##
  callModule(
    card_map,
    "hs_scores_map",
    data = hs_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "hs_scores",
    df = hs_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### Coastal Protection
  callModule(
    card_plot,
    "coastal_protection",
    df = coastal_protection,
    x = "year",
    y = "cp_score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", cp_score,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ### Carbon Storage
  callModule(
    card_plot,
    "carbon_storage",
    df = carbon_storage,
    x = "year",
    y = "cs_score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", cs_score,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
## Sense of Place ----
  
  ##SOP Score Map
  callModule(
    card_map,
    "sop_scores_map",
    data = sop_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ##SOP Scores time series chart
  callModule(
    card_plot,
    "sop_scores",
    df = sop_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ##SOP LSP scores
  callModule(
    card_plot,
    "sop_lsp_scores",
    df = lsp_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Sub-goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ##SOP ICO Scores
  callModule(
    card_plot,
    "sop_ico_scores",
    df = ico_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Sub-goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
## Lasting Special Places ----
  
  ## LSP Score map ##
  callModule(
    card_map,
    "lsp_scores_map",
    data = lsp_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "lsp_scores",
    df = lsp_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ## Marine protected area ##
  callModule(
    card_plot,
    "lsp_marine",
    df = marine_protection,
    x = "year",
    y = "prop_area",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Proportion protected:",
      prop_area,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Proportion of area protected (0 to 1)"
  )
  
  ## land protected area ##
  callModule(
    card_plot,
    "lsp_land",
    df = land_protection,
    x = "year",
    y = "prop_area",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Proportion protected:",
      prop_area,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Proportion of area protected (0 to 1)"
  )
  
## Iconic Species ----
  
  ## ICO Map ##
  callModule(
    card_map,
    "ico_scores_map",
    data = ico_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## ICO Scores time series ##
  callModule(
    card_plot,
    "ico_scores",
    df = ico_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ##Iconic species status ##
  callModule(
    card_plot,
    "ico_species_scores",
    df = ico_species_scores,
    x = "year",
    y = "score",
    color_group = "common",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
      score,
      "<br>Species:",
      common,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Status score (a score of 1 is equal to a status of Least Concern)"
  )
  
  
## Resource Access Opportunities ----
  
  ## RAO Map ##
  callModule(
    card_map,
    "rao_scores_map",
    data = rao_scores_map,
    field = "score",
    legend_title = "OHI Goal Score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## RAO Scores time series ##
  callModule(
    card_plot,
    "rao_scores",
    df = rao_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Goal score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Score"
  )
  
  ##RAO economic access ##
  ##NOT DONE
  # callModule(card_plot, "rao_econ",
  #            df = rao_econ,
  #            x = "year",
  #            y = "score",
  #            color_group = "common",
  #            filter_field = "rgn_name",
  #            plot_type = "scatter",
  #            mode = "lines+markers",
  #            tooltip_text = ~paste("Score:", score,
  #                                  "<br>Year:", year, sep=" "),
  #            xaxis_label = "",
  #            yaxis_label = "Ratio of gas ($/barrel) to mean wage")
  
  ##RAO fish stock sustainability ##
  
  ## NOT DONE
  # callModule(card_plot, "rao_fssi",
  #            df = rao_fssi,
  #            x = "year",
  #            y = "score",
  #            color_group = "common",
  #            filter_field = "rgn_name",
  #            plot_type = "scatter",
  #            mode = "lines+markers",
  #            tooltip_text = ~paste("Score:", score,
  #                                  "<br>Year:", year, sep=" "),
  #            xaxis_label = "",
  #            yaxis_label = "")
  

}
