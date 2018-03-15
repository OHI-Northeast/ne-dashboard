# Livelihoods and Economies UI and Server modules

### UI
liv_ecoUI <- function(id) {
  
  ns <- NS(id)
  
  tagList(
    h2("Livelihoods & Economies"),
    
    box(
      h4(strong("Draft Goal Definition:")), 
      h2("A healthy ocean provides a high quantity and quality of ocean-dependent jobs and local revenue"),
      width = 12
    ),
    
    #dropdown menu to select state
    selectInput(ns("state"), "State", unique(noep_data$State)),
    
    box(title = "Employment",
        width = 6,
        plotOutput(ns("employmentChart"))
      ),
     box(title = "Wages",
         width = 6,
         plotOutput(ns("wagesChart"))),
    
    #data info box
    box(
      h3("Data comes from the National Ocean Economics Program & Bureau of Labor Statistics"),
      width = 12
    )
  )
}

###Server
liv_eco <- function(input, output, session, data) {
  
  module_data <- reactive({
    data <-  noep_data %>%
      filter(State  == input$state,
             County == paste0("All ", input$state, " counties"),
             Sector != "All Ocean Sectors")
  })
  
  output$employmentChart <- renderPlot({
    
    ggplot(module_data(), aes(x = Year, y = Employment, color = Sector)) +
      geom_line()
    
  })
  
  output$wagesChart <- renderPlot({
    
    ggplot(module_data(), aes(x = Year, y = Wages_2012, color = Sector)) +
      geom_line()
    
  })
  
}