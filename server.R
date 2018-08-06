
function(input, output, session) {
  
  
  ## Livelihoods & Economies ##
  
  ## L&E Score map ##
  callModule(card_map, "le_scores_map",
             data = le_scores,
             field = "input",
             filter_field = goal,
             display_field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
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
             data = tr_scores,
             field = "score",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "rgn_name",
             popup_add_field_title = "")
  
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

  }
