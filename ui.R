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
      menuItem("Overall Ocean Health", tabName = "index", icon = icon("dashboard"), badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Clean Waters", tabName = "cw", badgeLabel = "draft", badgeColor = "orange"),
      convertMenuItem(menuItem("Food Provision", tabName = "fp", startExpanded = TRUE,
               menuSubItem("Wild-Caught Fisheries", tabName = "fis"),
               menuSubItem("Aquaculture", tabName = "mar")), "fp"),
      convertMenuItem(menuItem("Livelihoods & Economies", tabName = "liveco", 
                               startExpanded = TRUE,
               menuSubItem("Livelihoods", tabName = "liv"),
               menuSubItem("Economies", tabName = "eco")), "liveco"),
      menuItem("Tourism & Recreation", tabName = "tr", badgeLabel = "draft", badgeColor = "orange"),
      convertMenuItem(menuItem("Biodiversity", tabName = "bio", startExpanded = TRUE,
               menuSubItem("Species", tabName = "spp"),
               menuSubItem("Habitats", tabName = "hab")), "bio"),
      convertMenuItem(menuItem("Sense of Place", tabName = "sop", startExpanded = TRUE,
               menuSubItem("Lasting Special Places", tabName = "lsp"),
               menuSubItem("Iconic Species", tabName = "ico")), "sop"),
      menuItem("Resource Access Opportunities ", tabName = "ao", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Habitat Services", tabName = "hs", badgeLabel = "draft", badgeColor = "orange"),
      menuItem("Pressures", tabName = "pressures", badgeLabel = "draft", badgeColor = "orange")
  ),
  width = 300,
  
  tags$footer(p("Dashboard developed by ", a(href = 'https://www.jamieafflerbach.com/', "Jamie Afflerbach.")),
              br(),
              p("This project was funded by the ", a(href = 'https://www.moore.org/', "Gordon & Betty Moore Foundation")), align = "left", style = "
                position:absolute;
                bottom:0;
                width:100%;
                height:120px; /* Height of the footer */
                color: white;
                padding: 10px;
                background-color: black;
                z-index: 1000;"
  )
  ),
  
  
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
            
        fluidRow(box(h1("Ocean Health Dashboard for the US Northeast"),
                      "The Ocean Health Index measures what people value about oceans and provides a holistic picture on how to manage ocean benefits sustainably for future generations.", width = 12)),
        
        fluidRow(box(h3("How healthy are oceans in the US Northeast?"),
                     br(),
                     p("Ocean Health Index assessments uses the best-available data to measure progress toward target conditions for benefits provided by a region's marine ecosystems, reslting in benefit-specific and overall health scores on a scale of 0 to 100. **Dive Deeper**(link to overall health page"), width = 12)),
        
        # infoBoxes with goal scores for Northeast region
        fluidRow(
          infoBox("Clean Waters", tags$p(filter(cw_scores_map, region_id == 0)$score, style = "font-size: 200%;"), 
                  icon = icon("tint"), color = "teal", fill = TRUE, width = 3),
          infoBox("Food Provision", tags$p(filter(fis_scores_map, region_id == 0)$score, style = "font-size: 200%;"),
                  icon = icon("utensils"),color = "red", fill = TRUE, width = 3),
          infoBox("Livelihoods & Economies", tags$p(filter(le_scores_map, region_id == 0)$score, style = "font-size: 200%;"),
                  icon = icon("money"),color = "green", fill = TRUE, width = 3),
          infoBox("Tourism & Recreation", tags$p(filter(tr_scores_map, region_id == 0)$score, style = "font-size: 200%;"),
                  icon = icon("umbrella-beach"),color = "yellow", fill = TRUE, width = 3)
        ),
        
        fluidRow(
          infoBox("Biodiversity", tags$p(filter(bio_scores_map, region_id == 0)$score, style = "font-size: 200%;"),
                  icon = icon("fish"), color = "blue", fill = TRUE, width = 3),
          infoBox("Sense of Place", tags$p(filter(sop_map, region_id == 0)$score, style = "font-size: 200%;"),
                  icon = icon("home"), color = "aqua", fill = TRUE, width = 3),
          infoBox("Resource Access Opportunities", tags$p(filter(le_scores_map, region_id == 0)$score, style = "font-size: 200%;"),
                  icon = icon("ship"), color = "orange", fill = TRUE, width = 3),
          infoBox("Habitat Services", tags$p(filter(hs_scores_map, region_id == 0)$score, style = "font-size: 200%;"),
                  icon = icon("pagelines"), color = "purple", fill = TRUE, width = 3)
        ),
        
        fluidRow(box(h3("What is the Northeast OHI?"),
                 br(),
                 "(need to add links)"),
        
              box(h3("Access Ocean Health Index Data"),
                  br(),
                      "(need to add links")),
        
        fluidRow(box(h3("About the Assessment"),
          "The goal of this assessment is to serve regional ocean planning by providing a big picture perspective on ocean health based on data and priorities specific to the Northeast. The assessment was led by a team of scientists from the Ocean Health Index program at the National Center for Ecological Analysis and Synthesis (NCEAS). This team worked with the Northeast Regional Ocean Council (NROC) Ocean PLanning Committee to get stakeholder input from federal, state, and local governmnetal organizations, NGO's, and community members. More information can be found at ", a(href = "http://www.ohi-northeast.org/", "ohi-northeast.org", "."), width = 12))),
            
    
    ## Overall index scores ##
    tabItem(tabName = "index",
            
            fluidRow(box(h1("Overall Ocean Health"),
                         "more text here on what this page is about", width = 12)),
            
            fluidRow(
              ## Scores Map ##
              map_ui(id = "indx_scores_map",
                     title_text = "Current Scores",
                     sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
              
              uiOutput("flowerplot")),
            
            fluidRow(
              card_ui(id = "indx_scores",
                      title_text     = "Scores over time",
                      sub_title_text = "Index scores for each region over time",
                      box_width = 12))
            ),
    
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
            
            ## tab title ##
            tab_title_ui(goal_text = "FOOD PROVISION",
                         commitment_text = "sustainably harvested and grown seafood"),
    
            ##First row with scores map and scores over time chart
            fluidRow(
              
              ## Scores Map ##
              map_ui(id = "fp_scores_map",
                     title_text = "Current Scores",
                     sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
              
              card_ui(id = "fp_scores",
                      title_text = "Scores over time",
              sub_title_text = "Explore scores for each region over time"))),
    
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
                                 url = "https://ohi-northeast.github.io/ne-prep/prep/fis/noaa_spatial_fish_catch.html"),
              
              text_links_default(title = "STOCK STATUS DATA PREP",
                                 url = "https://ohi-northeast.github.io/ne-prep/prep/fis/stock_scores.html")),
            
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
            tab_title_ui(goal_text = "FOOD PROVISION: Aquaculture",
                         commitment_text = "sustainably produced seafood from aquaculture"),
  
            ##First row with scores map and scores over time chart
            fluidRow(
              
              ## Scores Map ##
              map_ui(id = "mar_scores_map",
                     title_text = "Current Scores",
                     sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
              
              card_ui(id = "mar_scores",
                      title_text = "Scores over time",
                      sub_title_text = "Explore scores for each region over time"))),

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
                   sub_title_text = "This map shows scores from the most recent assessment (2017) are shown"),

            card_ui(id = "le_scores",
                    title_text = "Scores over time",
                    sub_title_text = "Explore scores for each region over time")),
          
          ## Text boxes with links ##
          fluidRow(
            text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                               url = "http://ohi-science.org/goals/#livelihoods-and-economies"),
            
            text_links_default(title = "JOBS DATA PREP",
                               url = "https://ohi-northeast.github.io/ne-prep/prep/liv/jobs.html"),
            
            text_links_default(title = "WAGES DATA PREP",
                               url = "https://ohi-northeast.github.io/ne-prep/prep/liv/wages.html"))
          ),
          
      ##Livelihoods##
      tabItem(tabName = "liv",
              
              ## Biodiversity tab title ##
              tab_title_ui(goal_text = "Livelihoods",
                           commitment_text = ""),
              
              ##First row with scores map and scores over time chart
              fluidRow(
                ## Scores Map ##
                map_ui(id = "liv_scores_map",
                       title_text = "Livelihoods Sub-Goal Scores",
                       sub_title_text = "This map shows scores from the most recent assessment (2017) are shown"),
                
                card_ui(id = "liv_scores",
                        title_text = "Scores over time",
                        sub_title_text = "Explore scores for each region over time")),
              
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
            card_ui(id = "liv_emp",
                    title_text = "Employment",
                    sub_title_text = "",
                    select_type = "drop_down",
                    select_location = "above",
                    select_choices = unique(jobs_scores$rgn_name),
                    select_label = "Select region",
                    source_text = "Source: National Ocean Economics Program"),
          
            #job scores by region between 0 and 1
            card_ui(id = "liv_emp_scores",
                    title_text = "Job scores",
                    source_text = "Source: National Ocean Economics Program")
            ),
    
    
        fluidRow(
          
          ## Wages ##
          card_ui(id = "liv_wages",
                  title_text = "Average annual wages",
                  sub_title_text = "",
                  select_type = "drop_down",
                  select_location = "above",
                  select_choices = unique(wages_scores$rgn_name),
                  select_label = "Select region",
                  source_text = "Source: National Ocean Economics Program"),
          
          
          #wage scores by region between 0 and 1
          card_ui(id = "liv_wage_scores",
                  title_text = "Wage scores",
                  sub_title_text = "A score of 1 indicates wage growth of at least 3.5% annually",
                  source_text = "Source: National Ocean Economics Program"))
      ),
    
    ##Economies##
    tabItem(tabName = "eco",
            
            ## Biodiversity tab title ##
            tab_title_ui(goal_text = "Economies",
                         commitment_text = ""),
            
            ##First row with scores map and scores over time chart
            fluidRow(
              ## Scores Map ##
              map_ui(id = "eco_scores_map",
                     title_text = "Economies Sub-Goal Scores",
                     sub_title_text = "This map shows scores from the most recent assessment (2017) are shown"),
              
              card_ui(id = "eco_scores",
                      title_text = "Scores over time",
                      sub_title_text = "Explore scores for each region over time")),
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url = "http://ohi-science.org/goals/#livelihoods-and-economies"),
              
              text_links_default(title = "GDP DATA PREP",
                                 box_width = 6,
                                 url = "https://ohi-northeast.github.io/ne-prep/prep/eco/gdp.html")),
            
            fluidRow(
              
              ## GDP ##
              card_ui(id = "eco_gdp",
                      title_text = "Gross Domestic Product",
                      sub_title_text = "GDP in 2012 US Dollars",
                      select_type = "drop_down",
                      select_location = "above",
                      select_choices = unique(gdp$rgn_name),
                      select_label = "Select region",
                      source_text = "Source: National Ocean Economics Program"),
              
              #wage scores by region between 0 and 1
              card_ui(id = "eco_gdp_scores",
                      title_text = "GDP scores",
                      sub_title_text = "",
                      source_text = "Source: National Ocean Economics Program"))
    ),
    
      
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
                         commitment_text = "a diversity of healthy marine species, habitats, and landscapes"),
            
            ## Scores Map ##
            map_ui(id = "bio_scores_map",
                   title_text = "Current Scores",
                   sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
            
            card_ui(id = "bio_scores",
                    title_text = "Scores over time",
                    sub_title_text = "Explore scores for each region over time"),
            
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url   = "http://ohi-science.org/goals/#biodiversity",
                                 box_width = 12)),
            fluidRow(
              ## Species sub-goal scores##
              card_ui(id = "bio_spp_scores",
                      title_text = "Species sub-goal scores",
                      sub_title_text = ""),
              
              ## Habitat sub-goal scores##
              card_ui(id = "bio_hab_scores",
                      title_text = "Habitat sub-goal scores",
                      sub_title_text = ""))
            ),
    
      ### Species ### 
      
      tabItem(tabName = "spp",
              
              ## Biodiversity:species tab title ##
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
              
              ## Biodiversity: habitats tab title ##
              tab_title_ui(goal_text = "BIODIVERSITY: Habitats",
                           commitment_text = "a diversity of healthy marine species, habitats, and landscapes"),
    
              ## Scores Map ##
              map_ui(id = "hab_scores_map",
                     title_text = "Current Scores",
                     sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
              
              card_ui(id = "hab_scores",
                      title_text = "Scores over time",
                      sub_title_text = "Explore scores for each region over time"),
              
              ## Text boxes with links ##
              fluidRow(
                text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                   url   = "http://ohi-science.org/goals/#biodiversity",
                                   box_width = 6),
                
                text_links_default(title = "DATA PREP",
                                   url   = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/spp#species-status", 
                                   box_width = 6)),
              
              
              fluidRow(
                ## Raw habitat data ##
                card_ui(id = "hab_raw_data",
                        title_text = "Habitat data",
                        sub_title_text = "",
                        select_type = "radio",
                        select_location = "above",
                        select_choices = list("Eelgrass" = "eelgrass",
                                              "Salt Marsh" = "salt_marsh",
                                              "Offshore habitats" = "offshore"),
                        source_text = "Source: "),
                
                
                ## Habitat layer scores b/w 0 and 100 ##
                card_ui(id = "hab_layer_scores",
                        title_text = "Habitat layer scores between 0 and 100",
                        sub_title_text = "",
                        select_type = "radio",
                        select_location = "above",
                        select_choices = list("Eelgrass" = "eelgrass",
                                              "Salt Marsh" = "salt_marsh",
                                              "Offshore habitats" = "offshore"),
                        source_text = ""))),

    ## Sense of Place ##
    
    tabItem(tabName = "sop",
            
            ## Sense of Place tab title ##
            tab_title_ui(goal_text = "SENSE OF PLACE",
                         commitment_text = "a deep sense of identity and belonging provided through connections with our marine communities"),
            
            ## Scores Map ##
            map_ui(id = "sop_scores_map",
                   title_text = "Current Scores",
                   sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
            
            card_ui(id = "sop_scores",
                    title_text = "Scores over time",
                    sub_title_text = "Explore scores for each region over time"),
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url   = "http://ohi-science.org/goals/#sense-of-place",
                                 box_width = 12)),
            
            fluidRow(
              #lasting special places scores
              card_ui(id = "sop_lsp_scores",
                      title_text = "Lasting Special Places subgoal",
                      sub_title_text = "Explore scores for each region over time"),
              
              card_ui(id = "sop_ico_scores",
                      title_text = "Iconic Species subgoal",
                      sub_title_text = ""))),
    
    ## Lasting Special Places ##
    
    tabItem(tabName = "lsp",
            
            ## Biodiversity: habitats tab title ##
            tab_title_ui(goal_text = "SENSE OF PLACE: Lasting Special Places",
                         commitment_text = ""),
            
            ## Scores Map ##
            map_ui(id = "lsp_scores_map",
                   title_text = "Current Scores",
                   sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
            
            card_ui(id = "lsp_scores",
                    title_text = "Scores over time",
                    sub_title_text = "Explore scores for each region over time"),
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url   = "http://ohi-science.org/goals/#sense-of-place",
                                 box_width = 6),
              
              text_links_default(title = "DATA PREP",
                                 url   = "https://ohi-northeast.github.io/ne-prep/prep/sop/lsp/lsp.html", 
                                 box_width = 6)),
            
            fluidRow(
              ## Protected marine areas ##
              card_ui(id = "lsp_marine",
                      title_text = "Proportion of area protected within state waters",
                      sub_title_text = "",
                      source_text = "Source: "),
              
              ## Protected land in coastal 1km ##
              card_ui(id = "lsp_land",
                      title_text = "Proportion of area protected on land within 1km of the coastline",
                      sub_title_text = "",
                      source_text = ""))
    ),
    
    ## Iconic Species ##
    
    tabItem(tabName = "ico",
            
            ## Biodiversity: habitats tab title ##
            tab_title_ui(goal_text = "SENSE OF PLACE: Iconic Species",
                         commitment_text = ""),
            
            ## Scores Map ##
            map_ui(id = "ico_scores_map",
                   title_text = "Current Scores",
                   sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
            
            card_ui(id = "ico_scores",
                    title_text = "Scores over time",
                    sub_title_text = "Explore scores for each region over time"),
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url   = "http://ohi-science.org/goals/#sense-of-place",
                                 box_width = 6),
              
              text_links_default(title = "DATA PREP",
                                 url   = "https://ohi-northeast.github.io/ne-prep/prep/sop/ico/iconic_species.html", 
                                 box_width = 6)),
            
            fluidRow(
              ## Protected marine areas ##
              card_ui(id = "ico_species_scores",
                      title_text = "Species status by region",
                      sub_title_text = "",
                      select_type = "drop_down",
                      select_location = "above",
                      select_choices = unique(ico_species_scores$rgn_name),
                      select_label = "Select region",
                      source_text = "Source: NatureServe and IUCN",
                      box_width = 12))
            
    ),
    
    ## Local Fishing & Resource Access Opportunities  ##
    
    tabItem(tabName = "ao",
            
            ## Local Fishing & Resource Access Opportunities tab title ##
            tab_title_ui(goal_text = "LOCAL FISHING & RESOURCE ACCESS OPPORTUNITIES",
                         commitment_text = "opportunities for Native Americans and local community members to access local natural resources")),
    
    ## Habitat Services ##
    
    tabItem(tabName = "hs",
            
            ## Habitat Services tab title ##
            tab_title_ui(goal_text = "Habitat Services",
                         commitment_text = "storage of carbon and protection of our coasts from storm damage by living natural habitats"),
            
            ## Scores Map ##
            map_ui(id = "hs_scores_map",
                   title_text = "Current Scores",
                   sub_title_text = "This map shows scores from the most recent assessed year (2017)"),
            
            card_ui(id = "hs_scores",
                    title_text = "Scores over time",
                    sub_title_text = "Explore scores for each region over time"),
            
            ## Text boxes with links ##
            fluidRow(
              text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                                 url   = "http://ohi-science.org/goals/#biodiversity",
                                 box_width = 6),
              
              text_links_default(title = "DATA PREP",
                                 url   = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/spp#species-status", 
                                 box_width = 6)),
            
            
            fluidRow(
              ## Coastal Protection ##
              card_ui(id = "coastal_protection",
                      title_text = "Coastal Protection scores",
                      sub_title_text = "",
                      source_text = "Source: "),
              
              
              ## Carbon Storage ##
              card_ui(id = "carbon_storage",
                      title_text = "Carbon Storage scores",
                      sub_title_text = "",
                      source_text = "Source: "))
    ),
    
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

