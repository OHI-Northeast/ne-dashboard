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
          startExpanded = TRUE,
          menuSubItem("Wild-Caught Fisheries", tabName = "fis"),
          menuSubItem("Aquaculture", tabName = "mar")
        ),
        tabName = "fp"
      ),
      convertMenuItem(
        menuItem(
          "Livelihoods & Economies",
          tabName = "liveco",
          startExpanded = TRUE,
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
          startExpanded = TRUE,
          menuSubItem("Species", tabName = "spp"),
          menuSubItem("Habitats", tabName = "hab")
        ),
        tabName = "bio"
      ),
      convertMenuItem(
        menuItem(
          "Sense of Place",
          tabName = "sop",
          startExpanded = TRUE,
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
      h4("TARGET:", tags$em("Zero water pollution from pathogens and trash in coastal waters, and sediment and water quality levels meet EPA threshold values")),
      width = 12)),
 
  fluidRow(
    box(
      # Key Messages
      "- This goal is only measured for coastal regions because the majority of people are in direct contact with the coastal ocean",
      br(),
      "- Clean water scores do not vary much from year to year but there is a downward trend over time",
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
      select_choices = unique(cw_layers$rgn_name),
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
      h4("Data Considerations & Potential Improvements"),
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
      h4("TARGET: ",tags$em("maximize the amount of sustainable seafood produced from wild-caught fisheries and aquaculture")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Food provision includes both wild-caught fisheries and aquaculture. The final score is weighted by total production by each of sector",
      br(),
      "- This measures both the total amount of seafood produced and it's sustainability",
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
      h4("TARGET:", tags$em("all stocks are fished at maximum sustainable yield")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Bait fisheries, such as Atlantic herring & mackerel, are important in the Northeast. Only harvest meant for direct human consumption from these fisheries is included in the score.",
      br(),
      "- These scores reflect the status of fish where they are caught, not the port where they are landed.",
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("fis_datatable"),
    width = 12
  )),
  
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
      box_width = 12
    )
  ),
  
  fluidRow(
    ## stock assessment data ##
    card_ui(
      id = "fis_stock_ass",
      title_text = "Stock assessment data",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(fis_stock_assessment$stock),
      select_label = "Select stock",
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/fis#ocean-health-index---us-northeast-wild-caught-fisheries",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/fis/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Stock assessments"),
          ""
        ),
        tags$li(
          tags$b("State catch data"),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("sustainably farmed seafood production is growing by 4% annually")),
     width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Scores for this goal are largely driven by reporting formats and standards which vary significantly across each state.",
      br(),
      "- Kelp or seaweed farming is a new but growing sector of the aquaculture industry in the northeast. It has not reached commercial scale and therefore is not included in these scores.",
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
  ),
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("mar_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Production data ##
    card_ui(
      id = "mar_production",
      title_text = "Aquaculture species production",
      sub_title_text = "Double click on a species in the legend to highlight just that line. Hover over the lines to see individual scores.",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(mar_production$Region),
      select_label = "Select region"
    ),
    ## Species sustainability table
    box(
      DT::dataTableOutput("mar_spp_sust_table")
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/mar#ocean-health-index---us-northeast-mariculture-sub-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/mar/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Production data - Maine stopped reporting salmon in 2010"),
          ""
        ),
        tags$li(
          tags$b("Sustainability data"),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("All coastal dependent livelihoods and economies are growing through time")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Coastal livelihoods and economies have been increasing over time.",
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
      h4("Data Considerations & Potential Improvements"),
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
      h4("TARGET:", tags$em("Annual growth for ocean-dependent jobs meets or exceeds national growth & wages grow by 3.5% annually")),
      width = 12)),

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
      select_label = "Select region"
    ),
    
    ## Wages ##
    card_ui(
      id = "liv_wages",
      title_text = "Average annual wages",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(wages_scores$rgn_name),
      select_label = "Select region"
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
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Seasonal data"),
          ""
        ),
        tags$li(
          tags$b("Sector switching"),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("Annual growth in ocean related sectors’ Gross Domestic Product is at least 3%")),
      width = 12)),
  
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
      select_label = "Select region"
    ),
    
    #wage scores by region between 0 and 1
    card_ui(
      id = "eco_gdp_scores",
      title_text = "GDP scores",
      sub_title_text = ""
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
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b(""),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("Jobs in coastal tourism sectors are growing (reflecting overall growth in tourism participation), coastal recreation is not inhibited by beach closures and each mile of coastline has a public access point")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Each data layer measures different aspects of tourism and recreation. The number of jobs in the tourism sector is used as a proxy for tourism growth while beach closures and lack of coastal access measure the publics ability to recreate on the coast.",
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
      sub_title_text = ""
    ),
    
    ## Beach Closures ##
    card_ui(
      id = "tr_beach",
      title_text = "Beach Closures",
      sub_title_text = "This layer reports the average proportion of a swim season with beaches closed to recreation."
    )),
    
  fluidRow(
    ## Coastal access ##
    card_ui(id = "tr_coastal",
            title_text = "Coastal Access",
            sub_title_text = "Proportion of publically accessible coastline")
    
  ),
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/tr#ocean-health-index---us-northeast-tourism--recreation",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/tr/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b(""),
          ""
        ),
        tags$li(
          tags$b(""),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("No marine species are at risk of extinction and all habitats that support biodiversity are in good condition")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Biodiversity tries to measure the conservation status of all ocean-dependent species in the Northeast. Since not all species have been assessed, habitat health is also included as an indicator for species that rely on these habitats.",
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
      h4("TARGET:", tags$em("All species identified as present in the region are not at risk of extinction and are classified as of Least Concern by IUCN criteria")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "This sub-goal assesses the health of all marine species present in a region, including endangered species and species in relatively good conditions. The presence of higher-risk species leads to a lower score. There are 732 species included in the biodiversity-species score.",
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
  
  ## Species by region and status ##
  fluidRow(
  card_ui(
    id = "spp_rgn_count",
    title_text = "Species by region and status",
    sub_title_text = "Species status scores range from 0 (Extinct) to 1 (Least Concern)",
    box_width = 12
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
  ),

  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Species range maps"),
          ""
        ),
        tags$li(
          tags$b("Change in status over time"),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("No loss of salt marsh habitats from historical estimates, all eelgrass habitats have good water quality condition, and all seabed habitats are undisturbed from fishing activity")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- This score measures the health of three regional marine habitats that support biodiversity; salt marsh, eelgrass, and seabed habitats.",
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

  fluidRow(
    ## Raw habitat data ##
    card_ui(
      id = "hab_raw_data",
      title_text = "Habitat data",
      sub_title_text = "Eelgrass layer is respresented by a proxy dataset that looks at water quality at sites located within a current or previous eelgrass bed. Salt Marsh layer indicates loss in habitat extent compared to a historic reference point. The seabed habitats layer measures impact to habitats from fishing.",
      select_type = "radio",
      select_location = "above",
      select_choices = list(
        "Eelgrass (water quality index proxy)" = "eelgrass",
        "Salt Marsh (% loss)" = "salt_marsh",
        "Seabed habitats (fishing impacts; 0 = lowest, 1 = highest)" = "offshore"
      )
    ),
    
    
    ## Habitat layer scores b/w 0 and 100 ##
    card_ui(
      id = "hab_layer_scores",
      title_text = "Habitat layer scores",
      sub_title_text = "Data layers are translated into 0-100 scores for 2005-2017",
      select_type = "radio",
      select_location = "above",
      select_choices = list(
        "Eelgrass" = "eelgrass",
        "Salt Marsh" = "salt_marsh",
        "Seabed habitats" = "offshore"
      )
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/hab#ocean-health-index---us-northeast-habitats-sub-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/hab/data",
      box_width = 6
    )
  ),

  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Historical habitat data"),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("Areas of importance are protected as lasting special places and iconic species are not threatened")),
     width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "Sense of Places captures the aspects of the coastal and marine system that people value as part of their cultural identity.",
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
    width = 9
  ),
  
  infoBox(
    "",
    tags$p(filter(lsp_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("home"),
    color = "orange",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h4("TARGET:", tags$em("At least 10% of coastal waters are protected and 17% of land within 1km of the coast is protected")),
     width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Lasting Special Places includes geographic locations that hold particular value for aesthetic, spiritual, cultural, recreational or existence reasons, and assesses how well they are protected. Due to data limitations, these unique aspects can not be discretely measured. Therefore it is assumed that all coastal areas within 1 kilometer of the coast on land, and 3 nautical miles offshore, are special and total area protected is used to measure Lasting Special Places.",
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("lsp_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Protected marine areas ##
    card_ui(
      id = "lsp_marine",
      title_text = "Proportion of area protected within state waters",
      sub_title_text = ""
    ),
    
    ## Protected land in coastal 1km ##
    card_ui(
      id = "lsp_land",
      title_text = "Proportion of area protected on land within 1km of the coastline",
      sub_title_text = ""
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/lsp#ocean-health-index---us-northeast-lasting-special-places-sub-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/lsp/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Survey of special places and their protection"),
          ""
        )
      ),
      width = 12
    )
  )
  
),

## Iconic Species------

tabItem(
  tabName = "ico",
  
  fluidRow(box(
    h1("ICONIC SPECIES"),
    width = 9
  ),
  
  infoBox(
    "",
    tags$p(filter(ico_map, region_id == 0)$score,
           style = "font-size: 250%;"),
    icon = icon("home"),
    color = "orange",
    fill = TRUE,
    width = 3
  )),
  
  fluidRow(
    box(
      h4("TARGET:", tags$em("All iconic species have a conservation status of Least Concern")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "Iconic species are those that are relevant to local cultural identity through a species’ relationship to one or more of the following: 1) traditional activities such as fishing, hunting or commerce; 2) local ethnic or religious practices; 3) existence value; and 4) locally-recognized aesthetic value",
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
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("ico_datatable"),
    width = 12
  )),
  
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
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/ico#ocean-health-index---us-northeast-iconic-species-sub-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/ico/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("List of species"),
          ""
        )
      ),
      width = 12
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
      h4("TARGET:", tags$em("The average gas to wage ratio does not increase over time, each mile of coastline has a public access point, and all fish stocks are sustainably managed")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Access to coastal and ocean resources is inherently difficult to measure, but is an important aspect of Ocean Health and is therefore included in the Index. The data used here is a best attempt to measure the ability for people to access the resources they desire.",
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
  ),
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("rao_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Economic access ##
    card_ui(id = "rao_econ",
            title_text = "Economic Access",
            sub_title_text = "Ratio of gas ($/barrel) to wages"),

   
    ## Coastal access ##
    card_ui(id = "rao_coastal",
            title_text = "Coastal Access",
            sub_title_text = "Proportion of publically accessible coastline")
    ),
  
  fluidRow(
    ## FSSI ##
  
    card_ui(id = "rao_avg_fssi",
            title_text = "Average Fish stock sustainability index (FSSI)",
            sub_title_text = "",
            box_width = 12)
  ),
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/rao",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/rao/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Better indicators of access"),
          ""
        )
      ),
      width = 12
    )
  )
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
      h4("TARGET:", tags$em("All biogenic habitats that support carbon storage and coastal protection are in good condition")),
      width = 12)),
  
  fluidRow(
    box(
      # Key Messages
      "- Habitat Services measures two equally important components: Coastal Protection and Carbon Storage. Coastal Protection assess the amount of protection provided by marine and coastal habitats against flooding and erosion to coastal areas. Carbon storage is the ability of the coastal habitats to remove carbon given their carbon uptake rate and health conditions. ",
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

  fluidRow(
    ## Coastal Protection ##
    card_ui(
      id = "coastal_protection",
      title_text = "Coastal Protection",
      sub_title_text = "The Coastal Protection sub-goal measures the health of habitats that contribute to coastal protection from storm surge, flooding and sea level rise. In the Northeast, this includes Salt Marsh and Eelgrass habitats. We use data on habitat health and extent in the same manner as Biodiversity: Habitat sub-goal. Since these habitats vary in their ability to protect against coastal storm surge so we apply a weighting scheme where salt marsh is four times more protective than eelgrass."
    ),
    
    
    ## Carbon Storage ##
    card_ui(
      id = "carbon_storage",
      title_text = "Carbon Storage",
      sub_title_text = "The Carbon Storage sub-goal measures the health of carbon storing marine habitats. In the Northeast, this includes Salt Marsh and Eelgrass habitats. We use data on habitat health and extent in the same manner as Biodiversity: Habitat sub-goal. Both of these habitats are able to capture carbon at a near equal rate, so we don’t include carbon storage weights. Instead we simply average the health of the habitats across each region to get a sense of how well this habitat service is doing."
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "CODE",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/hs#ocean-health-index---us-northeast-habitat-services-goal",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/bio/hab/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Historical habitat data"),
          ""
        )
      ),
      width = 12
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

