library(shiny)
library(googlesheets)
library(lubridate)

app_df0<-ss %>% gs_read(ws="Applied")
shinyServer(function(input, output,session) {
  ### TOP INFO-BOXES ###
  output$info_all <- renderInfoBox({
    infoBox("Total Applications",dim(app_df())[1],icon = icon("crosshairs"))
  })
  output$info_rej <- renderInfoBox({
    infoBox("Rejected",sum(!is.na(app_df()$Date_Rejected)), icon = icon("thumbs-o-down"),color = "purple")
  })
  output$info_inp <- renderInfoBox({
    infoBox( "In Process",sum(!is.na(app_df()$Date_Responded)) , icon = icon("thumbs-o-up"),color = "yellow")# icon = icon("thumbs-up", lib = "glyphicon")
  })
  ### FLUID ROWS ###
  ## ADD APPLICATION ##
  observeEvent(input$addrow, gs_add_row(ss, ws="Applied",input=c(cat(Sys.Date()),input$position,input$job_cat,input$company,input$location,input$job_source,input$app_platform,input$extra,input$notes)))
  observeEvent(input$addrow, gs_edit_cells(ss, ws="Applied",input=Sys.Date()
                                           ,anchor = paste0("A",dim(app_df())[1]+2), byrow = TRUE))
  
  ## UPDATE PROCESS##
  # Add Datatable to help you select records
  output$tbls = DT::renderDataTable(app_df()%>%select(Date_Applied,Position,Company),selection = 'single',options = list(pageLength = 4), server = TRUE)
  output$tbl = DT::renderDataTable(app_df(), server = TRUE)
  
  # Update: Next step/Reject
  observeEvent(input$acc_pos, gs_edit_cells(ss, ws="Applied",input=Sys.Date(),anchor = paste0("L",1+input$tbls_rows_selected)))
  observeEvent(input$rej_pos, gs_edit_cells(ss, ws="Applied",input=Sys.Date(),anchor = paste0("M",1+input$tbls_rows_selected)))
  app_df <- eventReactive({input$addrow | input$rej_pos},
                            gs_read(ss,ws="Applied"), ignoreNULL = FALSE)
  # app_df0 <- eventReactive(if ({input$addrow&input$rej_pos}==0){ss %>% gs_read(ws="Applied")}else(app_df())
  #                          )
})
  
