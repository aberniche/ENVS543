
getRicedata <- function() {
  
}


library( tidyverse )
url <- "https://docs.google.com/spreadsheets/d/1Mk1YGH9LqjF7drJE-td1G_JkdADOU0eMlrP01WFBT8s/pub?gid=0&single=true&output=csv"

read.csv( url ) -> rice


# make date objects
# make month & weekday objects
# convert f > c
# get rid of extra data
# reorder the columns
# return rice

