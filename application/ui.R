library(shiny)
library(shinydashboard)
library(dplyr)


inline = function (x) {
  tags$div(style="display:inline-block;width: 150px;", x)
}

#ui <- 
dashboardPage(
  dashboardHeader(title = "All abt Applications"),
  
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      menuItem("All Applications", tabName = "alldata", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "overview",
              
        # The infoboxes
        fluidRow(

        infoBoxOutput("info_all"),

        infoBoxOutput("info_rej"),
        infoBoxOutput("info_inp")
              ),
        
        # The Inputs
        fluidRow(
          box(
            title = "Add New Application!", width = 6, status = "primary",
            inline(textInput("position", "Position Title")),
            inline(selectizeInput("job_cat", "Category",c("",app_df$Category), selected = NULL, multiple = FALSE, options = list(create = TRUE))),
            inline(textInput("company","Company Name")),
            inline(selectizeInput("location","Location",c("",app_df$Location), selected = NULL, multiple = FALSE, options = list(create = TRUE))),
            inline(selectizeInput("job_source", "Source", c("",app_df$Source), selected = NULL, multiple = FALSE, options = list(create = TRUE))),
            inline(selectizeInput("app_platform", "Application Platform", c("",app_df$Platform), selected = NULL, multiple = TRUE, options = list(create = TRUE))),
            inline(selectizeInput("extra", "Extra Files", c("Coverletter","Transcript"), selected = NULL, multiple = TRUE, options = list(create = TRUE))),
            textInput("notes", "Special Note:"),
            actionButton("addrow", "Add!",width ='200px')
          ),
          box(
            title = "Rejections :( ",status = "warning", width = 6,
            DT::dataTableOutput('tbls'),br(),
            actionButton("rej_pos","It Rejected Me T_T",width ='200px')
          )
        )
      ),
      tabItem(tabName = "alldata",
              h2("Widgets tab content"),
              DT::dataTableOutput('tbl')
      )
    )
  )
)


