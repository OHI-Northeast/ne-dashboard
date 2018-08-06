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
      menuItem("Tourism & Recreation", tabName = "tr", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Biodiversity", tabName = "bio", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Sense of Place", tabName = "sop", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Local Fishing & Resource Access Opportunities ", tabName = "ao", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Food Provision", tabName = "fp", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Coastal Protection & Carbon Storage", tabName = "cpcs", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Pressures", tabName = "pressures", badgeLabel = "draft", badgeColor = "orange")
  ),
  width = 350),
  
  
### Dashboard Body
  dashboardBody(
    #adding this tag to make header longer, from here:https://rstudio.github.io/shinydashboard/appearance.html#long-titles
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    
### Side bar tabs

  tabItems(
    
    ## Overall index scores ##
    
    tabItem(tabName = "dashboard",
            h2("Index scores")),
    
    ## Livelihood and economies ## 
    
    tabItem(tabName = "liveco",
            
          ## Livelihoods & Economies tab title ##
          tab_title_ui(goal_text = "LIVELIHOODS & ECONOMIES",
                       commitment_text = "a high quantity and quality of ocean-dependent jobs and local revenue"),
            
          ## Scores Map ##
          map_ui(id = "le_scores_map",
                 title_text = "Livelihoods & Economies Goal Scores",
                 sub_title_text = "",
                 select_type = "drop_down",
                 select_location = "above",
                 select_choices = unique(le_scores$goal),
                 select_label = "Select scores to view",
                 box_width = 6),
            
          ## Employment ##
          card_ui(id = "le_emp",
                  title_text = "Employment",
                  sub_title_text = "",
                  select_type = "drop_down",
                  select_location = "above",
                  select_choices = unique(jobs$rgn_name),
                  select_label = "Select region",
                  source_text = "Source: National Ocean Economics Program"),
    
          ## Wages ##
          card_ui(id = "le_wages",
                  title_text = "Average annual wages",
                  sub_title_text = "Wages in 2012 US Dollars",
                  select_type = "drop_down",
                  select_location = "above",
                  select_choices = unique(wages$rgn_name),
                  select_label = "Select region",
                  source_text = "Source: National Ocean Economics Program")),
    
    ## Tourism & recreation ##
    
    tabItem(tabName = "tr",
            
            ## Tourism & Recreation tab title ##
            tab_title_ui(goal_text = "TOURISM & RECREATION",
                         commitment_text = "opportunities for people to enjoy coastal areas through tourism and recreation"),
    
            ## Scores Map ##
            map_ui(id = "tr_scores_map",
                   title_text = "Tourism & Recreation Goal Scores",
                   sub_title_text = ""),
            
            ## Employment ##
            card_ui(id = "tr_jobs",
                    title_text = "Jobs in Tourism",
                    sub_title_text = "",
                    source_text = "Source: National Ocean Economics Program")),
        
    ## Biodiversity ##
    
    tabItem(tabName = "bio",
            
            ## Biodiversity tab title ##
            tab_title_ui(goal_text = "BIODIVERSITY",
                         commitment_text = "a diversity of healthy marine species, habitats, and landscapes")),
    
    ## Sense of Place ##
    
    tabItem(tabName = "sop",
            
            ## Sense of Place tab title ##
            tab_title_ui(goal_text = "SENSE OF PLACE",
                         commitment_text = "a deep sense of identity and belonging provided through connections with our marine communities")),
    
    ## Local Fishing & Resource Access Opportunities  ##
    
    tabItem(tabName = "ao",
            
            ## Local Fishing & Resource Access Opportunities tab title ##
            tab_title_ui(goal_text = "LOCAL FISHING & RESOURCE ACCESS OPPORTUNITIES",
                         commitment_text = "opportunities for Native Americans and local community members to access local natural resources")),
    
    ## Food Provision ##
    
    tabItem(tabName = "fp",
            
            ## Food Provision tab title ##
            tab_title_ui(goal_text = "FOOD PROVISION",
                         commitment_text = "sustainably harvested seafood from wild-caught fisheries and mariculture")),
    
    ## Coastal Protection & Carbon Storage ##
    
    tabItem(tabName = "cpcs",
            
            ## Coastal Protection & Carbon Storage tab title ##
            tab_title_ui(goal_text = "COASTAL PROTECTION & CARBON STORAGE",
                         commitment_text = "storage of carbon and protection of our coasts from storm damage by living natural habitats")),
    
    ## Pressures ##
    
    tabItem(tabName = "pressures",
            
            ## Pressures tab title ##
            tab_title_ui(goal_text = "Pressures",
                         commitment_text = "pressures"),
    
            ##map for trash layer ##
            map_ui(id = "trash_map",
                   title_text = "Trash pressure layer"))
  )
    )
  )

