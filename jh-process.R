library(tidyr)


base <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-"
#raw.world.confirmed <- getURL("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv")
#raw.world.confirmed <- str_replace_all(raw.world.confirmed, '\'', '')
world.confirmed <- read.csv(paste0(base,"Confirmed.csv"), sep=',',head=T)
world.confirmed <- gather( world.confirmed, Date, Cases, X1.22.20:X3.20.20)
world.deaths <- read.csv(paste0(base,"Deaths.csv"), sep=',',head=T)
world.deaths <- gather( world.deaths, Date, Deaths, X1.22.20:X3.20.20)
world.data <- merge(world.confirmed,world.deaths,by=c("Province.State","Country.Region","Lat", "Long", "Date"))
world.data$Date <- as.Date(world.data$Date,"X%m.%d.%y")
save(world.data,file="covid19-world.Rda")
write.csv(world.data,'covid19-world.csv')
