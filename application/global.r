## prepare the OAuth token and set up the target sheet:
##  - do this interactively
##  - do this EXACTLY ONCE
# shiny_token <- gs_auth() # authenticate w/ your desired Google identity here
# saveRDS(shiny_token, "shiny_app_token.rds")
# ss <- gs_title("Example")
# ss$sheet_key
## if you version control your app, don't forget to ignore the token file!
## e.g., put it into .gitignore
setwd("/Users/Bianbian/Documents/Courses/2016Fall/2016Careers/umm/Summary/application")

googlesheets::gs_auth(token = "shiny_app_token.rds")
sheet_key <- "1RA_gqvd3EQl_OQkvLOQDpIrnDZsXpCpNn7r6VRO7Yhs"
ss <- googlesheets::gs_key(sheet_key)