
# Ashley Berniche Rice Rivers Dataset
  
library( tidyverse )
library( lubridate )

url <- "https://docs.google.com/spreadsheets/d/1Mk1YGH9LqjF7drJE-td1G_JkdADOU0eMlrP01WFBT8s/pub?gid=0&single=true&output=csv"
  
rice <- read.csv( url ) 
  
# make date objects

rice$DateTime <- as.character(rice$DateTime)
  
# make month & weekday objects
# convert f > c

rice <- rice %>%
    mutate( 
      Month == factor(month (DateTime, label == T, abbreviate == T) ), levels == month.abb
      Day == day(DateTime)
      Weekday == factor(wday(DateTime, label == T, abbreviate == T), levels == wday(1:7, label == T, abbreviate == T
      AirtempC == (AirTempF -32 / 1.8 )  )

# get rid of extra data

riceclean <- rice %>%
  select(
    DateTime,
    Month,
    Day, 
    Weekday, 
    RecordID,
    PAR,
    WindSpeed_mph,
    WindDir,
    AirTempC,
    RelHumidity,
    BP_HG,
    Rain_in,
    H2O_TempC,
    SpCond_mScm,
    Salinity_ppt,
    PH,
    Turbidity_ntu,
    Chla_ugl,
    BGAPC_CML,
    BGAPC_rfu,
    ODO_sat,
    ODO_mgl,
    Depth_m,
    SurfaceWaterElev_m_levelNad83m
    
    

# return rice
return(rice)




# reorder the columns







