library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$info_all <- renderInfoBox({
    infoBox("Total Applications",dim(app_df)[1],icon = icon("crosshairs"))
  })
  output$info_rej <- renderInfoBox({
    infoBox("Rejected",sum(app_df$Status==0), icon = icon("thumbs-o-down"),color = "purple")
  })
  output$info_inp <- renderInfoBox({
    infoBox( "In Process",sum(app_df$Status>1) , icon = icon("thumbs-o-up"),color = "yellow")# icon = icon("thumbs-up", lib = "glyphicon")
  })
  # observeEvent(input$addrow, gs_add_row(applications, ws="Applied",input=c(Sys.Date(),input$position,input$job_cat,input$company,input$location,input$job_source,input$app_platform,input$extra,"",input$notes,1)))
  
  ###Warning box
  output$tbls = DT::renderDataTable(app_df%>%select(`Date Applied`,Position,Company),selection = 'single',options = list(pageLength = 3), server = TRUE)
  output$tbl = DT::renderDataTable(app_df, server = TRUE)
  # output$tbls = DT::renderDataTable(app_df()%>%select(`Date Applied`,Position,Company),selection = 'single',options = list(pageLength = 3), server = TRUE)
  # output$tbl = DT::renderDataTable(app_df(), server = TRUE)
  # observeEvent(input$rej_pos, gs_edit_cells(applications, ws="Applied",input=0,anchor = paste0("K",1+input$tbls_rows_selected)))
  # observeEvent(input$rej_pos, gs_edit_cells(applications, ws="Applied",input=Sys.Date(),anchor = paste0("I",1+input$tbls_rows_selected)))
  # app_df <- eventReactive({input$addrow | input$rej_pos},
  #                           gs_read(applications,ws="Applied"), ignoreNULL = FALSE)
})
  
