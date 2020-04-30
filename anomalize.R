library(tibble)
library(dplyr)
library(anomalize)
load("covid-19-es.Rda")
data.with.f <- data[as.POSIXct(data$fecha) >= "2020-03-05",]
fallecimientos.t <- tibble(time=as.POSIXct(data.with.f$fecha),value=data.with.f$Fallecimientos.nuevos)
fallecimientos.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
fallecimientos.t %>% time_decompose(value, frequency="2 weeks", trend = "2 weeks") %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
data.minus.1 <- data[-1,]
casos.t <- tibble(time=as.POSIXct(data.minus.1$fecha),value=data.minus.1$Casos.nuevos)
casos.t %>% time_decompose(value,frequency='auto',trend='1 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
casos.t %>% time_decompose(value,frequency='2 weeks',trend='2 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
# Altas
data.minus.16 <- data[as.POSIXct(data$fecha) > "2020-03-09",]
altas.t <- tibble(time=as.POSIXct(data.minus.16$fecha),value=data.minus.16$Altas.nuevas)
altas.t %>% time_decompose(value,frequency='auto',trend='1 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
