#comparing plotly and highchartr

#dataset
jobs_

#plotly

p <- plot_ly(cw_scores, 
             x = ~year,
             y = ~score,
             color = ~rgn_name, 
             type = "scatter", 
             mode = "lines+markers",
             line = list(width=2),
             marker = list(size=4),
             text = ~paste("Region:", rgn_name,
                                   "<br>Score:", score,
                                   "<br>Year:", year, sep=" "), 
             hoverinfo = "text") %>%
  layout(font = list(family = "Lora", size = 14),
         xaxis = list(title = "Year", 
                      fixedrange = TRUE, 
                      linecolor = "#A9A9A9"), 
         yaxis = list(title = "Score", 
                      fixedrange = TRUE, 
                      linecolor = "#A9A9A9", 
                      zeroline = FALSE, 
                      range = c("None", "None")),
         margin = list(b = NULL)) %>%
  config(displayModeBar = F)

#ok now highcharter
library("highcharter")

#using hchart
hchart(cw_scores, "line", hcaes(x = year, y = score, group = rgn_name)) %>%
  hc_xAxis(title = list(text = "Year")) %>%
  hc_yAxis(title = list(text = "Score")) 















