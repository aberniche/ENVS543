#Factors Homework

#Change the order of the weekdays to start with Monday. Add two additional factor columns: Weekday/Weekend based on the day of the week. Create a column based on the *four primary lunar phases* for the data collected. \[Superstar Question\] Create a column that indicates whether the tide is coming in (Incoming) or going out (Outgoing).

#Upload a markdown document summarizing these changes in the Rice Rivers Center data set using tables or graphs or some other manner that demonstrates you made the changes.


library(tidyverse)
library(ggplot2)
library(forcats)
source("getricedata.R")
data <- getricedata()



Data <- data |>
  mutate(Weekday = fct_relevel(Weekday, c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")))
  
Data |>
  ggplot( aes (x = Weekday)) + geom_bar() +
  labs(title = "Frequency of Weekdays", y = "Frequency")


#Add two additional factor columns:
#Weekday/Weekend based on the day of the week.



rice <- Data %>%
  mutate(Weekday_Weekend = case_when(
    Weekday %in% c("Sat", "Sun") ~ "Weekend",
    TRUE ~ "Weekday"
  )) %>%
  mutate(Weekday_Weekend = fct_relevel(Weekday_Weekend, "Weekday", "Weekend"))


table <- table(rice$Weekday, rice$Weekday_Weekend)


print(table)



#Create a column based on the *four primary lunar phases* for the data collected.


library(lunar)

rice <- rice %>%
  mutate(Date = as.Date(Date, format = "%Y-%m-%d"))

rice <- rice %>%
  mutate(LunarPhaseValue = lunar.phase(Date, name = FALSE)) %>%  
  mutate(LunarPhase = case_when(
    LunarPhaseValue <= 0.1 ~ "New Moon",
    LunarPhaseValue <= 0.4 ~ "First Quarter",
    LunarPhaseValue <= 0.6 ~ "Full Moon",
    LunarPhaseValue <= 0.9 ~ "Last Quarter",
    TRUE ~ "New Moon"
  ))

print(rice)


lunar_phase_summary <- rice %>%
  group_by(LunarPhase) %>%
  summarise(Count = n()) %>%
  arrange(desc(Count))

print(lunar_phase_summary)



#Create a column that indicates whether the tide is coming in (Incoming) or going out (Outgoing).


tide <- Data %>%
  arrange(Date) %>%
  mutate(Tide_Status = case_when(
    Depth_m > lag(Depth_m, default = first(Depth_m)) ~ "Incoming",
    Depth_m < lag(Depth_m, default = first(Depth_m)) ~ "Outgoing",
    TRUE ~ NA_character_
  )) %>%
  filter(!is.na(Tide_Status)) %>%  # Remove NA values
  mutate(Tide_Status = fct_infreq(Tide_Status))  # Convert to factor based on frequency


tide_summary <- tide %>%
  count(Tide_Status)


print(tide_summary)


#Is it true? The world may never know.
