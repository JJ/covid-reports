library(tibble)
library(dplyr)
library(anomalize)
load("covid-19-es.Rda")
data.with.f <- data[as.POSIXct(data$fecha) >= "2020-03-05",]
fallecimientos.t <- tibble(time=as.POSIXct(data.with.f$fecha),value=data.with.f$Fallecimientos.nuevos)
fallecimientos.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
fallecimientos.t %>% time_decompose(value, frequency="2 weeks", trend = "2 weeks") %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
data.minus.1 <- data[-1,]
# In a single chart
library(RColorBrewer)
library(ggplot2)
library(ggthemes)
fallecimientos.auto.d <- fallecimientos.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()
ggplot(fallecimientos.auto.d,aes(x=time))+geom_point(aes(y=observed, size=season))+geom_line(aes(y=trend,color=remainder,size=20,alpha=0.2))+ scale_color_distiller(palette="Spectral")+ theme_light()
ggplot(fallecimientos.auto.d,aes(x=time))+geom_pointrange(aes(y=observed, ymin=observed-season, ymax=observed ))+geom_line(aes(y=trend,color=remainder,size=20,alpha=0.2))+ scale_color_distiller(palette="Spectral")+ theme_light()
ggplot(fallecimientos.auto.d,aes(x=time))+geom_pointrange(aes(y=observed, ymin=observed-season, ymax=observed, color=season))+ geom_pointrange(aes(y=trend,ymax=trend+remainder,ymin=trend,color=remainder,fatten=1,size=1))+scale_color_distiller(palette="Spectral")+ theme_light()
ggplot(fallecimientos.auto.d,aes(x=time))+geom_pointrange(aes(y=observed, ymin=observed-season, ymax=observed, color=season,fatten=1,size=1))+ geom_pointrange(aes(y=trend,ymax=trend+remainder,ymin=trend,color=remainder))+scale_color_distiller(palette="Spectral")+ theme_light()
casos.t <- tibble(time=as.POSIXct(data.minus.1$fecha),value=data.minus.1$Casos.nuevos)
casos.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
casos.t %>% time_decompose(value,frequency='auto',trend='1 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
casos.t %>% time_decompose(value,frequency='2 weeks',trend='2 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
# Altas
data.minus.16 <- data[as.POSIXct(data$fecha) > "2020-03-09",]
altas.t <- tibble(time=as.POSIXct(data.minus.16$fecha),value=data.minus.16$Altas.nuevas)
altas.t %>% time_decompose(value,frequency='auto',trend='1 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()

