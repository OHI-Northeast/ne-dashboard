source("global.R")

###Setting up the dashboard page
dashboardPage(
  dashboardHeader(
    title = "OHI for the US Northeast",
    titleWidth = 300),
  
### Dashboard sidebar  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Welcome", tabName = "welcome", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Index", tabName = "index", icon = icon("dashboard"), badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Clean Waters", tabName = "cw", badgeLabel = "draft", badgeColor = "orange"),
      convertMenuItem(menuItem("Food Provision", tabName = "fp", startExpanded = TRUE,
               menuSubItem("Wild-Caught Fisheries", tabName = "fis"),
               menuSubItem("Mariculture", tabName = "mar")), "fp"),
      menuItem("Livelihoods & Economies", tabName = "liveco", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Tourism & Recreation", tabName = "tr", badgeLabel = "draft", badgeColor = "orange"),
      convertMenuItem(menuItem("Biodiversity", tabName = "bio", startExpanded = TRUE,
               menuSubItem("Species", tabName = "spp"),
               menuSubItem("Habitats", tabName = "hab")), "bio"),
      menuItem("Sense of Place", tabName = "sop", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Local Fishing & Resource Access Opportunities ", tabName = "ao", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Coastal Protection & Carbon Storage", tabName = "cpcs", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Pressures", tabName = "pressures", badgeLabel = "draft", badgeColor = "orange")
  ),
  width = 300),
  
  
### Dashboard Body
  dashboardBody(
    #adding this tag to make header longer, from here:https://rstudio.github.io/shinydashboard/appearance.html#long-titles
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
      tags$script(HTML("$('body').addClass('fixed');")), #this locks side and top bars
    
    
### Side bar tabs

  tabItems(
    
    ## Welcome landing page##
    tabItem(tabName = "welcome",
      h2("Welcome to the Northeast Ocean Health Index")),
    
    ## Overall index scores ##
    tabItem(tabName = "index",
            h2("Index scores")),
    
    ## Clean Waters ##
    
    tabItem(tabName = "cw",
            ## Clean Waters tab title ##
            tab_title_ui(goal_text = "CLEAN WATERS",
                         commitment_text = "coastal waters which are free of contaminants"),
            
            fluidRow(
              ## Scores Map ##
              map_ui(id = "cw_scores_map",
                     title_text = "Current Scores",
                     sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
              
              card_ui(id = "cw_scores",
                      title_text     = "Scores over time",
                      sub_title_text = "Explore scores for each region over time")),
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url   = "http://ohi-science.org/goals/#clean-waters",
                                 box_width = 6),
              
              text_links_default(title = "DATA PREP",
                                 url   = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/cw#ocean-health-index---us-northeast-clean-waters-goal", 
                                 box_width = 6)),
            
            fluidRow( 
              ## CW layers ##
              card_ui(id = "cw_layers",
                      title_text = "Layers used in Clean Waters Goal",
                      sub_title_text = "",
                      select_type = "drop_down",
                      select_location = "above",
                      select_choices = c("Connecticut", "Maine", "Massachusetts-Gulf of Maine", "Massachusetts-Virginian", "New Hampshire", "New York", "Rhode Island"),
                      selected = "Connecticut",
                      select_label = "Select region",
                      source_text = "Source: multiple (fill this in)",
                      box_width = 12))),
    
    ## Food Provision ##
    tabItem(tabName = "fp",
            
            ## Biodiversity tab title ##
            tab_title_ui(goal_text = "FOOD PROVISION",
                         commitment_text = "sustainably harvested and grown seafood")),
    
    ### Fisheries ### 
    tabItem(tabName = "fis",
            
            ## Food Provision tab title ##
            tab_title_ui(goal_text = "FOOD PROVISION: Wild-Caught Fisheries",
                         commitment_text = "sustainably harvested seafood from wild-caught fisheries"),
            
            ##First row with scores map and scores over time chart
            fluidRow(
              
              ## Scores Map ##
              map_ui(id = "fis_scores_map",
                     title_text = "Current Scores",
                     sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
              
              card_ui(id = "fis_scores",
                      title_text = "Scores over time",
                      sub_title_text = "Explore scores for each region over time")),
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url = "http://ohi-science.org/goals/#food-provision"),
              
              text_links_default(title = "CATCH DATA PREP",
                                 url = "https://ohi-northeast.github.io/ne-prep/prep/fis/fish_catch.html"),
              
              text_links_default(title = "STOCK STATUS DATA PREP",
                                 url = "https://ohi-northeast.github.io/ne-prep/prep/fis/stock_status.html")),
            
            fluidRow(
              ## NOAA landings ##
              card_ui(id = "fis_noaa_catch",
                      title_text = "Landings",
                      sub_title_text = "Landings shown are for assessed stocks only",
                      select_type = "drop_down",
                      select_location = "above",
                      select_choices = unique(fis_noaa_catch$rgn_name),
                      select_label = "Select region",
                      source_text = "Source: National Ocean and Atmospheric Administration",
                      box_width = 12))
          ),
    
    ### Mariculture ###
    tabItem(tabName = "mar",
            
            ## Biodiversity tab title ##
            tab_title_ui(goal_text = "FOOD PROVISION: Mariculture",
                         commitment_text = "sustainably harvested seafood from mariculture")),
    
    ## Livelihood and economies ## 
    tabItem(tabName = "liveco",
            
          ## Livelihoods & Economies tab title ##
          tab_title_ui(goal_text = "LIVELIHOODS & ECONOMIES",
                       commitment_text = "a high quantity and quality of ocean-dependent jobs and local revenue"),
          
          ##First row with scores map and scores over time chart
          fluidRow(
            ## Scores Map ##
            map_ui(id = "le_scores_map",
                   title_text = "Livelihoods & Economies Goal Scores",
                   sub_title_text = "",
                   select_type = "radio",
                   select_location = "above",
                   select_choices = c("Economies sub-goal" = "ECO",
                                      "Livelihoods sub-goal" = "LIV",
                                      "Livelihoods & Economies goal" = "LE"),
                   select_label = "Select scores to view. Only scores from the most recent assessment (2017) are shown"),

            card_ui(id = "le_scores",
                    title_text = "OHI Scores",
                    select_type = "radio",
                    select_choices = c("Economies sub-goal" = "ECO",
                                       "Livelihoods sub-goal" = "LIV",
                                       "Livelihoods & Economies goal" = "LE"),
                    select_label = "Select scores to view")
            ),
          
          ## Text boxes with links ##
          fluidRow(
            text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                               url = "http://ohi-science.org/goals/#livelihoods-and-economies"),
            
            text_links_default(title = "JOBS DATA PREP",
                               url = "https://ohi-northeast.github.io/ne-prep/prep/liv/jobs.html"),
            
            text_links_default(title = "WAGES DATA PREP",
                               url = "https://ohi-northeast.github.io/ne-prep/prep/liv/wages.html")),
          
          fluidRow(
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
                    source_text = "Source: National Ocean Economics Program"))),
      
    ## Tourism & recreation ##
    
    tabItem(tabName = "tr",
            
        ## Tourism & Recreation tab title ##
        tab_title_ui(goal_text = "TOURISM & RECREATION",
                     commitment_text = "opportunities for people to enjoy coastal areas through tourism and recreation"),
        
        fluidRow(
            ## Scores Map ##
            map_ui(id = "tr_scores_map",
                   title_text = "Current Scores",
                   sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
            
            card_ui(id = "tr_scores",
                    title_text = "Scores over time",
                    sub_title_text = "Explore scores for each region over time")),
          
        fluidRow(  
            ## Employment ##
            card_ui(id = "tr_jobs",
                    title_text = "Jobs in Tourism",
                    sub_title_text = "",
                    source_text = "Source: National Ocean Economics Program",
                    box_width = 12))),
    
 
    ## Biodiversity ##
    
    tabItem(tabName = "bio",
            
            ## Biodiversity tab title ##
            tab_title_ui(goal_text = "BIODIVERSITY",
                         commitment_text = "a diversity of healthy marine species, habitats, and landscapes")),
    
      ### Species ### 
      
      tabItem(tabName = "spp",
              
              ## Biodiversity tab title ##
              tab_title_ui(goal_text = "BIODIVERSITY: Species",
                           commitment_text = "a diversity of healthy marine species, habitats, and landscapes"),
    
              ## Scores Map ##
              map_ui(id = "spp_scores_map",
                     title_text = "Current Scores",
                     sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
              
              card_ui(id = "spp_scores",
                      title_text = "Scores over time",
                      sub_title_text = "Explore scores for each region over time"),
      
          ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url   = "http://ohi-science.org/goals/#biodiversity",
                                 box_width = 6),
              
              text_links_default(title = "DATA PREP",
                                 url   = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/spp#species-status", 
                                 box_width = 6))),
    
    
      ### Habitats ###
      
      tabItem(tabName = "hab",
              
              ## Biodiversity tab title ##
              tab_title_ui(goal_text = "BIODIVERSITY: Habitats",
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

