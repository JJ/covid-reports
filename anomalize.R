library(tibble)
library(dplyr)
library(anomalize)
load("covid-19-es.Rda")
data.with.f1 <- data[as.POSIXct(data$fecha) >= "2020-03-05" & as.POSIXct(data$fecha) <= "2020-06-21",]
fallecimientos.t <- tibble(date=as.POSIXct(data.with.f1$fecha),value=data.with.f1$Fallecimientos.nuevos)
fallecimientos.t$date <- as.Date(fallecimientos.t$date)
fallecimientos.t <- fallecimientos.t %>% tibbletime::as_tbl_time(index = date)
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
ggplot(fallecimientos.auto.d,aes(x=time))+geom_pointrange(aes(y=observed, ymin=observed-season, ymax=observed, color=season))+ geom_point(aes(y=trend, color="blue"))+geom_segment(aes(y=trend,yend=trend+remainder,xend=time,color=remainder))+scale_color_distiller(palette="Spectral")+ theme_light()
ggplot(fallecimientos.auto.d,aes(x=time))+geom_point(aes(y=observed))+geom_point(aes(y=trend),shape=23,color="darkblue")+geom_linerange(aes(ymin=observed-season,ymax=observed, color=season),size=2)+ geom_linerange(aes(ymin=trend,ymax=trend+remainder,color=remainder),size=3,alpha=0.75)+scale_color_distiller(palette="Spectral")+ theme_light()
g <- ggplot(fallecimientos.auto.d,aes(x=time))+geom_point(aes(y=observed))+geom_line(aes(y=trend+season))+geom_linerange(aes(ymin=observed-remainder,ymax=observed, color=remainder),size=2)+ geom_linerange(aes(ymin=trend,ymax=trend+season,color=season),size=3,alpha=0.75)+scale_color_distiller(palette="Spectral")+ theme_light()
g
casos.t <- tibble(time=as.POSIXct(data.minus.1$fecha),value=data.minus.1$Casos.nuevos)
casos.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
casos.t %>% time_decompose(value,frequency='auto',trend='1 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
casos.t %>% time_decompose(value,frequency='2 weeks',trend='2 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
# Altas
data.minus.16 <- data[as.POSIXct(data$fecha) > "2020-03-09",]
altas.t <- tibble(time=as.POSIXct(data.minus.16$fecha),value=data.minus.16$Altas.nuevas)
altas.t %>% time_decompose(value,frequency='auto',trend='1 weeks') %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()

