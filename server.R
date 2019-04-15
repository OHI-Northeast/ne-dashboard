
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
             field = "input",
             filter_field = goal,
             display_field = "score",
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
             filter_field = "goal",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Goal score:", score,
                                   "<br>Region:", rgn_name,
                                   "<br>Year:", year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Score")
  
  ### Employment chart
  callModule(card_plot, "le_emp",
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
  
  ### Wages
  callModule(card_plot, "le_wages",
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
