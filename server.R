function(input, output, session) {

## Overall Index ----
  
  output$flowerplot <- renderUI({
    
    image <- paste0("https://raw.github.com/OHI-Northeast/ne-scores/master/region/reports/figures/trimmed_flower_", input$img_region,".png")
    
    div(tags$img(src = image, width  = 400), style = "text-align: center;")
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
    colors = chart_colors_all_rgns,
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
  
  ## Region goal scores over time ##
  callModule(
    card_plot,
    "rgn_goal_scores",
    df = rgn_goal_scores,
    x = "year",
    y = "score",
    color_group = "goal",
    filter_field = "rgn_name",
    colors = rgn_goal_colors,
    legend_or = NULL,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Index score:",
      score,
      "<br>Goal:",
      goal,
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    colors = chart_colors_all_rgns,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
  
  
  ## FP Data Table
  
  output$fp_datatable = renderDataTable({
    datatable(fp_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
  ## FP layers chart
  callModule(
    card_plot,
    "fp_layers",
    df = fp_layers,
    x = "year",
    y = "score",
    color_group = "goal_name",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", score,
                           "<br>Layer:", goal_name,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Sub-goal Score"
  )
  
  ## Production and Catch bar chart
  
  callModule(
    card_plot,
    "fp_weights",
    df = production_weights,
    x = "year",
    y = "Pounds",
    color_group = "type",
    plot_type = "bar",
    filter_field = "rgn_name",
    tooltip_text = ~ paste("Pounds:", Pounds,
                           "<br>Sector:", type,
                           "<br>Year:", year),
    xaxis_label = "",
    yaxis_label = "Pounds"
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
    colors = chart_colors_all_rgns,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    color_group = "fixed_name",
    colors = chart_colors,
    filter_field = "rgn_name",
    plot_type = "scatter",
    legend_or = NULL,
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Species:",
      fixed_name,
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
    colors = c("#38598CFF", "#51C56AFF", "darkgray"),
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
  
  ## LE layers chart
  callModule(
    card_plot,
    "le_layers",
    df = le_layers,
    x = "year",
    y = "score",
    color_group = "goal_name",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", score,
                           "<br>Layer:", goal_name,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Sub-goal Score",
    legend_or = NULL
  )
  
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
      "Percent closed:",
      perc_closed, "%",
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      Year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Average percentage (%) of swim season closed"
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
             yaxis_label = "Amount of accessible coastline (%)",
             show_legend = FALSE)
  
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
    colors = chart_colors_all_rgns,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
  
  ## BIO layers chart
  callModule(
    card_plot,
    "bio_layers",
    df = bio_layers,
    x = "year",
    y = "score",
    color_group = "goal_name",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", score,
                           "<br>Layer:", goal_name,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Sub-goal Score",
    legend_or = NULL
  )
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
    colors = chart_colors_all_rgns,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
             colors = brewer.pal(10, "Spectral"),
             plot_type = "bar",
             tooltip_text = ~paste("Region:", rgn_name,
                                   "<br>Species status score:", score,
                                   "<br>Num. Species:", count, sep=" "),
             xaxis_label = "Number of species",
             yaxis_label = "")
  
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
    colors = chart_colors_all_rgns,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    tooltip_text = ~ paste("Region:", rgn_name,
                           "Score:", score,
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    tooltip_text = ~ paste("Region:", rgn_name,
                           "Score:", cp_score,
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
    tooltip_text = ~ paste("Region:", rgn_name,
                           "Score:", cs_score,
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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

  ###SOP layers chart
  callModule(
    card_plot,
    "sop_layers",
    df = sop_layers,
    x = "year",
    y = "score",
    color_group = "goal_name",
    filter_field = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste("Score:", score,
                           "<br>Layer:", goal_name,
                           "<br>Year:", year, sep = " "),
    xaxis_label = "",
    yaxis_label = "Sub-goal Score",
    legend_or = NULL
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
    y = "perc_area",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Amount protected:",
      perc_area, "%",
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Amount (%) of total marine area protected"
  )
  
  ## land protected area ##
  callModule(
    card_plot,
    "lsp_land",
    df = land_protection,
    x = "year",
    y = "perc_area",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Amount protected:",
      perc_area, "%",
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Amount (%) of coastal land area protected"
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
      theme(axis.title = element_blank(),
            panel.grid = element_blank()) +
      coord_cartesian(expand = FALSE) 
    
  })
  
  
## Fishing Engagement ----
  
  ## spfis Score map ##
  callModule(
    card_map,
    "spfis_scores_map",
    data = spfis_map,
    field = "score",
    popup_title = "Score:",
    popup_add_field = "rgn_name",
    popup_add_field_title = ""
  )
  
  ## Scores time series chart ##
  callModule(
    card_plot,
    "spfis_scores",
    df = spfis_scores,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
  
  ## Data Table
  
  output$spfis_datatable = renderDataTable({
    datatable(spfis_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })
  
  ## commercial fishing engagement ##
  callModule(
    card_plot,
    "spfis_commercial",
    df = spfis_commercial,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Commercial fishing engagement score"
  )
  
  ## recreational fishing reliance ##
  callModule(
    card_plot,
    "spfis_rec",
    df = spfis_rec,
    x = "year",
    y = "score",
    color_group = "rgn_name",
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
      score,
      "<br>Region:",
      rgn_name,
      "<br>Year:",
      year,
      sep = " "
    ),
    xaxis_label = "",
    yaxis_label = "Recreational fishing reliance"
  )
  
  
  
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
    colors = chart_colors_coastal,
    plot_type = "scatter",
    mode = "lines+markers",
    tooltip_text = ~ paste(
      "Score:",
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
             x = "rgn_name",
             y = "percent",
             color_group = "rgn_name",
             plot_type = "bar",
             tooltip_text = ~paste("Region:", rgn_name,
               "<br>Accessible coastline (%):", percent),
             xaxis_label = "",
             yaxis_label = "Amount of accessible coastline (%)",
             show_legend = FALSE)
  
  ## RAO Data Table
  output$rao_datatable = renderDataTable({
    datatable(rao_data_info,
              options = list(dom = 't'),
              rownames = FALSE,
              escape = FALSE)
  })

}
