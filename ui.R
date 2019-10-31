source("global.R")

## Setting up the dashboard page
dashboardPage(
  dashboardHeader(title = "OHI for the US Northeast",
                  titleWidth = 300),
  
## Dashboard sidebar-----
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview",        tabName = "overview"),
      menuItem("Regional Scores", tabName = "index"),
      menuItem("Clean Waters",    tabName = "cw"),
      convertMenuItem(
        menuItem("Food Provision", tabName = "fp",
          startExpanded = TRUE,
          menuSubItem("Wild-Caught Fisheries", tabName = "fis"),
          menuSubItem("Aquaculture",           tabName = "mar")
        ),
        tabName = "fp"
      ),
      convertMenuItem(
        menuItem("Livelihoods & Economies", tabName = "liveco",
          startExpanded = TRUE,
          menuSubItem("Livelihoods", tabName = "liv"),
          menuSubItem("Economies",   tabName = "eco")
        ),
        tabName = "liveco"
      ),
      menuItem("Tourism & Recreation", tabName = "tr"),
      convertMenuItem(
        menuItem("Biodiversity",  tabName = "bio",
          startExpanded = TRUE,
          menuSubItem("Species",  tabName = "spp"),
          menuSubItem("Habitats", tabName = "hab")
        ),
        tabName = "bio"
      ),
      convertMenuItem(
        menuItem("Sense of Place", tabName = "sop",
          startExpanded = TRUE,
          menuSubItem("Lasting Special Places", tabName = "lsp"),
          menuSubItem("Iconic Species",         tabName = "ico"),
          menuSubItem("Fishing Engagement",     tabName = "spfis")
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
        "Developed by ",
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
                height:110px; /* Height of the footer */
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
        tabName = "overview",
        
        fluidRow(
          box(width = 12,
            h1("Ocean Health Dashboard for the US Northeast"),
            "The Ocean Health Index measures what people value about oceans and provides a holistic picture on how to manage ocean benefits sustainably for future generations. Ocean Health Index assessments use the best-available data to measure progress toward target conditions for benefits provided by a region's marine ecosystems, resulting in benefit-specific and overall health scores on a scale of 0 to 100." 
          )
        ),
        
      fluidRow(
          box(width = 6,
              title = "Ocean Health Index score",
              "",
              status = "primary",
              div(img(src="https://raw.github.com/OHI-Northeast/ne-scores/master/region/reports/figures/trimmed_flower_USNortheast.png", 
                  width=400), style = "text-align: center;"),
              br(),
              (a("Click here to dive deeper into regional scores", href = "#shiny-tab-index", "data-toggle" = "tab"))
            ),
 
        # infoBoxes with goal scores for Northeast region
        fluidRow(
          tags$div(
            href = "#shiny-tab-hs",
            "data-toggle" = "tab",
            valueBox(
              tags$p(filter(hs_scores_map, region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Habitat Services",
              icon = icon("pagelines"),
              color = "maroon",
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-tr",
            "data-toggle" = "tab",
           valueBox(
              tags$p(filter(tr_scores_map,
                            region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Tourism & Recreation",
              icon = icon("umbrella-beach"),
              color = "red",
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-rao",
            "data-toggle" = "tab",
            valueBox(
              tags$p(filter(rao_scores_map, region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Resource Access Opportunities",
              icon = icon("ship"),
              color = "fuchsia",
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-liveco",
            "data-toggle" = "tab",
            valueBox(
              tags$p(filter(le_scores_map,
                            region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Livelihoods & Economies",
              icon = icon("money"),
              color = "orange",
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-fp",
            "data-toggle" = "tab",
            valueBox(
              tags$p(filter(fp_scores_map,
                            region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Food Provision",
              icon = icon("utensils"),
              color = "purple",
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-sop",
            "data-toggle" = "tab",
            valueBox(
              tags$p(filter(sop_map, region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Sense of Place",
              icon = icon("home"),
              color = "green",
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-bio",
            "data-toggle" = "tab",
            valueBox(
              tags$p(filter(bio_scores_map, region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Biodiversity",
              icon = icon("fish"),
              color = "light-blue",
              width = 3
            )
          ),
          tags$div(
            href = "#shiny-tab-cw",
            "data-toggle" = "tab",
            valueBox(
              tags$p(filter(cw_scores_map, region_id == 0)$score,
                     style = "font-size: 100%;"),
              "Clean Waters",
              icon = icon("tint"),
              color = "teal",
              width = 3
            )
          )
        )
      ),
        
        fluidRow(
          box(
            h3("About the Assessment"),
            "The goal of this assessment is to serve regional ocean planning by providing a big picture perspective on ocean health based on data and priorities specific to the Northeast. The assessment was led by a team of scientists from the Ocean Health Index program at the National Center for Ecological Analysis and Synthesis (NCEAS). This team worked with the Northeast Regional Ocean Council (NROC) Ocean Planning Committee to get stakeholder input from federal, state, and local governmnetal organizations, NGO's, and community members. More information can be found at ",
            a(href = "http://www.ohi-northeast.org/", target="_blank", "ohi-northeast.org", "."),
            br(),
            br(),
            "All code and data used in the assessment is made available on ",
            a(href = "https://github.com/OHI-Northeast/ne-prep", target="_blank", "GitHub"),
            width = 12
          )
        )
      ),
      
            
## Regional index scores------
tabItem(tabName = "index",
        
        fluidRow(box(
          h1("Regional Scores"),
          "The Northeast Ocean Health Index uses social, economic, and environmental data to create a comprehensive picture of the state of ocean health from Maine to New York. Below you can explore the results of the assessment across the 11 reporting regions and 13 years of data (2005 - 2017) included in this assessment.",
          br(),
          br(),
          h4("Region boundaries"),
          "The assessment contains 11 regions including state waters out to three nautical miles, and four offshore regions out to the US Exclusive Economic Zone (EEZ). The Gulf of Maine, Georges Bank and Mid-Atlantic Bight regions represent the ", 
          (a("Ecological Production Units", 
         href = "https://www.nefsc.noaa.gov/program_review/2016a-review/background2016/6Ecosys%20D&PNew%20folder/Gamble/Gamble%20Ecological%20Production%20UnitsFin%20temp.pdf", target="_blank")),
           " used by the Northeast Fisheries Science Center. The fourth Offshore region represents the remainder of the EEZ. All state waters are included as they are delineated, except for Massachusetts. A natural biogegraphic boundary separating the Gulf of Maine and Mid-Atlantic Bight marine ecoregions occurs at the southern end of Cape Cod and splits Massachusetts state waters into North and South.",
          width = 12
        )),
        
        fluidRow(
          ## scores map
          map_ui(
            id = "indx_scores_map",
            sub_title_text = "Overall OHI Scores for all regions from the most recently assessed year (2017). Click on a region to see the score. Areas with no color indicate regions that were not evaluated"
          ),
          
          box(h4("Goal Scores for 2017"),
              "Ocean Health Index scores are calculated for individual goals separately and then combined to get an overall score on a scale of 0-100. Individual goal scores are represented by the length of the petals in a flower plot below, and the overall 2017 Index score for the region is in the center. You can dig into the data and scores for each individual goal by clicking on the goal titles in the main menu at the left of your screen.",
              br(),
          
        selectInput("img_region", "",
          c("Northeast" = "USNortheast",
            "Offshore"  = "Offshore",
            "Rhode Island" = "RhodeIsland",
            "New York" = "NewYork",
            "New Hampshire" = "NewHampshire",
            "Mid-Atlantic Bight" = "Mid-AtlanticBight",
            "Massachusetts-South" = "Massachusetts-South",
            "Massachusetts-North" = "Massachusetts-North",
            "Maine" = "Maine",
            "Gulf of Maine" = "GulfofMaine",
            "George's Bank" = "GeorgesBank",
            "Connecticut" = "Connecticut")),
        
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
    valueBox(
      tags$p(filter(cw_scores_map, region_id == 0)$score,
             style = "font-size: 150%;"),
      "",
      icon = icon("tint"),
      color = "teal",
      width = 3
    )
  ),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
      h3("Zero water pollution from pathogens and trash in coastal waters, and sediment and water quality levels meet EPA threshold values")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
      tags$ul(
        tags$li(
          h4(
            "The slight downward trend is largely driven by the Sediment Quality Index data layer for most regions")),
          tags$li(
            h4(
              "This goal is only measured for coastal regions because the majority of people are in direct contact with the coastal ocean")
          ))
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
      select_label = "",
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/cw_description.md#clean-waters",
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
          tags$b("Trash:"),
          " the Ocean Conservancy’s International coastal cleanup day data is the most spatially and temporally representative data available for the Northeast region, however these data are only collected once a year by volunteers and thus may not be representative of the larger patterns occurring across time and space in the region. More comprehensive and consistent monitoring of floating trash, beach trash, and microplastics would allow for a more accurate assessment of the pollution derived from trash across the region."
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
  valueBox(
    tags$p(filter(fp_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("utensils"),
    color = "purple",
    width = 3
  )),

  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("Maximize the amount of sustainable seafood produced from wild-caught fisheries and aquaculture")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Food provision includes both wild-caught fisheries and aquaculture. The final score is weighted by total production by each of sector")),
            tags$li(
              h4(
                "This measures both the total amount of seafood produced and it's sustainability")
            ))
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
  ),
  
  fluidRow(
    ## FP layers ##
    card_ui(
      id = "fp_layers",
      title_text = "Sub-goal scores",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(fp_layers$rgn_name),
      selected = "Connecticut",
      select_label = "",
      box_width = 12
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
  
  valueBox(
    tags$p(filter(fis_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("utensils"),
    color = "blue",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("All harvested stocks are neither overfished nor underfished but rather fished at maximum sustainable yield")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Bait fisheries, such as herring, skate & mackerel, are important in the Northeast. Only harvest meant for direct human consumption from these fisheries is included in the score")),
            tags$li(
              h4(
                "These scores reflect the status of fish where they are caught, not the port where they are landed")
            ))
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
      sub_title_text = "Double click on a species in the legend to highlight just that line. Hover over the lines to see individual scores. The data displayed shows a three year rolling average of catch to account for any significant fluctuations in reporting. Only stocks that contribute at least 1% of annual landings are displayed in the chart.",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(fis_noaa_catch$rgn_name),
      box_width = 12,
      source_text = "Some species have multiple stocks and their stock location are represented by acronyms. Georges Bank (GB), Georges Bank East or West (GBE/W), Cape Cod (CC), Gulf of Maine (GOM), Southern New England (SNE), Mid-Atlantic (MA), Southern Georges Bank (SGB), Northern Georges Bank (NGB)"
    )
  ),
  
  fluidRow(
    ## stock assessment data ##
    card_ui(
      id = "fis_stock_ass",
      title_text = "Stock assessment data",
      sub_title_text = "B/Bmsy is the ratio of available stock biomass in the water (B) compared to the amount of stock biomass needed to provide maximum sustainable yield (Bmsy). F/Fmsy is the ratio of fishing pressure (F) compared to that that gives the maximum sustainable yield in the long term (Fmsy). When B/Bmsy is below 1, the stock is overfished. When B/Bmsy is above 1, the stock is underfished. When F/Fmsy is below 1, the stock is experiencing underfishing, when F/Fmsy is over 1, the stock is experiencing overfishing. 
      The target for both B/Bmsy and F/Fmsy is a value of one, represented by the gray line.",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(fis_stock_assessment$stock),
      select_label = "Select stock",
      selected = "Connecticut",
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/fis_description.md#wild-caught-fisheries",
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
          tags$b("Stock assessments "),
          "came from the National Marine Fisheries Service through a data request since the data is not publically available on the NMFS website."
        ),
        tags$li(
          tags$b("State landings data"),
          " is not included. Wild-Caught fisheries scores are only accounting for catch reported by NOAA. State fisheries landings data could be included in future updates to the Index."
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
  
  valueBox(
    tags$p(filter(mar_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("utensils"),
    color = "purple",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("Sustainably farmed seafood production is growing by 4% annually")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Scores for this goal are largely driven by reporting formats and standards which vary significantly across each state")),
            tags$li(
              h4(
                "Kelp or seaweed farming is a new but growing sector of the aquaculture industry in the northeast. It has not reached commercial scale and therefore is not included in these scores")
            ),
          tags$li(
            h4(
              "There is one mussel farm located offshore but production is not yet included since it has not reached commercial scale. All other commercial farms are located within state waters"))
        )
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
      box_width = 9
    ),
    ## Species sustainability table
    box(
      DT::dataTableOutput("mar_spp_sust_table"),
      width = 3
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/mar_description.md#aquaculture",
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
          tags$b("Maine salmon production: "),
          "lacks information beyond 2010. According to Maine's Department of Marine Resources,Atlantic salmon production data from 2011 - present cannot be reported at this time due to confidentiality reasons. All Atlantic salmon production data was gapfilled for Maine using the 2010 reported numbers for all following years."
        ),
        tags$li(
          tags$b("Farmed species sustainability: "),
          "was difficult to measure due to lack of farm-specific data on what species are farmed and sustainability measures. The Monterey Bay Aquarium Seafood Watch data lacks spatial resolution but includes all farmed species in the region."
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
  valueBox(
    tags$p(filter(le_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("money"),
    color = "orange",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("All coastal dependent livelihoods and economies are growing through time")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Coastal livelihoods and economies have been increasing over time")
          )
        )
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
    ## LE layers ##
    card_ui(
      id = "le_layers",
      title_text = "Sub-goal scores",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(le_layers$rgn_name),
      selected = "Connecticut",
      select_label = "",
      box_width = 12
    )
  ),
  
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
  
  valueBox(
    tags$p(filter(liv_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("money"),
    color = "orange",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("Annual growth for ocean-dependent jobs meets or exceeds national growth & wages grow by 3.5% annually")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              ""))
         )
    )
  ),

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
      select_choices = unique(jobs_scores$rgn_name)
    ),
    
    ## Wages ##
    card_ui(
      id = "liv_wages",
      title_text = "Average annual wages",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(wages_scores$rgn_name)
    )
  ),

  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/liv_eco_description.md#livelihoods-and-economies",
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
  
  valueBox(
    tags$p(filter(eco_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("money"),
    color = "yellow",
    width = 3
  )),
  
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("Annual growth in ocean related sectors’ Gross Domestic Product is at least 3%")),
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "A target of 3% annual growth aligns with widely accepted growth targets for GDP in the United States")
              )
            )
        )
  ),
  
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
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/liv_eco_description.md#livelihoods-and-economies",
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
          tags$b("Data confidentiality policy limits the amount of data available for New Hampshire before 2009"),
          ""
        ),
        tags$li(
          tags$b("Coastal property value "),
          "could be considered an additional indicator of coastal economy health. A dataset was not readily available to be included but if suitable information becomes available in the future it could be added to Coastal Economies."
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
  valueBox(
    tags$p(filter(tr_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("umbrella-beach"),
    color = "red",
    width = 3
  )),
  
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("Jobs in coastal tourism sectors are growing (reflecting overall growth in tourism participation), coastal recreation is not inhibited by beach closures and each mile of coastline has a public access point")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Each data layer measures different aspects of tourism and recreation. The number of jobs in the tourism sector is used as a proxy for tourism growth while beach closures and lack of coastal access measure the publics ability to recreate on the coast"))
          )
    )
  ),
  
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
      sub_title_text = "Number of jobs in the tourism sector for coastal counties."
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
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/tr_description.md#tourism-and-recreation",
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
          tags$b("An ideal tourism & recreation dataset "),
          "would likely take the form of a survey that specifically targets both locals and visitors and asks their preference and attitudes towards ocean-related tourism and recreation activities. Some surveys have been done in the past, but an ideal dataset would be one that covers the entire region and is repeated consistently into the future to better track changes. For now, these layers act as proxy measures for Tourism & Recreation in the Northeast."
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
  valueBox(
    tags$p(filter(bio_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("fish"),
    color = "light-blue",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("No marine species are at risk of extinction and all habitats that support biodiversity are in good condition")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Biodiversity tries to measure the conservation status of all ocean-dependent species in the Northeast. Since not all species have been assessed, habitat health is also included as an indicator for species that rely on these habitats"))
          )
    )
  ),
  
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
    ## BIO layers ##
    card_ui(
      id = "bio_layers",
      title_text = "Sub-goal scores",
      sub_title_text = "",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(bio_layers$rgn_name),
      selected = "Connecticut",
      select_label = "",
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/bio_description.md#biodiversity",
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
  
  valueBox(
    tags$p(filter(spp_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("fish"),
    color = "light-blue",
    width = 3
  )),

  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("All species identified as present in the region are not at risk of extinction and are classified as of Least Concern by IUCN criteria")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "This sub-goal assesses the health of all marine species present in a region, including endangered species and species in relatively good conditions. The presence of higher-risk species leads to a lower score. There are 732 species included in the biodiversity-species score")
            ),
          tags$li(
            h4(
              "Scores are not weighted by the size of a species range. If a species is found in a region, it's conservation status is included in the region score.")
          )
          )
    )
  ),
  
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
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/bio_description.md#biodiversity",
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
    width = 9
  ),
  valueBox(
    tags$p(filter(spp_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("pagelines"),
    color = "aqua",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("No loss of salt marsh habitats from historical estimates, all eelgrass habitats have good water quality condition, and all seabed habitats have low levels of disturbance from fishing activity")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4("The habitat score changes are largely driven by changes in seabed habitat impacts from fishing. Salt marsh and eelgrass scores remain near constant between 2005 and 2017")
          )
          )
    )
  ),
  
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
      ),
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/bio_description.md#biodiversity",
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
      br(),
      tags$ul(
        tags$li(
          tags$b("Locations of current and past eelgrass beds"), 
          " are not consistently available across the entire Northeast region. Some places, like the Great Bay Estuary in New Hampshire, have long term monitoring efforts that provide near annual estimates of eelgrass cover. But most areas where eelgrass beds exist or existed in the past do not have consistent monitoring datasets. Therefore in order to estimate eelgrass health, we combined all known eelgrass bed locations, past and present, into a single dataset. We then selected all EPA National Coastal Condition Assessment sample sites that were within 10 km of an eelgrass bed and used the Water Quality Index status of those sites to estimate the status of the eelgrass. A great improvement to this layer would be estimates of historical loss in eelgrass cover by region and a consistent monitoring effort across the entire region to track changes and compare with past coverage."),
        tags$li(
          tags$b("There are no established region-wide targets for habitat health."),
          "The targets used for these three habitats are based on the data that is available to measure them and input from regional habitat experts."
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
  valueBox(
    tags$p(filter(sop_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("home"),
    color = "green",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("Areas of importance are protected as lasting special places, iconic species are not threatened and fishing engagement is high for coastal communities")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Sense of Places captures the aspects of the coastal and marine system that people value as part of their cultural identity"))
        )
    )
  ),
  
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
  ## SOP layers ##
  card_ui(
    id = "sop_layers",
    title_text = "Sub-goal scores",
    sub_title_text = "",
    select_type = "drop_down",
    select_location = "above",
    select_choices = unique(sop_layers$rgn_name),
    selected = "Connecticut",
    select_label = "",
    box_width = 12
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
  
  valueBox(
    tags$p(filter(lsp_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("home"),
    color = "olive",
    width = 3
  )),
  
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("At least 10% of coastal waters are protected and 17% of land within 1km of the coast is protected")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Lasting Special Places includes geographic locations that hold particular value for aesthetic, spiritual, cultural, recreational or existence reasons, and assesses how well they are protected. Due to data limitations, these unique aspects can not be discretely measured. Therefore it is assumed that all coastal areas within 1 kilometer of the coast on land, and 3 nautical miles offshore, are special and total area protected is used to measure Lasting Special Places"))
        )
    )
  ),
  
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
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/sop_description.md#sense-of-place",
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
          tags$b("Improved protected areas database."),
          "The USGS Protected Areas Database (PAD 2.0) contains some mismatches with a NOAA database, although they appear to be few and were accounted for when measuring protection. The database is rather comprehensive but the designations are not always clear. Some areas are designated as 'Closed Areas' or 'Closure Areas', without a clear difference between the two."
        ),
        tags$li(
          tags$b("A list of all regionally important areas "),
          "does not exist. Ideally, a regional survey would produce a list of all the places considered special for aesthetic, biological, historical, spiritual or other reasons. Those areas would then be assessed in how well they are protected relative to a desired state. If a survey of this type were to be conducted in the future, it's results could be incorporated into Lasting Special Places."
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
  
  valueBox(
    tags$p(filter(ico_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("home"),
    color = "green",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("All iconic species have a conservation status of Least Concern")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Iconic species are those that are relevant to local cultural identity through a species’ relationship to one or more of the following: 1) traditional activities such as fishing, hunting or commerce; 2) local ethnic or religious practices; 3) existence value; and 4) locally-recognized aesthetic value"))
        )
    )
  ),
  
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
      width = 12,
      (a("For more information on the IUCN Red List conservation status categories click here", 
         href = "https://iucn-csg.org/red-list-categories/"))
      )
  ),

  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/sop_description.md#sense-of-place",
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
          tags$b("A regional list of agreed upon iconic species "),
          "for the Northeast does not currently exist. It is unlikely that such a list will satisfy everyone in the Northeast given how people's attitudes and feelings towards local species can vary. If a more rigorous effort to develop such a list were to be completed in the future, it could be used to replace this Iconic Species list."
        )
      ),
      width = 12
    )
  )
),

## Fishing Engagement  -----

tabItem(
  tabName = "spfis",
  
  fluidRow(box(
    h1("FISHING ENGAGEMENT"),
    width = 9
  ),
  
  valueBox(
    tags$p(filter(spfis_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("home"),
    color = "lime",
    width = 3
  )),
  
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("Coastal communities have high levels of commercial fishing engagement and recreational fishing reliance")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Fishing Engagement is one of three subgoals of Sense of Place and is measured using two distinct layers, Commercial Fishing Engagement and Recreational Fishing Reliance.")),
          tags$li(
            h4(
              "Commercial fishing engagement measures the presence of commercial fishing through fishing activity as shown through permits and vessel landings. A high rank indicates more engagement.")),
          tags$li(
            h4(
              "Recreational fishing reliance measures the presence of recreational fishing in relation to the population of a community. A high rank indicates increased reliance."))
        )
    )
  ),
  
  fluidRow(
    ## scores map
    map_ui(
      id = "spfis_scores_map"
    ),
    
    ## scores through time
    card_ui(
      id = "spfis_scores"
    )
  ),
  
  ## Data layers and targets
  fluidRow(box(
    DT::dataTableOutput("spfis_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Protected marine areas ##
    card_ui(
      id = "spfis_commercial",
      title_text = "Commercial fishing engagement",
      sub_title_text = ""
    ),
    
    ## Protected land in coastal 1km ##
    card_ui(
      id = "spfis_rec",
      title_text = "Recreational reliance",
      sub_title_text = ""
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/sop_description.md#sense-of-place",
      box_width = 6
    ),
    
    text_links_default(
      title = "ACCESS LAYER DATA",
      url = "https://github.com/OHI-Northeast/ne-prep/tree/gh-pages/prep/sop/fishing_engagement/data",
      box_width = 6
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Temporal availability:"),
          "The NOAA Social Vulnerability Index has only been conducted for years 2009 to 2016 so we do not have data previous to 2009. All years 2005 - 2009 were gapfilled using the 2009 data."
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
  valueBox(
    tags$p(filter(rao_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("ship"),
    color = "fuchsia",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("The average gas to wage ratio does not increase over time, each mile of coastline has a public access point, and all fish stocks are sustainably managed")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Access to coastal and ocean resources is inherently difficult to measure, but is an important aspect of Ocean Health and is therefore included in the Index. The data used here is a best attempt to measure the ability for people to access the resources they desire")),
          tags$li(
            h4("Economic access is measured using a ratio of gas prices to wages to represent ability to access the ocean via a gas powered boat. As the ratio increases, access becomes restricted due to increasing costs.")
          )
        )
    )
  ),
  
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
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/rao_description.md#resource-access-opportunities",
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
          tags$b("Coastal accessibility"),
          " is difficult to assess region-wide. Here, coastal access points identified by NOAA's Environmental Sensitivity Index were used to calculate access. This data is likely an incomplete picture of coastal access points. Additionally, information about fee versus free access, or state-wide regulation regarding coastal access, is not included but could improve this measure if available."
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
  valueBox(
    tags$p(filter(hs_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("pagelines"),
    color = "maroon",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        h3("All biogenic habitats that support carbon storage and coastal protection are in good condition")),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            h4(
              "Habitat Services measures two equally important components: Coastal Protection and Carbon Storage")),
          tags$li(
            "Coastal Protection assess the amount of protection provided by marine and coastal habitats against flooding and erosion to coastal areas"
          ),
          tags$li(
            "Carbon storage is the ability of the coastal habitats to remove carbon given their carbon uptake rate and health conditions"
          )
        )
    )
  ),
  
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
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/hs_description.md#habitat-services",
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
          tags$b("Locations of current and past eelgrass beds"), 
          " are not consistently available across the entire Northeast region. Some places, like the Great Bay Estuary in New Hampshire, have long term monitoring efforts that provide near annual estimates of eelgrass cover. But most areas where eelgrass beds exist or existed in the past do not have consistent monitoring datasets. Therefore in order to estimate eelgrass health, we combined all known eelgrass bed locations, past and present, into a single dataset. We then selected all EPA National Coastal Condition Assessment sample sites that were within 10 km of an eelgrass bed and used the Water Quality Index status of those sites to estimate the status of the eelgrass. A great improvement to this layer would be estimates of historical loss in eelgrass cover by region and a consistent monitoring effort across the entire region to track changes and compare with past coverage.")
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

