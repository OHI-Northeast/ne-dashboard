source("global.R")

###Setting up the dashboard page
dashboardPage(
  dashboardHeader(
    title = "Ocean Health Index for the US Northeast",
    titleWidth = 375),
  
### Dashboard sidebar  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Index", tabName = "dashboard", icon = icon("dashboard"), badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Livelihoods & Economies", tabName = "liveco", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Tourism & Recreation", tabName = "tr", badgeLabel = "draft", badgeColor = "orange")
  ),
  width = 300),
  
  
### Dashboard Body
  dashboardBody(
    #adding this tag to make header longer, from here:https://rstudio.github.io/shinydashboard/appearance.html#long-titles
    tags$head(
      #tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
              tags$style(HTML('
                  .skin-blue .main-header .logo {
                    background-color: #3c8dbc;
                  }
                  .skin-blue .main-header .logo:hover {
                    background-color: #3c8dbc;
                  }
                '))),
    
#Side bar tabs
  tabItems(
    #Overall index scores
    tabItem(tabName = "dashboard",
            h2("Index scores")),
    
    #Livelihood and economies
    tabItem(tabName = "liveco",
            liv_ecoUI("one")),
    
    #Tourism & recreation
    tabItem(tabName = "tr",
            h2("Tourism & Recreation"))
  )
    )
  )

