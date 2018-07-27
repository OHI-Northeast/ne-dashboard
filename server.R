
function(input, output, session) {
  
  
  ## Livelihoods & Economies ##
  
  ## L&E Score map ##
  callModule(card_map, "le_scores_map",
             data = le_scores,
             field = "score",
             color_palette = "YlOrRd",
             legend_title = "OHI Goal Score",
             popup_title = "Score:",
             popup_add_field = "dimension",
             popup_add_field_title = "Dimension:")
  
  ### Employment chart
  callModule(card_plot, "le_emp",
             df = noep_data,
             x = "Year",
             y = "Employment",
             color_group = "Sector",
             filter_field = "State",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Number of jobs:", Employment,
                                   "<br>Sector:", Sector,
                                   "<br>Year:", Year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Number of jobs")
  
  ### Wages
  callModule(card_plot, "le_wages",
             df = noep_data,
             x = "Year",
             y = "Wages_2012",
             color_group = "Sector",
             filter_field = "State",
             plot_type = "scatter",
             mode = "lines+markers",
             tooltip_text = ~paste("Average annual wage: $", prettyNum(Wages_2012, big.mark = ","),
                                   "<br>Sector:", Sector,
                                   "<br>Year:", Year, sep=" "),
             xaxis_label = "Year",
             yaxis_label = "Wages (2012 $USD)")
  
 ## Trash map ##
  callModule(card_map, "trash_map",
             data = trash,
             field = "pressure_score",
             color_palette = "YlOrRd",
             legend_title = "Trash Pressure Scores")

  }
