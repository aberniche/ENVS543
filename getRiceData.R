# Ashley Berniche Rice Rivers Dataset

library(tidyverse)
library(lubridate)

getricedata <- function() {
  
  url <- "https://docs.google.com/spreadsheets/d/1Mk1YGH9LqjF7drJE-td1G_JkdADOU0eMlrP01WFBT8s/pub?gid=0&single=true&output=csv"
  
  read_csv(url) |> 
    mutate( Date = mdy_hms(DateTime) ) |> 
    mutate( Month = month(Date, label = TRUE, abbr = TRUE),
            Day = day(Date),
            Weekday = wday(Date, label = TRUE, abbr = TRUE)) |>
    mutate( AirTempC = (AirTempF - 32) / 1.8 ) |>
    select( Date,
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
            SurfaceWaterElev_m_levelNad83m ) -> riceclean
  
  # View the cleaned data
  return(riceclean)
  
}
