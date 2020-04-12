library(tibble)
library(dplyr)
library(anomalize)
load("covid-19-es.Rda")
data.with.f <- data[as.POSIXct(data$fecha) >= "2020-03-05",]
fallecimientos.t <- tibble(time=as.POSIXct(data.with.f$fecha),value=data.with.f$Fallecimientos.nuevos)
fallecimientos.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
casos.t <- tibble(time=as.POSIXct(data.with.f$fecha),value=data.with.f$Casos.nuevos)
casos.t %>% time_decompose(value,frequency='auto',trend='1 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
