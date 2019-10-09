function(input, output, session) {

## Overall Index ----
  
  output$flowerplot <- renderUI({
    tags$img(src = "https://raw.github.com/OHI-Northeast/ne-scores/master/region/reports/figures/flower_USNortheast.png",
             height = 400,
             width  = 550)
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
    yaxis_label = "Layer Score",
    legend_or = NULL
  )
  
  ## CW Data Table
  
  output$cw_datatable = renderDataTable({
    datatable(cw_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
## Food Provision ----
  
  callModule(
    card_map,
    "fp_scores_map",
    data = fp_scores_map,
    field = "score",
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
    y = "mean_catch_times_prop",
    color_group = "display_name",
    filter_field = "rgn_name",
    plot_type = "scatter",
    legend_or = NULL,
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Species:",
      display_name,
      "<br>Pounds:",
      mean_catch_times_prop,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Catch (pounds)"
  )
  
  ### Stock assessment data chart
  callModule(
    card_plot,
    "fis_stock_ass",
    df = fis_stock_assessment,
    x = "year",
    y = "value",
    color_group = "indicator",
    filter_field = "stock",
    plot_type = "scatter",
    legend_or = NULL,
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Metric:",
      indicator,
      "<br>Value:",
      value,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Value"
  )
  
  ## FIS Data Table
  
  output$fis_datatable = renderDataTable({
    datatable(fis_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
## Aquaculture ----
  
  callModule(
    card_map,
    "mar_scores_map",
    data = mar_scores_map,
    field = "score",
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
    yaxis_range = c(min(mar_scores$score), max(mar_scores$score)),
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
  
  callModule(
    card_plot,
    "mar_production",
    df = mar_production,
    x = "Year",
    xaxis_range = c(2005,2017),
    y = "pounds",
    color_group = "Species",
    filter_field = "Region",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Species:",
      Species,
      "<br>Pounds:",
      pounds,
      "<br>Year:",
      Year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Pounds produced"
  )
  
  ## MAR Sustainability Data Table
  output$mar_spp_sust_table = renderDataTable({
    datatable(mar_spp_sust,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
  ## MAR Data Table
  
  output$mar_datatable = renderDataTable({
    datatable(mar_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
  
## Livelihoods & Economies ----
  
  ## L&E Score map ##
  callModule(
    card_map,
    "le_scores_map",
    data = le_scores_map,
    field = "score",
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
  
  ## LE Data Table
  
  output$le_datatable = renderDataTable({
    datatable(le_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
## Livelihoods ----
  
  ## Liv Score map ##
  callModule(
    card_map,
    "liv_scores_map",
    data = liv_scores_map,
    field = "score",
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
  
  ## LIV Data Table
  output$liv_datatable = renderDataTable({
    datatable(liv_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
## Economies ----
  
  ## Economies Score map ##
  callModule(
    card_map,
    "eco_scores_map",
    data = eco_scores_map,
    field = "score",
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
  ## ECO Data Table
  output$eco_datatable = renderDataTable({
    datatable(eco_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
## Tourism & Recreation ----
  
  ## TR Score map ##
  callModule(
    card_map,
    "tr_scores_map",
    data = tr_scores_map,
    field = "score",
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
  
  ##TR coastal access ##
  callModule(card_plot, "tr_coastal",
             df = tr_coastal,
             x = "rgn_name",
             y = "percent",
             color_group = "rgn_name",
             plot_type = "bar",
             tooltip_text = ~paste("Region:", rgn_name,
                                   "<br>Accessible coastline (%):", percent),
             xaxis_label = "",
             yaxis_label = "Amount of accessible coastline (%)")
  
  ## TR Data Table
  output$tr_datatable = renderDataTable({
    datatable(tr_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
## Biodiversity ----
  
  ### BIO Score map ###
  callModule(
    card_map,
    "bio_scores_map",
    data = bio_scores_map,
    field = "score",
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
  ## BIO Data Table
  output$bio_datatable = renderDataTable({
    datatable(bio_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
## Species ----
  
  ### SPP Score map ###
  callModule(
    card_map,
    "spp_scores_map",
    data = spp_scores_map,
    field = "score",
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
  ## SPP Data Table
  output$spp_datatable = renderDataTable({
    datatable(spp_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
  ##SPP number of species and status by rgn ##
  callModule(card_plot, "spp_rgn_count",
             df = spp_status_rgn,
             x = "count",
             y = "rgn_name",
             color_group = "score",
             plot_type = "bar",
             tooltip_text = ~paste("Region:", rgn_name,
                                   "<br>Status score:", score,
                                   "<br>Num. Species:", count, sep=" "),
             xaxis_label = "",
             yaxis_label = "Number of species")
  
## Habitats ----
  
  ### HAB Score map ###
  callModule(
    card_map,
    "hab_scores_map",
    data = hab_scores_map,
    field = "score",
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
  ## HAB Data Table
  output$hab_datatable = renderDataTable({
    datatable(hab_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
## Habitat Services ----

  ## HAB Score map ##
  callModule(
    card_map,
    "hs_scores_map",
    data = hs_scores_map,
    field = "score",
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
  ## HS Data Table
  output$hs_datatable = renderDataTable({
    datatable(hs_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
## Sense of Place ----
  
  ##SOP Score Map
  callModule(
    card_map,
    "sop_scores_map",
    data = sop_map,
    field = "score",
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
  
  ## LSP Data Table
  
  output$lsp_datatable = renderDataTable({
    datatable(lsp_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
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
  
  ## ICO Data Table
  
  output$ico_datatable = renderDataTable({
    datatable(ico_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
  ## Iconic species heatmap
  
  output$ico_heatmap <- renderPlot({
    
   ggplot(data = ico_heatmap_df, aes(x = rgn_name, y = common)) +
      geom_tile(aes(fill = Status))+ 
      scale_fill_viridis_d(direction = 1, na.value = "#e5e5e5") +
      theme_dark() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1),
            axis.title = element_blank(),
            panel.grid = element_blank()) +
      coord_cartesian(expand = FALSE) 
    
  })
  
  
## Resource Access Opportunities ----
  
  ## RAO Map ##
  callModule(
    card_map,
    "rao_scores_map",
    data = rao_scores_map,
    field = "score",
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
  callModule(card_plot, "rao_econ",
             df = rao_econ,
             x = "year",
             y = "ratio",
             color_group = "state",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("State:", state,
                                   "<br>Ratio:", ratio,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "",
             yaxis_label = "Ratio of gas ($/barrel) to mean wage")
  
  ##RAO average fish stock sustainability ##
  callModule(card_plot, "rao_avg_fssi",
             df = rao_avg_fssi,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Region:", rgn_name,
                                   "<br>Average FSSI:", score,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "",
             yaxis_label = "Average Fish Stock Sustainability Index")
  
  ##RAO coastal access ##
  callModule(card_plot, "rao_coastal",
             df = rao_coastal,
             x = "year",
             y = "percent",
             color_group = "rgn_name",
             plot_type = "bar",
             tooltip_text = ~paste("Region:", rgn_name,
               "<br>Accessible coastline (%):", percent,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "",
             yaxis_label = "Amount of accessible coastline (%)")
  
  ## RAO Data Table
  output$rao_datatable = renderDataTable({
    datatable(rao_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })

}
