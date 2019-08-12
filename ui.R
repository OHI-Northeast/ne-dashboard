source("global.R")

## Setting up the dashboard page
dashboardPage(
  dashboardHeader(title = "OHI for the US Northeast",
                  titleWidth = 300),
  
## Dashboard sidebar-----
  dashboardSidebar(
    sidebarMenu(
      menuItem("Welcome", tabName = "welcome"),
      menuItem(
        "Overall Ocean Health",
        tabName = "index",
        icon = icon("dashboard")
      ),
      menuItem("Clean Waters", tabName = "cw"),
      convertMenuItem(
        menuItem(
          "Food Provision",
          tabName = "fp",
          startExpanded = FALSE,
          menuSubItem("Wild-Caught Fisheries", tabName = "fis"),
          menuSubItem("Aquaculture", tabName = "mar")
        ),
        tabName = "fp"
      ),
      convertMenuItem(
        menuItem(
          "Livelihoods & Economies",
          tabName = "liveco",
          startExpanded = FALSE,
          menuSubItem("Livelihoods", tabName = "liv"),
          menuSubItem("Economies", tabName = "eco")
        ),
        tabName = "liveco"
      ),
      menuItem("Tourism & Recreation", tabName = "tr"),
      convertMenuItem(
        menuItem(
          "Biodiversity",
          tabName = "bio",
          startExpanded = FALSE,
          menuSubItem("Species", tabName = "spp"),
          menuSubItem("Habitats", tabName = "hab")
        ),
        tabName = "bio"
      ),
      convertMenuItem(
        menuItem(
          "Sense of Place",
          tabName = "sop",
          startExpanded = FALSE,
          menuSubItem("Lasting Special Places", tabName = "lsp"),
          menuSubItem("Iconic Species", tabName = "ico")
        ),
        tabName = "sop"
      ),
      menuItem("Resource Access Opportunities ", tabName = "rao"),
      menuItem("Habitat Services", tabName = "hs"),
      menuItem("Pressures", tabName = "pressures")
    ),
    width = 300,
    
    tags$footer(
      p(
        "Dashboard developed by ",
        a(href = 'https://www.jamieafflerbach.com/', "Jamie Afflerbach.")
      ),
      br(),
      p(
        "This project was funded by the ",
        a(href = 'https://www.moore.org/', "Gordon & Betty Moore Foundation")
      ),
      align = "left",
      style = "
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
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    tags$script(HTML("$('body').addClass('fixed');")),
    #this locks side and top bars
    
  
    tabItems(
      
## Welcome landing page ----
      tabItem(
        tabName = "welcome",
        
        fluidRow(
          box(
            h1("Ocean Health Dashboard for the US Northeast"),
            "The Ocean Health Index measures what people value about oceans and provides a holistic picture on how to manage ocean benefits sustainably for future generations.",
            width = 12
          )
        ),
        
        fluidRow(box(
          h3("How healthy are oceans in the US Northeast?"),
          br(),
          p(
            "Ocean Health Index assessments uses the best-available data to measure progress toward target conditions for benefits provided by a region's marine ecosystems, reslting in benefit-specific and overall health scores on a scale of 0 to 100. **Dive Deeper**(link to overall health page"
          ),
          width = 12
        )),
        
        # infoBoxes with goal scores for Northeast region
        fluidRow(
          tags$div(
            href = "#shiny-tab-cw",
            "data-toggle" = "tab",
            infoBox(
              "Clean Waters",
              tags$p(filter(cw_scores_map, region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("tint"),
              color = "teal",
              fill = TRUE,
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-fp",
            "data-toggle" = "tab",
            infoBox(
              "Food Provision",
              tags$p(filter(fp_scores_map,
                            region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("utensils"),
              color = "red",
              fill = TRUE,
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-liveco",
            "data-toggle" = "tab",
            infoBox(
              "Livelihoods & Economies",
              tags$p(filter(le_scores_map,
                            region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("money"),
              color = "green",
              fill = TRUE,
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-tr",
            "data-toggle" = "tab",
            infoBox(
              "Tourism & Recreation",
              tags$p(filter(tr_scores_map,
                            region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("umbrella-beach"),
              color = "yellow",
              fill = TRUE,
              width = 3
            )
          )
        ),
        
        fluidRow(
          tags$div(
            href = "#shiny-tab-bio",
            "data-toggle" = "tab",
            infoBox(
              "Biodiversity",
              tags$p(filter(bio_scores_map, region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("fish"),
              color = "blue",
              fill = TRUE,
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-sop",
            "data-toggle" = "tab",
            infoBox(
              "Sense of Place",
              tags$p(filter(sop_map, region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("home"),
              color = "aqua",
              fill = TRUE,
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-rao",
            "data-toggle" = "tab",
            infoBox(
              "Resource Access Opportunities",
              tags$p(filter(rao_scores_map, region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("ship"),
              color = "orange",
              fill = TRUE,
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-hs",
            "data-toggle" = "tab",
            infoBox(
              "Habitat Services",
              tags$p(filter(hs_scores_map, region_id == 0)$score,
                     style = "font-size: 200%;"),
              icon = icon("pagelines"),
              color = "purple",
              fill = TRUE,
              width = 3
            )
          )
        ),
        
        fluidRow(
          box(h3("What is the Northeast OHI?"),
              br(),
              "(need to add links)"),
          
          box(h3("Access Ocean Health Index Data"),
              br(),
              "(need to add links")
        ),
        
        fluidRow(
          box(
            h3("About the Assessment"),
            "The goal of this assessment is to serve regional ocean planning by providing a big picture perspective on ocean health based on data and priorities specific to the Northeast. The assessment was led by a team of scientists from the Ocean Health Index program at the National Center for Ecological Analysis and Synthesis (NCEAS). This team worked with the Northeast Regional Ocean Council (NROC) Ocean PLanning Committee to get stakeholder input from federal, state, and local governmnetal organizations, NGO's, and community members. More information can be found at ",
            a(href = "http://www.ohi-northeast.org/", "ohi-northeast.org", "."),
            width = 12
          )
        )
      ),
      
            
## Overall index scores------
tabItem(tabName = "index",
        
        fluidRow(box(
          h1("Overall Ocean Health"),
          "more text here on what this page is about",
          width = 12
        )),
        
        fluidRow(
          ## scores map
          map_ui(
            id = "indx_scores_map"
          ),
          
          uiOutput("flowerplot")
        ),
        
        fluidRow(
          ## scores through time
          card_ui(
            id             = "indx_scores",
            box_width      = 12
          )
        )), 

## Clean Waters ---------

tabItem(
  tabName = "cw",

  fluidRow(box(
    h1("CLEAN WATERS"),
    width = 9
    ),
      infoBox(
        "",
        tags$p(filter(cw_scores_map, region_id == 0)$score,
               style = "font-size: 250%;"),
        icon = icon("tint"),
        color = "teal",
        fill = TRUE,
        width = 3
      )),
  
  fluidRow(box(
    h3("coastal waters which are free of contaminants"),
    width = 12
    )),
  
  ## Key Messages
  fluidRow(box(
    h4("Key Messages"),
      "- Message 1",
    br(),
      "- Message 2",
    width = 12)),
  
  fluidRow(
    ## scores map
    map_ui(
      id = "cw_scores_map"
    ),
    
    ## scores through time
    card_ui(
      id = "cw_scores"
    )
  ),
  
  
  ## Data layers and targets
  fluidRow(box(
    h4("Data Layers"),
    tags$ul(
      tags$li(
        tags$b("Pathogens"),
        ": Number of beach day closures as recorded by the EPA Beach Closure Data"
      ),
      tags$li(
        tags$b("Trash"),
        ": Pounds of trash collected per person at the Ocean Conservancy’s International coastal cleanup day data"
      ),
      tags$li(
        tags$b("Water quality"),
        ": EPA's National Coastal Condition Assessment Water Quality Index status classifications"
      ),
      tags$li(
        tags$b("Sediment quality"),
        ": EPA's National Coastal Condition Assessment Sediment Quality Index status classifications"
      )
    )
  ),
  box(
    h4("Data Targets"),
    tags$ul(
      tags$li(
        tags$b("Pathogens"),
        ": 100 days free of any beach closures, representing the average length of the swimming season for the region"
      ),
      tags$li(
        tags$b("Trash"),
        ": Zero pounds of trash collected on all beaches on International Coastal Cleanup Day"
      ),
      tags$li(
        tags$b("Water quality"),
        ": All monitoring sites classified as in “Good” water quality condition"
      ),
      tags$li(
        tags$b("Sediment quality"),
        ": All monitoring sites classified as in “Good” sediment quality condition"
      )
    )
  )), 

  fluidRow(
    ## CW layers ##
    card_ui(
      id = "cw_layers",
      title_text = "Layers used in Clean Waters Goal",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = c(
        "Connecticut",
        "Maine",
        "Massachusetts-Gulf of Maine",
        "Massachusetts-Virginian",
        "New Hampshire",
        "New York",
        "Rhode Island"
      ),
      selected = "Connecticut",
      select_label = "Select region",
      source_text = "Source: multiple (fill this in)",
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(title = "CODE",
                       url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/cw#ocean-health-index---us-northeast-clean-waters-goal", 
                       box_width = 6),
    
    text_links_default(title = "ACCESS LAYER DATA",
                       url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/cw/data", 
                       box_width = 6)
  ),
  
  fluidRow(box(h4("Data Gaps"),
               tags$ul(
                 tags$li(
                   tags$b("Trash"),
                   ": the Ocean Conservancy’s International coastal cleanup day data is the most spatially and temporally representative data available for the Northeast region, however these data are only collected once a year by volunteers and thus may not be representative of the larger patterns occurring across time and space in the region. More comprehensive and consistent monitoring of floating trash, beach trash, and microplastics would allow for a more accurate assessment of the pollution derived from trash across the region."
                 ),
                 tags$li(
                   tags$b("Temporal availability"),
                   "of US EPA's National Coastal Condition Assessment data - These data are incredibly representative spatially of the water quality across the region, however these monitoring efforts only occur every 4-5 years and thus may miss some events or trends that would be revealed by more monitoring efforts throughout each year."
                 )
               ),
               width = 12))
), 

## Food Provision --------
tabItem(
  tabName = "fp",
  
  fluidRow(box(
    h1("FOOD PROVISION"),
    width = 9
  ),
  infoBox(
    "",
    tags$p(filter(fp_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("utensils"),
    color = "red",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(box(
    h3("sustainable seafood from wild-caught fisheries and aquaculture"),
    width = 12
  )),
  
  fluidRow(
    ## scores map
    map_ui(
      id = "fp_scores_map"
    ),
    ## scores through time
    card_ui(
      id = "fp_scores"
    )
  )
),

## Fisheries ----
tabItem(
  tabName = "fis",
  
  tab_title_ui(goal_text = "FOOD PROVISION: Wild-Caught Fisheries",
               commitment_text = "sustainably harvested seafood from wild-caught fisheries"),

  fluidRow(
    ## scores map
    map_ui(
      id = "fis_scores_map"
    ),
    ## scores through time
    card_ui(
      id = "fis_scores"
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                       url = "http://ohi-science.org/goals/#food-provision"),
    
    text_links_default(title = "CATCH DATA PREP",
                       url = "https://ohi-northeast.github.io/ne-prep/prep/fis/noaa_spatial_fish_catch.html"),
    
    text_links_default(title = "STOCK STATUS DATA PREP",
                       url = "https://ohi-northeast.github.io/ne-prep/prep/fis/stock_scores.html")
  ),
  
  fluidRow(
    ## NOAA landings ##
    card_ui(
      id = "fis_noaa_catch",
      title_text = "Landings",
      sub_title_text = "Landings shown are for assessed stocks only",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(fis_noaa_catch$rgn_name),
      select_label = "Select region",
      source_text = "Source: National Ocean and Atmospheric Administration",
      box_width = 12
    )
  )
),

## Aquaculture ----
tabItem(
  tabName = "mar",
  
  tab_title_ui(goal_text = "FOOD PROVISION: Aquaculture",
               commitment_text = "sustainably produced seafood from aquaculture"),
  
  fluidRow(
    ## scores map
    map_ui(
      id = "mar_scores_map"
    ),
    ## scores through time
    card_ui(
      id = "mar_scores"
    )
  )
),

## Livelihoods & Economies -----
tabItem(
  tabName = "liveco",
  
  fluidRow(box(
    h1("LIVELIHOODS & ECONOMIES"),
    width = 9
  ),
  infoBox(
    "",
    tags$p(filter(le_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("money"),
    color = "green",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(box(
    h3("a high quantity and quality of ocean-dependent jobs and local revenue"),
    width = 12
  )),
  
  fluidRow(
    ## scores map
    map_ui(
      id = "le_scores_map"
    ),
    ## scores through time
    card_ui(
      id = "le_scores"
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                       url = "http://ohi-science.org/goals/#livelihoods-and-economies"),
    
    text_links_default(title = "JOBS DATA PREP",
                       url = "https://ohi-northeast.github.io/ne-prep/prep/liv/jobs.html"),
    
    text_links_default(title = "WAGES DATA PREP",
                       url = "https://ohi-northeast.github.io/ne-prep/prep/liv/wages.html")
  )
),

## Livelihoods ----
tabItem(
  tabName = "liv",
  
  tab_title_ui(goal_text = "Livelihoods",
               commitment_text = ""),

  fluidRow(
    ## scores map
    map_ui(
      id = "liv_scores_map"
    ),
    
    ## scores through time
    card_ui(
      id = "liv_scores"
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                       url = "http://ohi-science.org/goals/#livelihoods-and-economies"),
    
    text_links_default(title = "JOBS DATA PREP",
                       url = "https://ohi-northeast.github.io/ne-prep/prep/liv/jobs.html"),
    
    text_links_default(title = "WAGES DATA PREP",
                       url = "https://ohi-northeast.github.io/ne-prep/prep/liv/wages.html")
  ),
  
  fluidRow(
    ## Employment ##
    card_ui(
      id = "liv_emp",
      title_text = "Employment",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(jobs_scores$rgn_name),
      select_label = "Select region",
      source_text = "Source: National Ocean Economics Program"
    ),
    
    #job scores by region between 0 and 1
    card_ui(
      id = "liv_emp_scores",
      title_text = "Job scores",
      source_text = "Source: National Ocean Economics Program"
    )
  ),
  
  
  fluidRow(
    ## Wages ##
    card_ui(
      id = "liv_wages",
      title_text = "Average annual wages",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(wages_scores$rgn_name),
      select_label = "Select region",
      source_text = "Source: National Ocean Economics Program"
    ),
    
    
    #wage scores by region between 0 and 1
    card_ui(
      id = "liv_wage_scores",
      title_text = "Wage scores",
      sub_title_text = "A score of 1 indicates wage growth of at least 3.5% annually",
      source_text = "Source: National Ocean Economics Program"
    )
  )
),

## Economies ------
tabItem(
  tabName = "eco",
  
  tab_title_ui(goal_text = "Economies",
               commitment_text = ""),
  
  fluidRow(
    ## scores map
    map_ui(
      id = "eco_scores_map"
    ),
    
    ## scores through time
    card_ui(
      id = "eco_scores"
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(title = "HOW WE CALCULATE THIS GOAL",
                       url = "http://ohi-science.org/goals/#livelihoods-and-economies"),
    
    text_links_default(
      title = "GDP DATA PREP",
      box_width = 6,
      url = "https://ohi-northeast.github.io/ne-prep/prep/eco/gdp.html"
    )
  ),
  
  fluidRow(
    ## GDP ##
    card_ui(
      id = "eco_gdp",
      title_text = "Gross Domestic Product",
      sub_title_text = "GDP in 2012 US Dollars",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(gdp$rgn_name),
      select_label = "Select region",
      source_text = "Source: National Ocean Economics Program"
    ),
    
    #wage scores by region between 0 and 1
    card_ui(
      id = "eco_gdp_scores",
      title_text = "GDP scores",
      sub_title_text = "",
      source_text = "Source: National Ocean Economics Program"
    )
  )
),


## Tourism & Recreation -----

tabItem(
  tabName = "tr",

  fluidRow(box(
    h1("TOURISM & RECREATION"),
    width = 9
  ),
  infoBox(
    "",
    tags$p(filter(tr_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("umbrella-beach"),
    color = "yellow",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(box(
    h3("opportunities for people to enjoy coastal areas through tourism and recreation"),
    width = 12
  )),
  
  fluidRow(
    
    ## scores map
    map_ui(
      id = "tr_scores_map"
    ),
    
    ## scores through time
    card_ui(
      id = "tr_scores"
    )
  ),
  
  fluidRow(
    ## Employment ##
    card_ui(
      id = "tr_jobs",
      title_text = "Jobs in Tourism",
      sub_title_text = "",
      source_text = "Source: National Ocean Economics Program"
    ),
    
    ## Beach Closures ##
    card_ui(
      id = "tr_beach",
      title_text = "Average proportion of swim season with beach closures",
      sub_title_text = "This layer reports the average proportion of a swim season with beaches closed to recreation.",
      source_text = "Source: EPA Beacon"
    )
    
  )
),


## Biodiversity ------

tabItem(
  tabName = "bio",
  
  fluidRow(box(
    h1("BIODIVERSITY"),
    width = 9
  ),
  infoBox(
    "",
    tags$p(filter(bio_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("fish"),
    color = "blue",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(box(
    h3("a diversity of healthy marine species, habitats, and landscapes"),
    width = 12
  )),
  
  ## scores map
  map_ui(
    id = "bio_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "bio_scores"
  ),
  
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "HOW WE CALCULATE THIS GOAL",
      url   = "http://ohi-science.org/goals/#biodiversity",
      box_width = 12
    )
  ),
  fluidRow(
    ## Species sub-goal scores##
    card_ui(
      id = "bio_spp_scores",
      title_text = "Species sub-goal scores",
      sub_title_text = ""
    ),
    
    ## Habitat sub-goal scores##
    card_ui(
      id = "bio_hab_scores",
      title_text = "Habitat sub-goal scores",
      sub_title_text = ""
    )
  )
),

## Species ----

tabItem(
  tabName = "spp",
  
  tab_title_ui(goal_text = "BIODIVERSITY: Species",
               commitment_text = "a diversity of healthy marine species, habitats, and landscapes"),
  
  ## scores map
  map_ui(
    id = "spp_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "spp_scores"
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "HOW WE CALCULATE THIS GOAL",
      url   = "http://ohi-science.org/goals/#biodiversity",
      box_width = 6
    ),
    
    text_links_default(
      title = "DATA PREP",
      url   = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/spp#species-status",
      box_width = 6
    )
  )
),


## Habitats------

tabItem(
  tabName = "hab",
  
  tab_title_ui(goal_text = "BIODIVERSITY: Habitats",
               commitment_text = "a diversity of healthy marine species, habitats, and landscapes"),
  
  ## scores map
  map_ui(
    id = "hab_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "hab_scores"
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "HOW WE CALCULATE THIS GOAL",
      url   = "http://ohi-science.org/goals/#biodiversity",
      box_width = 6
    ),
    
    text_links_default(
      title = "DATA PREP",
      url   = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/spp#species-status",
      box_width = 6
    )
  ),
  
  fluidRow(
    ## Raw habitat data ##
    card_ui(
      id = "hab_raw_data",
      title_text = "Habitat data",
      sub_title_text = "",
      select_type = "radio",
      select_location = "above",
      select_choices = list(
        "Eelgrass" = "eelgrass",
        "Salt Marsh" = "salt_marsh",
        "Offshore habitats" = "offshore"
      ),
      source_text = "Source: "
    ),
    
    
    ## Habitat layer scores b/w 0 and 100 ##
    card_ui(
      id = "hab_layer_scores",
      title_text = "Habitat layer scores between 0 and 100",
      sub_title_text = "",
      select_type = "radio",
      select_location = "above",
      select_choices = list(
        "Eelgrass" = "eelgrass",
        "Salt Marsh" = "salt_marsh",
        "Offshore habitats" = "offshore"
      ),
      source_text = ""
    )
  )
),

## Sense of Place ------

tabItem(
  tabName = "sop",
  
  fluidRow(box(
    h1("SENSE OF PLACE"),
    width = 9
  ),
  infoBox(
    "",
    tags$p(filter(sop_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("home"),
    color = "aqua",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(box(
    h3("a deep sense of identity and belonging provided through connections with our marine communities"),
    width = 12
  )),
  
  ## scores map
  map_ui(
    id = "sop_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "sop_scores"
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "HOW WE CALCULATE THIS GOAL",
      url   = "http://ohi-science.org/goals/#sense-of-place",
      box_width = 12
    )
  ),
  
  fluidRow(
    #lasting special places scores
    card_ui(
      id = "sop_lsp_scores",
      title_text = "Lasting Special Places subgoal",
      sub_title_text = "Explore scores for each region over time"
    ),
    
    card_ui(
      id = "sop_ico_scores",
      title_text = "Iconic Species subgoal",
      sub_title_text = ""
    )
  )
),

## Lasting Special Places -----

tabItem(
  tabName = "lsp",

  tab_title_ui(goal_text = "SENSE OF PLACE: Lasting Special Places",
               commitment_text = ""),
  
  ## scores map
  map_ui(
    id = "lsp_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "lsp_scores"
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "HOW WE CALCULATE THIS GOAL",
      url   = "http://ohi-science.org/goals/#sense-of-place",
      box_width = 6
    ),
    
    text_links_default(
      title = "DATA PREP",
      url   = "https://ohi-northeast.github.io/ne-prep/prep/sop/lsp/lsp.html",
      box_width = 6
    )
  ),
  
  fluidRow(
    ## Protected marine areas ##
    card_ui(
      id = "lsp_marine",
      title_text = "Proportion of area protected within state waters",
      sub_title_text = "",
      source_text = "Source: "
    ),
    
    ## Protected land in coastal 1km ##
    card_ui(
      id = "lsp_land",
      title_text = "Proportion of area protected on land within 1km of the coastline",
      sub_title_text = "",
      source_text = ""
    )
  )
),

## Iconic Species------

tabItem(
  tabName = "ico",
  
  tab_title_ui(goal_text = "SENSE OF PLACE: Iconic Species",
               commitment_text = ""),
  
  ## scores map
  map_ui(
    id = "ico_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "ico_scores"
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "HOW WE CALCULATE THIS GOAL",
      url   = "http://ohi-science.org/goals/#sense-of-place",
      box_width = 6
    ),
    
    text_links_default(
      title = "DATA PREP",
      url   = "https://ohi-northeast.github.io/ne-prep/prep/sop/ico/iconic_species.html",
      box_width = 6
    )
  ),
  
  fluidRow(
    ## Protected marine areas ##
    card_ui(
      id = "ico_species_scores",
      title_text = "Species status by region",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(ico_species_scores$rgn_name),
      select_label = "Select region",
      source_text = "Source: NatureServe and IUCN",
      box_width = 12
    )
  )
  
),

## Resource Access Opportunities------

tabItem(
  tabName = "rao",
  
  fluidRow(box(
    h1("RESOURCE ACCESS OPPORTUNITIES"),
    width = 9
  ),
  infoBox(
    "",
    tags$p(filter(rao_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("ship"),
    color = "orange",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(box(
    h3("access..."),
    width = 12
  )),
  
  fluidRow(
    ## scores map
    map_ui(
      id = "rao_scores_map"
    ),
    
    ## scores through time
    card_ui(
      id = "rao_scores"
    )
  )
  
  # fluidRow(
  #   ## Economic access ##
  #   card_ui(id = "rao_econ",
  #           title_text = "Economic Access (gas to wage ratio)",
  #           sub_title_text = "",
  #           source_text = ""),
  #
  #   ## FSSI ##
  #   card_ui(id = "rao_fssi",
  #           title_text = "Fish stock sustainability index (FSSI)",
  #           sub_title_text = "",
  #           source_text = "Source: NOAA FSSI")
  #   )
),



## Habitat Services-------

tabItem(
  tabName = "hs",
  
  fluidRow(box(
    h1("HABITAT SERVICES"),
    width = 9
  ),
  infoBox(
    "",
    tags$p(filter(hs_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("pagelines"),
    color = "purple",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(box(
    h3("storage of carbon and protection of our coasts from storm damage by living natural habitats"),
    width = 12
  )),
  
  ## scores maps
  map_ui(
    id = "hs_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "hs_scores"
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "HOW WE CALCULATE THIS GOAL",
      url   = "http://ohi-science.org/goals/#biodiversity",
      box_width = 6
    ),
    
    text_links_default(
      title = "DATA PREP",
      url   = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/spp#species-status",
      box_width = 6
    )
  ),
  
  
  fluidRow(
    ## Coastal Protection ##
    card_ui(
      id = "coastal_protection",
      title_text = "Coastal Protection scores",
      sub_title_text = "",
      source_text = "Source: "
    ),
    
    
    ## Carbon Storage ##
    card_ui(
      id = "carbon_storage",
      title_text = "Carbon Storage scores",
      sub_title_text = "",
      source_text = "Source: "
    )
  )
),

## Pressures------

tabItem(
  tabName = "pressures",
  
  ## Pressures tab title ##
  tab_title_ui(goal_text = "Pressures",
               commitment_text = "pressures"),
  
  ##map for trash layer ##
  map_ui(id = "trash_map",
         title_text = "Trash pressure layer")
)
  )
  )
)

