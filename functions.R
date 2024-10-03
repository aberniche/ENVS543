# Ashley Berniche Rice Rivers Dataset

library(tidyverse)
library(lubridate)

getricedata <- function() {
  
  url <- "https://docs.google.com/spreadsheets/d/1Mk1YGH9LqjF7drJE-td1G_JkdADOU0eMlrP01WFBT8s/pub?gid=0&single=true&output=csv"

rice <- read.csv(url)

# Convert DateTime to character (if necessary) and make it a proper date-time object
rice$DateTime <- as_datetime(rice$DateTime)  # Assuming DateTime is in a compatible format

# Create Month, Day, and Weekday columns, and convert Fahrenheit to Celsius
rice <- rice %>%
  mutate(
    Month = factor(month(DateTime, label = TRUE, abbreviate = TRUE)),
    Day = day(DateTime),
    Weekday = factor(wday(DateTime, label = TRUE, abbreviate = TRUE), levels = wday(1:7, label = TRUE, abbreviate = TRUE)),
    AirTempC = (AirtempF - 32) / 1.8  # Correct the temperature conversion formula
  )

# Select only relevant columns (don't forget to add commas between column names and close parentheses)
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
  )

# View the cleaned data
view(riceclean)

}
