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
        "Index Scores",
        tabName = "index"
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
      menuItem("Habitat Services", tabName = "hs")#,
      #menuItem("Pressures", tabName = "pressures")
    ),
    width = 250,
    
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
            "The Ocean Health Index measures what people value about oceans and provides a holistic picture on how to manage ocean benefits sustainably for future generations. Ocean Health Index assessments use the best-available data to measure progress toward target conditions for benefits provided by a region's marine ecosystems, resulting in benefit-specific and overall health scores on a scale of 0 to 100.", 
            br(),
            h4(
              a("Dive Deeper", href = "#shiny-tab-index", "data-toggle" = "tab")),
            width = 12
          )
        ),
        
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
              color = "orange",
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
              color = "aqua",
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
          box(
            h3("About the Assessment"),
            "The goal of this assessment is to serve regional ocean planning by providing a big picture perspective on ocean health based on data and priorities specific to the Northeast. The assessment was led by a team of scientists from the Ocean Health Index program at the National Center for Ecological Analysis and Synthesis (NCEAS). This team worked with the Northeast Regional Ocean Council (NROC) Ocean PLanning Committee to get stakeholder input from federal, state, and local governmnetal organizations, NGO's, and community members. More information can be found at ",
            a(href = "http://www.ohi-northeast.org/", "ohi-northeast.org", "."),
            br(),
            h3("Access Code & Data"),
            "All code and data is made available on ",
            a(href = "https://github.com/OHI-Northeast/ne-prep", "GitHub"),
            width = 12
          )
        )
      ),
      
            
## Overall index scores------
tabItem(tabName = "index",
        
        fluidRow(box(
          h1("Index Scores"),
          "The Northeast Ocean Health Index uses social, economic, and environmental data to create a comprehensive picture of the state of ocean health from Maine to New York. Below you can explore the results of the assessment across the 11 reporting regions and 13 years of data (2005 - 2017) included in this assessment.",
          width = 12
        )),
        
        fluidRow(
          ## scores map
          map_ui(
            id = "indx_scores_map",
            sub_title_text = "Overall OHI Scores for all regions from the most recently assessed year (2017). Click on a region to see the score. Areas with no color indicate regions that were not evaluated"
          ),
          
          box(h4("Goal Scores for 2017"),
              "Ocean Health Index scores are calculated for individual goals separately and then combined to get an overall score on a scale of 0-100. Individual goal scores are represented by the length of the petals in a flower plot below, and the overall 2017 Index score for the entire Northeast is in the center. You can dig into the data and scores for each individual goal by clicking on the goal titles in the main menu at the left of your screen.",
              
          uiOutput("flowerplot")
        )
        ),
        
        fluidRow(
          ## scores through time
          card_ui(
            id             = "indx_scores",
            box_width      = 12,
            title_text     = "OHI Region Scores over time"
          )
        )), 

## Clean Waters ---------

tabItem(
  tabName = "cw",
  
  fluidRow(
    box(h1("CLEAN WATERS"),
        width = 9),
    infoBox(
      "",
      tags$p(filter(cw_scores_map, region_id == 0)$score,
             style = "font-size: 250%;"),
      icon = icon("tint"),
      color = "teal",
      fill = TRUE,
      width = 3
    )
  ),
  
  fluidRow(
    box(
      h3("TARGET:"),
        h4(tags$em("Zero water pollution from pathogens and trash, and sediment and water quality levels  meet EPA threshold values")
      ), width = 12)),
 
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )
  ),
  
  fluidRow(## scores map
    map_ui(id = "cw_scores_map"),
    
    ## scores through time
    card_ui(id = "cw_scores")),
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("cw_datatable"),
    width = 12
    )),
  
  fluidRow(
    ## CW layers ##
    card_ui(
      id = "cw_layers",
      title_text = "Data Layers",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(cw_scores$rgn_name),
      selected = "Connecticut",
      select_label = "Select region",
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/cw#ocean-health-index---us-northeast-clean-waters-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/cw/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Gaps"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
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
      width = 12
    )
  )
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
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("maximize the amount of sustainable seafood produced from wild-caught fisheries and aquaculture")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )
  ),
  
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
  
  fluidRow(box(
    h1("WILD-CAUGHT FISHERIES"),
    width = 9
  ),
  
  infoBox(
    "",
    tags$p(filter(fis_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("utensils"),
    color = "red",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("all wild-caught fisheries have a B/Bmsy near 1")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )
  ),

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
      sub_title_text = "Double click on a species in the legend to highlight just that line. Hover over the lines to see individual scores.",
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
  
  fluidRow(box(
    h1("AQUACULTURE"),
    width = 9
  ),
  
  infoBox(
    "",
    tags$p(filter(mar_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("utensils"),
    color = "red",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("all farmed seafood is sustainable")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )
  ),
  
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
  
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("All coastal dependent livelihoods and economies are growing through time")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )
  ),
  
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("le_datatable"),
    width = 12
  )),
  
  fluidRow(
    box(
      h4("Data Gaps"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Jobs"),
          ": the data we have does not reveal information about transitioning between sectors or seasonal employment."
        )
      ), width = 12
    )
  )
), 

## Livelihoods ----
tabItem(
  tabName = "liv",
  
  fluidRow(box(
    h1("LIVELIHOODS"),
    width = 9
  ),
  
  infoBox(
    "",
    tags$p(filter(liv_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("money"),
    color = "green",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("Annual growth for ocean-dependent jobs meets or exceeds national growth & wages grow by 3.5% annually")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )),

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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("liv_datatable"),
    width = 12
  )),
  
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
    )
  ),

  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/liv#ocean-health-index---us-northeast-livelihoods-sub-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/liv/data",
      box_width = 6
    )
  )
),

## Economies ------
tabItem(
  tabName = "eco",
  
  fluidRow(box(
    h1("ECONOMIES"),
    width = 9
  ),
  
  infoBox(
    "",
    tags$p(filter(eco_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("money"),
    color = "green",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("Annual growth in ocean related sectors’ Gross Domestic Product is at least 3%")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )),
  
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("eco_datatable"),
    width = 12
  )),
  
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
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/4e23384d1a5cbae09e97d34b87620f7e11e47c05/prep/eco#ocean-health-index---us-northeast-economies-sub-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/eco/data",
      box_width = 6
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
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("Jobs in coastal tourism sectors are growing (reflecting overall growth in tourism participation) and coastal recreation is not inhibited by beach closures")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("tr_datatable"),
    width = 12
  )),
  
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
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("No marine species are at risk of extinction and all habitats that support biodiversity are in good condition")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("bio_datatable"),
    width = 12
  )),
  
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
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio#ocean-health-index---us-northeast-biodiversity-goal",
      box_width = 12
    )
  )
),

## Species ----

tabItem(
  tabName = "spp",
  
  fluidRow(box(
    h1("SPECIES"),
    width = 9
  ),
  
  infoBox(
    "",
    tags$p(filter(spp_scores_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("fish"),
    color = "blue",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("All species identified as present in the region are not at risk of extinction and are classified as of Least Concern by IUCN criteria")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )),
  
  ## scores map
  map_ui(
    id = "spp_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "spp_scores"
  ),
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("spp_datatable"),
    width = 12
  )),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/spp",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/spp/data",
      box_width = 6
    )
  )
),


## Habitats------

tabItem(
  tabName = "hab",
  
  fluidRow(box(
    h1("HABITATS"),
    width = 12
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("No loss of salt marsh habitats from historical estimates, all eelgrass habitats have good water quality condition, and all seabed habitats are undisturbed from fishing activity")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )),
  
  ## scores map
  map_ui(
    id = "hab_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "hab_scores"
  ),
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("hab_datatable"),
    width = 12
  )),
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
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/hab",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/hab/data",
      box_width = 6
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
    color = "orange",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("Areas of importance are protected as lasting special places and iconic species are not threatened")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )),
  
  fluidRow(
  ## scores map
  map_ui(
    id = "sop_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "sop_scores"
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

  fluidRow(box(
    h1("LASTING SPECIAL PLACES"),
    width = 12
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("At least 30% of coastal waters are protected")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )),
  
  fluidRow(
  ## scores map
  map_ui(
    id = "lsp_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "lsp_scores"
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
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/lsp",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/lsp/data",
      box_width = 6
    )
  )
),

## Iconic Species------

tabItem(
  tabName = "ico",
  
  fluidRow(box(
    h1("ICONIC SPECIES"),
    width = 12
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("All iconic species have a conservation status of Least Concern")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
      width = 12
    )),
  
  ## scores map
  map_ui(
    id = "ico_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "ico_scores"
  ),
  
  #iconic species heatmap
  fluidRow(
    box(
      plotOutput("ico_heatmap"),
      width = 12)
  ),

  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/ico",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/ico/data",
      box_width = 6
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
    color = "aqua",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
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
  
  fluidRow(
    box(
      h3("TARGET:"),
      h4(tags$em("All biogenic habitats that support carbon storage and coastal protection are in good condition")
      ), width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Message 1: These will be brief summaries of results or patterns identified for this goal",
      br(),
      "- Message 2:",
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("hs_datatable"),
    width = 12
  )),
  
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
  tabName = "pressures"

)
  )
  )
)

