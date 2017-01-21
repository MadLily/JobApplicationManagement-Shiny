# # Authentification 
# gs_gap() %>% 
#   gs_copy(to = "Gapminder")
library(googlesheets)
# Register a sheet: 
applications <- gs_title("Application")

# Browse in safarr:
# applications %>% gs_browse()
app_df <-applications %>% gs_read(ws="Applied")
#Read in your sheet: 
applied<- applications %>% gs_read(ws="Applied")
pending<- applications %>% gs_read(ws="Pending")

# Test Add row
# applications %>% gs_add_row(input = head(adf,1))
applications %>% gs_add_row(ws="Pending",input =c())

library(plotly)


app_df %>% group_by(`Date Applied`) %>% summarise(count = n()) %>% ggplot( aes(x=`Date Applied`, y=count)) +geom_line() +geom_point()
ggplotly()

## Important Numbers
# Number applied; Number pending; Number rejected (Including the percentage)

# Numbers alive (applied - rejected)
# Numbers within past two weeks

## Positions 
# Applications per day (line plot)
app_df %>% group_by(`Date Applied`) %>% summarise(count = n()) %>% ggplot(aes(x=`Date Applied`, y=count)) +geom_line() +geom_point()+xlab("Date") + ylab("Number of Applications") + ggtitle("Applications by Day")  
ggplotly()

app_df %>% group_by(`Date Applied`,Category) %>% summarise(count = n()) %>% ggplot(aes(x=`Date Applied`, y=count,color=Category)) +geom_line() +geom_point()+xlab("Date") + ylab("Number of Applications") + ggtitle("Applications by Day")  
ggplotly()

# Cumsum all
app_df %>% group_by(`Date Applied`) %>% summarise(count = n()) %>% mutate(cumsum = cumsum(count))%>% ggplot(aes(x=`Date Applied`, y=cumsum)) +geom_line() +geom_point()+xlab("Date") + ylab("Number of Applications") + ggtitle("Applications by Day") 
ggplotly()

# Cumsum each 
app_df %>% group_by(`Date Applied`,Category) %>% summarise(count = n()) %>% ggplot(aes(x=`Date Applied`, y=count,color=Category)) +geom_line() +geom_point()+xlab("Date") + ylab("Number of Applications") + ggtitle("Applications by Day")  
ggplotly()


# Geographical distribution: Overall, by type

## Sources and platforms
# Number&Acceptance by Position name
# Number&Acceptance by Location
# Number by Source




# Rejection 
# Summary statistics
app_df %>% filter(`Date Rejected`>0) %>% select(`Date Applied`,`Date Rejected`) %>% mutate(rej_interval = as.duration(interval(`Date Applied`,`Date Rejected`))/ddays(1))%>%summarise(min= min(rej_interval),mean=mean(rej_interval),median=median(rej_interval),max=max(rej_interval))
# Boxplot
app_df %>% filter(`Date Rejected`>0) %>% select(`Date Applied`,`Date Rejected`) %>% mutate(rej_interval = as.duration(interval(`Date Applied`,`Date Rejected`))/ddays(1))%>%ggplot(aes(y=rej_interval,x="")) +geom_boxplot()+ xlab("") + ylab("") + ggtitle("Boxplot of Rejection Interval")  
ggplotly()
# With time
app_df %>% filter(`Date Rejected`>0) %>% select(`Date Applied`,`Date Rejected`) %>% mutate(rej_interval = as.duration(interval(`Date Applied`,`Date Rejected`))/ddays(1))%>% group_by(`Date Applied`) %>% summarise(mean_rej_interval = mean(rej_interval))%>%ggplot(aes(x=`Date Applied`,y=mean_rej_interval)) +geom_point() + xlab("Date Applied") + ylab("Mean Rejection interval(Days)") + ggtitle("Trend of Rejection Interval")  
ggplotly()
# Date 
app_df <-applied


app_df$`Date Applied`=ydm(paste("17-", app_df$`Date Applied` , sep =""))
# gs_edit_cells(applications,ws="Applied", input = app_df$`Date Applied`,
#               anchor = "A2",byrow = FALSE)

# In googlesheet you always have the ones displayed in character..... 1. Read local value/2.change date in dataframes!