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
        a(href = 'https://www.jamiecmontgomery.com/', "Jamie Montgomery.")
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
            "The Ocean Health Index (OHI) measures what people value about oceans and provides a holistic picture on how to manage ocean benefits sustainably for future generations. The Northeast OHI assessment uses the best-available data to measure progress toward target conditions for benefits provided by the region's marine ecosystems, resulting in benefit-specific and overall health scores on a scale of 0 to 100." 
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
            "The goal of this assessment is to serve regional ocean planning by providing a big picture perspective on ocean health based on data and priorities specific to the Northeast. The assessment was led by a team of scientists from the Ocean Health Index program at the National Center for Ecological Analysis and Synthesis (NCEAS). This team worked with the Northeast Regional Ocean Council (NROC) Ocean Planning Committee to get stakeholder input from federal, state, and local governmental organizations, NGO's, and community members. More information can be found at ",
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
          "The Northeast Ocean Health Index uses social, economic, and environmental data to create a comprehensive picture of the state of ocean health from Maine to New York. Below you can explore the results of the assessment across the 11 reporting regions and 13 years of data (2005 - 2017) included in this assessment.", width = 12)),
        fluidRow(
          box(
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
            sub_title_text = "Overall OHI Scores for all regions from the most recently assessed year (2017). Click on a region to see the score."
          ),
          
          box(h4("Goal Scores for 2017"),
              "Ocean Health Index scores are calculated for individual goals separately and then combined to get an overall score on a scale of 0-100. Individual goal scores are represented by the length of the petals in a flower plot below, and the overall 2017 Index score for the region is in the center.",
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
        ),
      
      fluidRow(
        ## scores through time
        card_ui(
          id             = "rgn_goal_scores",
          box_width      = 12,
          title_text     = "Goal scores by region",
          sub_title_text = "Hover over the lines to see individual goal scores. Double click on a goal in the legend to highlight just that line and add additional goals for comparison by clicking on their names in the legend.",
          select_type = "drop_down",
          select_location = "above",
          select_choices = unique(rgn_goal_scores$rgn_name),
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
  
  ### Target and Key Messages ----
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
      "Zero water pollution from pathogens and trash in coastal waters, and sediment and water quality levels meet EPA threshold values"),
  
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
          "The slight downward trend is largely driven by the Sediment Quality Index data layer for most regions")
    ),
  
  ### Scores map and chart ----
  
  fluidRow(
    map_ui(id = "cw_scores_map"),
    
    card_ui(id = "cw_scores")),
  
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                 "This goal is only measured for coastal regions because the majority of people are in direct contact with the coastal ocean")),
                 style = "font-size: 18px",
                 width = 12
    )),
  
  ### Data layers and targets ----
 fluidRow(box(title = "Data layers",
   DT::dataTableOutput("cw_datatable"),
   width = 12)
    ),
  
  ### Clean Water Data Layers chart ----
  fluidRow(
    card_ui(
      id = "cw_layers",
      title_text = "Data layer scores",
      sub_title_text = "Each data layer is scored on a 0 to 100 scale. Missing data for Water and Sediment Quality is gapfilled by taking the most recent datapoint and carrying it forward. The final Clean Waters scores are calculated using a geometric mean of these four data layers.
      
      Hover over the lines to see individual scores. Double click on a region in the legend to highlight just that line and add additional regions for comparison by clicking on their names in the legend.",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(cw_layers$rgn_name),
      select_label = "",
      box_width = 12
    )
  ),
  
  ### Text boxes with links ----
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/cw_description.md#clean-waters",
      box_width = 12
    )
  ),
 
  ### Data Considerations and Potential Improvements ----
  fluidRow(
    box(title = "Data Considerations & Potential Improvements",
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      br(),
      br(),
      tags$ul(
        tags$li(
          tags$b("Trash data:"),
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

  ### Target and Key Messages----
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        "Maximize the amount of sustainable seafood produced from wild-caught fisheries and aquaculture",
        style = "font-size: 18px"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        tags$ul(
          tags$li(
            "The decrease in scores for some regions around 2012 is largely due to a decrease in Atlantic herring catch and an increase in Gulf of Maine Lobster catch"),
          tags$li("Some regions produce more seafood from aquaculture than wild-caught fisheries")),
        style = "font-size: 18px"
        )
    ),
  
  ### Scores map and chart ----
  fluidRow(
    map_ui(
      id = "fp_scores_map"
    ),
    card_ui(
      id = "fp_scores"
    )
  ),
  
  ### Key Information----
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Food provision includes both wild-caught fisheries and aquaculture. The final score is weighted by total production by each of sector"),
                 tags$li(
                   "This measures both the total amount of seafood produced and it's sustainability"
                 )),
               style = "font-size: 18px",
               width = 12
  )),
  
  ### Data layers and targets----
  fluidRow(box(title = "Data layers",
               DT::dataTableOutput("fp_datatable"),
               width = 12)
  ),
  
  
  ### Sub-goal scores----
  fluidRow(

    card_ui(
      id = "fp_layers",
      title_text = "Sub-goal scores",
      sub_title_text = "Food Provision includes two sub-goals, Wild-Caught Fisheries and Aquaculture. The final score for Food Provision is a production-weighted average of these two scores.",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(fp_layers$rgn_name),
      selected = "Connecticut",
      box_width = 6
    ),
    
    card_ui(
      id = "fp_weights",
      title_text = "Annual Seafood Production",
      sub_title_text = "Total production in pounds produced by aquaculture and wild-caught fisheries. The proportional production from each sector is used to weight each sub-goal when calculating Food Provision goal scores",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(production_weights$rgn_name),
      selected = "Connecticut",
      box_width = 6
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
  
  ### Target and Key Messages----
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE,
        "All harvested stocks are neither overfished nor underfished but rather fished at maximum sustainable yield",
        style = "font-size: 18px"
        ),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,
        "The decrease in scores for some regions around 2012 is largely due to a decrease in Atlantic herring catch and an increase in Gulf of Maine Lobster catch",
        style = "font-size: 18px"
        )
  ),
  
  ### Scores map and chart----
  fluidRow(
    map_ui(
      id = "fis_scores_map"
    ),
    card_ui(
      id = "fis_scores"
    )
  ),

  ### Key Information ---- 
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Bait fisheries, such as herring, skate & mackerel, are important in the Northeast. Only harvest meant for direct human consumption from these fisheries is included in the score"),
                 tags$li(
                   "These scores reflect the status of fish where they are caught, not the port where they are landed")
               ),
               style = "font-size: 18px",
               width = 12
  )),

  ### Data layers and targets----
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("fis_datatable"),
    width = 12
  )),
  
  ### NOAA Landings chart ----
  fluidRow(
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
  
  ### Stock assessment chart----
  fluidRow(
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
  
  ### Text boxes with links ----
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/fis_description.md#wild-caught-fisheries",
      box_width = 12
    )
  ),
  
  ### Data Considerations & Potential Improvements ----
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
  
  ### Target and Key Messages ----
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "Sustainably farmed seafood production is growing by 4% annually"
        ),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
              "Regions with increasing production see higher scores over time")),
  
  ### Scores map and chart ----
  fluidRow(

    map_ui(
      id = "mar_scores_map"
    ),

    card_ui(
      id = "mar_scores"
    )
  ),
  
  ### Key Information ----
  fluidRow(box(title = "Key Information",
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Scores for this goal are largely driven by reporting formats and standards which vary significantly across each state"),
                 tags$li(
                   "Kelp or seaweed farming is a new but growing sector of the aquaculture industry in the northeast. It has not reached commercial scale and therefore is not included in these scores"),
                 tags$li("Both Massachusetts North and South regions have the same score. Without farm level location and production data, these regions can not be assessed separately."),
                 tags$li("There is significant opportunity to grow aquaculture in the Northeast, but there are no explicit targets for future production, therefore the target of a 4% annual growth rate was chosen by looking at historical growth across all species, as well as historical aquaculture growth trajectories in the United States."),
                 tags$li(
                   "There is one mussel farm located offshore but production is not yet included since it has not reached commercial scale. All other commercial farms are located within state waters")
               ),
               style = "font-size: 18px",
               width = 12)),
  
  ### Data layers and targets ----
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("mar_datatable"),
    width = 12
  )),
  
  ### Production data and sustainability table ----
  fluidRow(

    card_ui(
      id = "mar_production",
      title_text = "Aquaculture species production",
      sub_title_text = "Double click on a species in the legend to highlight just that line. Hover over the lines to see point data.",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(mar_production$Region),
      box_width = 8
    ),
    
    ### Species sustainability table
    box(
      DT::dataTableOutput("mar_spp_sust_table"),
      width = 4,
      br(),
      "The sustainability scores are scaled from 0 (lowest) to 1 (highest)."
    )
  ),
  
  ### Text boxes with links ----
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/mar_description.md#aquaculture",
      box_width = 12
    )
  ),
  
  ### Data Considerations & Potential Improvements ----
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
          tags$b("Connecticut oyster production: "),
          "has not been reported since 2010. We gapfill this missing data by carrying the most recent reported production forward to 2017."
        ),
        tags$li(
          tags$b("Massachusetts production data: "),
          "comes from the Department of Marine Fisheries annual reports. The oldest report is from 2011, therefore production data previous to 2010 is not available."
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "All coastal dependent livelihoods and economies are growing through time"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
          tags$ul(
            tags$li("Coastal livelihoods and economies have been increasing over time"),
            tags$li("Low scores for Massachusetts-South between 2009 and 2013 are due to decreased employment, wages and GDP in the Living Resources and Transportation sectors")))
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
  
  ## Key information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "This goal measures Livelihoods and Economies separately, with the final score equal to a simple average of the two scores.")),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("le_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## LE layers ##
    card_ui(
      id = "le_layers",
      title_text = "Livelihoods and Economies sub-goal scores",
      sub_title_text = "Livelihoods & Economies includes two sub-goals, Livelihoods and Economies. The final score is an un-weighted average of these two scores. Hover over the lines to see individual scores. Double click on a sub-goal in the legend to highlight just that line.",
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "Annual growth for ocean-dependent jobs meets or exceeds national growth & wages grow by 3.5% annually"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        tags$ul(
          tags$li("Nearly all regions are experiencing growth in GDP from ocean-related sectors"),
          tags$li("Low scores for Massachusetts-South between 2009 and 2013 are due to decreased employment and wages in the Living Resources and Transportation sectors")))),

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
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "There is some data suppression in the National Ocean Economics Program dataset due to confidentiality statutes. If data suppression in earlier years suddenly becomes expressed, it will show up as a large increase in Jobs or Wages. This can be seen in New Hampshire's Transportation sector in 2011.")),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("liv_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Employment ##
    card_ui(
      id = "liv_emp",
      title_text = "Employment",
      sub_title_text = "Hover over the lines to see individual scores. Double click on a sector in the legend to highlight just that line and add additional sectors for comparison by clicking on their names in the legend.",
      select_type = "drop_down",
      select_location = "above",
      select_choices = unique(jobs_scores$rgn_name)
    ),
    
    ## Wages ##
    card_ui(
      id = "liv_wages",
      title_text = "Average annual wages",
      sub_title_text = "Hover over the lines to see individual scores. Double click on a sector in the legend to highlight just that line and add additional sectors for comparison by clicking on their names in the legend.",
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
      box_width = 12
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Sector switching "),
          "is a common occurrence but is not captured in the employment dataset. If a person switches between fishing and aquaculture, for example, the Living Resources employment numbers should remain the same."
        ),
        tags$li(
          tags$b("Data suppression "),
          "in economic data is often due to confidentiality and privacy concerns for individuals and firms. This can limit the total amount of usable information about economic indicator such as jobs, wages and GDP, especially for small sectors or regions."
        )
      ),
      width = 12
))),

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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "Annual growth in ocean related sectors’ Gross Domestic Product is at least 3%"),
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
         tags$ul(
           tags$li("Nearly all regions are experiencing growth in GDP from ocean-related sectors"),
           tags$li("Low scores for Massachusetts-South between 2009 and 2013 are due to decreased GDP in the Living Resources and Transportation sectors")))),
  
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
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "A target of 3% annual growth aligns with widely accepted growth targets for GDP in the United States"),
                 tags$li("There is some data suppression in the National Ocean Economics Program dataset due to confidentiality statutes. If data suppression in earlier years suddenly becomes expressed, it will show up as a large increase in GDP. This can be seen in New Hampshire's Transportation sector in 2011")),
               style = "font-size: 18px",
               width = 12)),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("eco_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## GDP ##
    card_ui(
      id = "eco_gdp",
      title_text = "Gross Domestic Product",
      sub_title_text = "GDP in 2012 US Dollars. Hover over the lines to see individual scores. Double click on a sector in the legend to highlight just that line and add additional sectors for comparison by clicking on their names in the legend.",
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
      box_width = 12
    )
  ),
  
  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Data suppression "),
          "in economic data is often due to confidentiality and privacy concerns for individuals and firms. This can limit the total amount of usable information about economic indicator such as jobs, wages and GDP, especially for small sectors or regions."
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "Jobs in coastal tourism sectors are growing (reflecting overall growth in tourism participation), coastal recreation is not inhibited by beach closures and each mile of coastline has a public access point"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
          tags$ul(
            tags$li("Variation in scores over time is primarily due to changes in beach closures"),
            tags$li("Coastal access ranges widely across the region")))),
  
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
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Coastal access is measured using access points identified by the NOAA Environmental Sensitivity Index. The access points include locations identifed as boat ramps, campgrounds, beaches, historical sites, access points, marinas, ferrys, ports and parks.")),
               style = "font-size: 18px",
               width = 12)),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("tr_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Employment ##
    card_ui(
      id = "tr_jobs",
      title_text = "Jobs in Tourism",
      sub_title_text = "Number of jobs in the tourism sector for coastal counties. Hover over the lines to see individual scores. Double click on a sector in the legend to highlight just that line and add additional sectors for comparison by clicking on their names in the legend."
    ),
    
    ## Coastal access ##
    card_ui(id = "tr_coastal",
            title_text = "Coastal Access",
            sub_title_text = "Proportion of publically accessible coastline")),
    
  fluidRow(
    ## Beach Closures ##
    card_ui(
      id = "tr_beach",
      title_text = "Beach Closures",
      sub_title_text = "This layer reports the average percentage of a swim season (~100 days) with beaches closed to recreation. Hover over the lines to see individual scores. Double click on a region in the legend to highlight just that line and add additional regions for comparison by clicking on their names in the legend.",
      box_width = 12
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/tr_description.md#tourism-and-recreation",
      box_width = 12
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
        ),
        tags$li(
          tags$b("Coastal accessibility"),
          " is difficult to assess region-wide. Here, coastal access points identified by NOAA's Environmental Sensitivity Index were used to calculate access. This data is likely an incomplete picture of coastal access points. Additionally, information about fee versus free access, or state-wide regulation regarding coastal access, is not included but could improve this measure if available."
      )
      ),
      width = 12
    )
)),


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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "No marine species are at risk of extinction and all habitats that support biodiversity are in good condition"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        tags$ul(
          tags$li("Biodiversity scores have been increasing over time for most regions"),
          tags$li("Species conservation statuses rarely change over time so much of the variation in scores is due to changes in habitat health, specifically impact to seabed habitats.")))),

  ## scores map
  map_ui(
    id = "bio_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "bio_scores"
  ),
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Biodiversity tries to measure the conservation status of all ocean-dependent species in the Northeast. Since not all marine species have been assessed, habitat health is also included as an indicator for species that rely on these habitats")),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("bio_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## BIO layers ##
    card_ui(
      id = "bio_layers",
      title_text = "Species and Habitats scores",
      sub_title_text = "Biodiversity scores are calculated as an un-weighted average of the Species and Habitats scores.",
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "All species identified as present in the region are not at risk of extinction and are classified as of Least Concern by IUCN criteria"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "Scores remain quite constant over time with no more than a 3 point variation")),
  
  ## scores map
  map_ui(
    id = "spp_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "spp_scores"
  ),
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "There are 691 species included in the biodiversity-species score"
                 ),
                 tags$li(
                     "Species scores represent the health of all marine species present in a region, including endangered species and species in relatively good conditions. The presence of higher-risk species leads to a lower score."
                 ),
                 tags$li(
                     "Scores are not weighted by the size of a species range. If a species is found in a region, it's conservation status is included in the region score."
                 ),
                 tags$li(
                   "Marine species conservation status' are updated infrequently, so changes in scores are due to pressures and resilience measures for species biodiversity")
               ),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("spp_datatable"),
    width = 12
  )),
  
  ## Species by region and status ##
  fluidRow(
  card_ui(
    id = "spp_rgn_count",
    title_text = "Species by region and status",
    sub_title_text = "Species status scores range from 0 (Extinct) to 1 (Least Concern)",
    box_width = 12,
    source_text = a("Click here for a full list of the species by region", href = "https://github.com/OHI-Northeast/ne-prep/blob/gh-pages/prep/bio/spp/data/species_list_by_rgn.csv", target = "_blank")
  )),

  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/bio_description.md#biodiversity",
      box_width = 12
    )
  ),

  fluidRow(
    box(
      h4("Data Considerations & Potential Improvements"),
      "There is always opportunity to improve data quality and availability. Below we have identifed where improving these data could improve our understanding of ocean health",
      tags$ul(
        tags$li(
          tags$b("Species range maps "),
          "from the IUCN red list are often global in scale and not created specifically for the region. Maps from the data portal are modeled species ranges for the Northeast. All species maps are static and do not change over the time period. Any changes in species ranges are not currently captured in the way Species is calculated."
        ),
        tags$li(
          tags$b("Species' conservation status "),
          "are not often updated. A comprehensive assessment of a species status requires dedicated resources and effort which limit the capacity to assess all species in an area. When available, conservation status for species varies by state and is incorporated in the score. For species without state-level conservation status, the score relies on either the status according to the United States Endangered Species Act or IUCN red list criteria."
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
    tags$p(filter(hab_scores_map, region_id == 0)$score,
           style = "font-size: 150%;"),
    "",
    icon = icon("pagelines"),
    color = "aqua",
    width = 3
  )),
  
  fluidRow(
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "No loss of salt marsh habitats from historical estimates, all eelgrass habitats have good water quality condition, and all seabed habitats have low levels of disturbance from fishing activity"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
            "The habitat score changes are largely driven by changes in seabed habitat impacts from fishing")),
  
  ## scores map
  map_ui(
    id = "hab_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "hab_scores"
  ),
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Seabed habitat disturbance is the only habitat data layer with annual information. The health and trajectory of Salt Marsh and Eelgrass Beds are more difficult to calculate with limited data.")),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("hab_datatable"),
    width = 12
  )),

  fluidRow(

    ## Habitat layer scores b/w 0 and 100 ##
    card_ui(
      id = "hab_layer_scores",
      title_text = "Habitat layer scores",
      sub_title_text = "Data layers are translated into 0-100 scores for 2005-2017.\nEELGRASS BEDS: Scores are based on the EPA's Water Quality Index scores for sites sampled within 10km of current or past eelgrass beds.\nSALT MARSH: Scores are equal to the proportional loss of salt marsh habitat since the 1800's.\nSEABED HABITATS: Scores are equal to the percent disturbance from fishing.",
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
      box_width = 12
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "Areas of importance are protected as lasting special places, iconic species are not threatened and fishing engagement is high for coastal communities"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
              "While there is a large range in scores between regions, Sense of Place scores remain relatively consistent over time in each region")
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

fluidRow(box(title = "Key Information", 
             background = "light-blue",
             tags$ul(
               tags$li(
                 "Sense of Places captures the aspects of the coastal and marine system that people value as part of their cultural identity")),
             style = "font-size: 18px",
             width = 12
)),

fluidRow(
  ## SOP layers ##
  card_ui(
    id = "sop_layers",
    title_text = "Sub-goal scores",
    sub_title_text = "Sense of Place includes three sub-goals, Coastal Access, Fishing Engagement and Fisheries Sustainability. The final score is an un-weighted average of these three sub-goal scores.",
    select_type = "drop_down",
    select_location = "above",
    select_choices = unique(sop_layers$rgn_name),
    selected = "Connecticut",
    select_label = "",
    box_width = 12
  )
),

## Text boxes with links ##
fluidRow(
  text_links_default(
    title = "Click here for detailed methods",
    url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/sop_description.md#sense-of-place",
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "At least 10% of coastal waters are protected and 17% of land within 1km of the coast is protected"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
              "The amount of protected area in state waters has not changed over the time period, so all increases in scores are due to increased protection of coastal land area")
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
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li("There are no explicit targets for the Northeast in regards to marine and coastal land protection so the chosen targets (10% of marine area, 17% of land area) come from Aichi Target 11"),
                 tags$li(
                   "Lasting Special Places includes geographic locations that hold particular value for aesthetic, spiritual, cultural, recreational or existence reasons, and assesses how well they are protected. Due to data limitations, these unique aspects can not be discretely measured. Therefore it is assumed that all coastal areas within 1 kilometer of the coast on land, and 3 nautical miles offshore, are special and total area protected is used to measure Lasting Special Places")),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("lsp_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Protected marine areas ##
    card_ui(
      id = "lsp_marine",
      title_text = "Marine area protected",
      sub_title_text = "This data shows how much marine area (%) within state waters is protected. Hover over the lines to see individual scores. Double click on a region in the legend to highlight just that line and add additional regions for comparison by clicking on their names in the legend."
    ),
    
    ## Protected land in coastal 1km ##
    card_ui(
      id = "lsp_land",
      title_text = "Coastal land protected",
      sub_title_text = "This data shows how much land (%) within 1 kilometer of the coastline is protected. Hover over the lines to see individual scores. Double click on a region in the legend to highlight just that line and add additional regions for comparison by clicking on their names in the legend."
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/sop_description.md#lasting-special-places",
      box_width = 12
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "All iconic species have a conservation status of Least Concern"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
              "Since species status and range maps are not often updated, the fluctuation in scores are driven by external pressures such as climate change, habitat destruction, water pollution, and more")
  ),
  
  ## scores map
  map_ui(
    id = "ico_scores_map"
  ),
  
  ## scores through time
  card_ui(
    id = "ico_scores"
  ),
  
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Iconic species are those that are relevant to local cultural identity through a species’ relationship to one or more of the following: 1) traditional activities such as fishing, hunting or commerce; 2) local ethnic or religious practices; 3) existence value; and 4) locally-recognized aesthetic value")),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(tutle = "Data layers",
    DT::dataTableOutput("ico_datatable"),
    width = 12
  )),
  
  #iconic species heatmap
  fluidRow(
    box(
      plotOutput("ico_heatmap"),
      width = 12,
      (a("For more information on the IUCN Red List conservation status categories click here", 
         href = "https://iucn-csg.org/red-list-categories/", target = "_blank"))
      )
  ),

  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/sop_description.md#iconic-species",
      box_width = 12
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "Coastal communities have high levels of commercial fishing engagement and recreational fishing reliance"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
    "Fishing engagement has remained relatively stable over time with some regions experiencing increases. Recreational fishing reliance tends to score lower than commercial fishing engagement."
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
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Fishing Engagement is one of three subgoals of Sense of Place and is measured using two distinct layers, Commercial Fishing Engagement and Recreational Fishing Reliance."),
                 tags$li(
                   "Commercial fishing engagement measures the presence of commercial fishing through fishing activity as shown through permits and vessel landings. A high rank indicates more engagement."),
                 tags$li(
                   "Recreational fishing reliance measures the presence of recreational fishing in relation to the population of a community. A high rank indicates increased reliance."),
                 tags$li("The target of 10% higher than the highest regional score was chosen under the assumption that there is capacity for improvement and increases in both commercial fishing engagement and recreational fishing reliance")),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("spfis_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Protected marine areas ##
    card_ui(
      id = "spfis_commercial",
      title_text = "Commercial fishing engagement",
      sub_title_text = "Hover over the lines to see individual scores. Double click on a region in the legend to highlight just that line and add additional regions for comparison by clicking on their names in the legend."
    ),
    
    ## Protected land in coastal 1km ##
    card_ui(
      id = "spfis_rec",
      title_text = "Recreational reliance",
      sub_title_text = "Hover over the lines to see individual scores. Double click on a region in the legend to highlight just that line and add additional regions for comparison by clicking on their names in the legend."
    )
  ),
  
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/sop_description.md#fishing-engagement",
      box_width = 12
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
    box(title = "Target", status = "primary", solidHeader = TRUE,  style = "font-size: 18px",
        "The average gas to wage ratio does not increase over time, each mile of coastline has a public access point, and all fish stocks are sustainably managed"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE,  style = "font-size: 18px",
        "Access to fish stocks is improving due to improved stock status, but steep spikes and dips in the ratio of gas prices to wages drive large changes in the overall score"
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
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Access to coastal and ocean resources is inherently difficult to measure, but is an important aspect of Ocean Health and is therefore included in the Index. The data used here is a best attempt to measure the ability for people to access the resources they desire"),
                 tags$li("Economic access is measured using a ratio of gas prices to wages to represent ability to access the ocean via a gas powered boat. As the ratio increases, access becomes restricted due to increasing costs."
                 )
               ),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
    DT::dataTableOutput("rao_datatable"),
    width = 12
  )),
  
  fluidRow(
    ## Economic access ##
    card_ui(id = "rao_econ",
            title_text = "Economic Access",
            sub_title_text = "Ratio of gas ($/barrel) to wages."),

   
    ## Coastal access ##
    card_ui(id = "rao_coastal",
            title_text = "Coastal Access",
            sub_title_text = "Proportion of publically accessible coastline.")
    ),
  
  fluidRow(
    ## FSSI ##
  
    card_ui(id = "rao_avg_fssi",
            title_text = "Average Fish stock sustainability index (FSSI)",
            sub_title_text = "NOAA's FSSI measures stock sustainability on a 0 (unsustainable) to 4 (sustainable).",
            box_width = 12)
  ),
  ## Text boxes with links ##
  fluidRow(
    text_links_default(
      title = "Click here for detailed methods",
      url = "https://github.com/OHI-Northeast/ne-scores/blob/master/metadata_documentation/ohi_model/goal_descriptions/rao_description.md#resource-access-opportunities",
      box_width = 12
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
    box(title = "Target", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
        "All biogenic habitats that support carbon storage and coastal protection are in good condition"),
    
    box(title = "Key Messages", status = "primary", solidHeader = TRUE, style = "font-size: 18px",
       "Carbon Storage scores better than Coastal Protection for most, but not all, regions"
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
  
  ## Key Information
  fluidRow(box(title = "Key Information", 
               background = "light-blue",
               tags$ul(
                 tags$li(
                   "Habitat Services measures two equally important components: Coastal Protection and Carbon Storage"),
                 tags$li(
                   "Coastal Protection assess the amount of protection provided by marine and coastal habitats against flooding and erosion to coastal areas"
                 ),
                 tags$li(
                   "Carbon Storage is the ability of the coastal habitats to remove carbon given their carbon uptake rate and health conditions"
                 )
               ),
               style = "font-size: 18px",
               width = 12
  )),
  
  ## Data layers and targets
  fluidRow(box(title = "Data layers",
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
      box_width = 12
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

