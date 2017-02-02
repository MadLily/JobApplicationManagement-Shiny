library(shiny)
library(shinydashboard)
library(dplyr)

app_df0<-ss %>% gs_read(ws="Applied")
#--------------- General Functions--------------
inline = function (x) {
  tags$div(style="display:inline-block;width: 190px;", x)
}

inline_s = function (x) {
  tags$div(style="display:inline-block;width: 95px;", x)
}
#--------------- Build Dashboaard ----------------------
# Build Dashboard
dashboardPage(
  dashboardHeader(title = "All abt Applications"),
  
  ##------------ Build Dashboard Sidebar -----
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      menuItem("All Applications", tabName = "alldata", icon = icon("th"))
    )
  ),
  ##------------ Build Dashboard Body --------
  dashboardBody(
    tabItems(
      ### -------Page One: Overview ------
      tabItem(tabName = "overview",
              
        #### The infoboxes
        fluidRow(
        infoBoxOutput("info_all"),
        infoBoxOutput("info_rej"),
        infoBoxOutput("info_inp")
              ),
        
        #### The Inputs
        fluidRow(
          ##### Application Input
          box(
            title = "Add New Application", width = 5, status = "primary",
            inline(textInput("position", "Position Title")),
            inline(selectizeInput("job_cat", "Category",c("",app_df0$Category), selected = NULL, multiple = FALSE, options = list(create = TRUE))),
            inline(textInput("company","Company Name")),
            inline_s(selectizeInput("location","Location",c("",app_df0$Location), selected = NULL, multiple = FALSE, options = list(create = TRUE))),
            inline_s(selectizeInput("job_func","Function/Field",c("",app_df0$Field), selected = NULL, multiple = FALSE, options = list(create = TRUE))),
            inline(selectizeInput("extra", "Extra Files", c("Coverletter","Transcript"), selected = NULL, multiple = TRUE, options = list(create = TRUE))),
            inline_s(selectizeInput("job_source", "Source", c("",app_df0$Source), selected = NULL, multiple = FALSE, options = list(create = TRUE))),
            inline_s(selectizeInput("app_platform", "Application Platform", c("",app_df0$Platform), selected = NULL, multiple = TRUE, options = list(create = TRUE))),
            sliderInput("since_posted","Days Since Posted",min = 0, max = 30,value = 15),
            tags$div(style="display:inline-block;",textInput("notes", "A Special Note:")),
            actionButton("addrow", "Add!",width ='190px')
          ),
          ##### Progress Input : Rejection & Next Step
          box(
            title = "Progress Update!  ",status = "warning", width = 7,
            "Search and choose the position you want to update and then make an update: ",br(),br(),
            DT::dataTableOutput('tbls'),br(),
            tags$div(style="display:inline-block;width:135px;",actionButton("acc_pos","It Accepted Me ^_^")),
            tags$div(style="display:inline-block;width:135px;",actionButton("rej_pos","It Rejected Me T_T"))
          )
        )
      ),
      ### -------Page Two: Applications ------
      tabItem(tabName = "alldata",
              h2("Widgets tab content"),
              DT::dataTableOutput('tbl')
      )
    )
  )
)


