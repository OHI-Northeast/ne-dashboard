
function(input, output, session) {
  
  ## Clean Waters ##
  
  ## CW Score map ##
  callModule(card_map, "cw_scores_map",
             data = cw_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "cw_scores",
             df = cw_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  ### CW layers chart
  callModule(card_plot, "cw_layers",
             df = cw_layers,
             x = "year",
             y = "score",
             color_group = "layer",
             filter_field = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Score:", score,
                                   "<br>Layer:", layer,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Layer Score")
  
  ## Food Provision ##
  
  ## FIS Score map ##
  callModule(card_map, "fis_scores_map",
             data = fis_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "fis_scores",
             df = fis_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  ### NOAA landings chart
  callModule(card_plot, "fis_noaa_catch",
             df = fis_noaa_catch,
             x = "year",
             y = "mean_catch_times_prop",
             color_group = "species",
             filter_field = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Species:", species,
                                   "<br>Pounds:", mean_catch_times_prop,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Catch (pounds)")
  
  
  ## Livelihoods & Economies ##
  
  ## L&E Score map ##
  callModule(card_map, "le_scores_map",
             data = le_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "le_scores",
             df = le_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  ## Livelihoods ##
  
  ## Liv Score map ##
  callModule(card_map, "liv_scores_map",
             data = liv_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "liv_scores",
             df = liv_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  ### Employment chart
  callModule(card_plot, "liv_emp",
             df = jobs,
             x = "Year",
             y = "Employment",
             color_group = "Sector",
             filter_field = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Number of jobs:", Employment,
                                   "<br>Sector:", Sector,
                                   "<br>Year:", Year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Number of jobs")
  
  ###job scores
  callModule(card_plot, "liv_emp_scores",
             df = jobs_scores,
             x = "scenario_year",
             y = "job_score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Job score:", job_score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", scenario_year, sep = " "),
             xaxis_label = "Year",
             yaxis_label = "Job score")
  
  ### Wages
  callModule(card_plot, "liv_wages",
             df = wages,
             x = "Year",
             y = "Wages",
             color_group = "Sector",
             filter_field = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Average annual wage: $", prettyNum(Wages, big.mark = ","),
                                   "<br>Sector:", Sector,
                                   "<br>Year:", Year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Wages (2012 $USD)")
  
  ###wage scores
  callModule(card_plot, "liv_wage_scores",
             df = wages_scores,
             x = "scenario_year",
             y = "wages_score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Wage score:", wages_score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", scenario_year, sep = " "),
             xaxis_label = "Year",
             yaxis_label = "Wage score")
  
  ## Economies ##
  
  ## Economies Score map ##
  callModule(card_map, "eco_scores_map",
             data = eco_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "eco_scores",
             df = eco_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  
  ### GDP
  callModule(card_plot, "eco_gdp",
             df = gdp,
             x = "Year",
             y = "GDP",
             color_group = "Sector",
             filter_field = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("GDP: $", prettyNum(GDP, big.mark = ","),
                                   "<br>Sector:", Sector,
                                   "<br>Year:", Year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Gross Domestic Product (2012 $USD)")
  
  ## Scores time series chart ##
  callModule(card_plot, "eco_gdp_scores",
             df = gdp_scores,
             x = "scenario_year",
             y = "status",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("GDP score:", status,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", scenario_year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  
  ## Tourism & Recreation ##
  
  ## TR Score map ##
  callModule(card_map, "tr_scores_map",
             data = tr_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "tr_scores",
             df = tr_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  ### Employment chart
  callModule(card_plot, "tr_jobs",
             df = tr_jobs,
             x = "Year",
             y = "Employment",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Number of jobs:", Employment,
                                   "<br>Sector:", Sector,
                                   "<br>Year:", Year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Number of jobs")
  
  ## Biodiversity ##
  
  ## Species ##
  
  ## SPP Score map ##
  callModule(card_map, "spp_scores_map",
             data = spp_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "spp_scores",
             df = spp_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  ## Habitats ##
  
  ## HAB Score map ##
  callModule(card_map, "hab_scores_map",
             data = hab_scores_map,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
  ## Scores time series chart ##
  callModule(card_plot, "hab_scores",
             df = hab_scores,
             x = "year",
             y = "score",
             color_group = "rgn_name",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")

  }
