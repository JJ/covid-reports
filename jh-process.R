library(dplyr)
library(stringr)
library(RCurl)

raw.world.confirmed <- getURL("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv")
raw.world.confirmed <- str_replace_all(raw.world.confirmed, '\'', '')
world.confirmed <- read.table(text = raw.world.confirmed, sep=',',head=T)
