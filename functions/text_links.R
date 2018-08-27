library(shiny)
library(shinydashboard)

text_links_default <- function(title = NULL,
                               url = NULL,
                               text_link = NULL) {
  
  box(class = "text_link_button",
      h3(strong(a(title,
                  href = url,
                  target = "_blank"))), 
      width = 4,
      status = "warning",
      solidHeader = TRUE)
}

##I haven't touched the stuff below from Imagine Boston (except changing plan_link_button to text_link_button)
text_links_extra <- function(titles,
                             urls) {
  
  fluidRow(box(class = "text_link_button",
               h3(strong(a(titles[1],
                           href = urls[1],
                           target = "_blank"))), 
               width = 4,
               status = "warning",
               solidHeader = TRUE),
           
           box(class = "text_link_button",
               h3(strong(a(titles[2],
                           href = urls[2],
                           target = "_blank"))),
               width = 4,
               status = "warning",
               solidHeader = TRUE),
           
           box(class = "text_link_button",
               h3(strong(a(titles[3],
                           href = urls[3],
                           target = "_blank"))), 
               width = 4,
               status = "warning",
               solidHeader = TRUE))
  
}