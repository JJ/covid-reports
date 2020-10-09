library(tibble)
library(dplyr)
library(anomalize)
load("covid-19-es.Rda")
data.with.f1 <- data[as.POSIXct(data$fecha) >= "2020-04-28" & as.POSIXct(data$fecha) <= "2020-06-21",]
hosp.t <- tibble(date=as.POSIXct(data.with.f1$fecha),value=data.with.f1$Hospitalizados.nuevos)
hosp.t$date <- as.Date(hosp.t$date)
hosp.t <- hosp.t %>% tibbletime::as_tbl_time(index = date)
hosp.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
hosp.t %>% time_decompose(value, frequency="2 weeks", trend = "2 weeks") %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
data.minus.1 <- data[-1,]
# In a single chart
library(RColorBrewer)
library(ggplot2)
library(ggthemes)
hosp.auto.d <- hosp.t %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()
ggplot(hosp.auto.d,aes(x=date))+geom_point(aes(y=observed, size=season))+geom_line(aes(y=trend,color=remainder,size=20,alpha=0.2))+ scale_color_distiller(palette="Spectral")+ theme_light()
ggplot(hosp.auto.d,aes(x=date))+geom_pointrange(aes(y=observed, ymin=observed-season, ymax=observed ))+geom_line(aes(y=trend,color=remainder,size=20,alpha=0.2))+ scale_color_distiller(palette="Spectral")+ theme_light()
ggplot(hosp.auto.d,aes(x=date))+geom_pointrange(aes(y=observed, ymin=observed-season, ymax=observed, color=season))+ geom_point(aes(y=trend, color="blue"))+geom_segment(aes(y=trend,yend=trend+remainder,xend=time,color=remainder))+scale_color_distiller(palette="Spectral")+ theme_light()
ggplot(hosp.auto.d,aes(x=date))+geom_point(aes(y=observed))+geom_point(aes(y=trend),shape=23,color="darkblue")+geom_linerange(aes(ymin=observed-season,ymax=observed, color=season),size=2)+ geom_linerange(aes(ymin=trend,ymax=trend+remainder,color=remainder),size=3,alpha=0.75)+scale_color_distiller(palette="Spectral")+ theme_light()
g <- ggplot(hosp.auto.d,aes(x=time))+geom_point(aes(y=observed))+geom_line(aes(y=trend+season))+geom_linerange(aes(ymin=observed-remainder,ymax=observed, color=remainder),size=2)+ geom_linerange(aes(ymin=trend,ymax=trend+season,color=season),size=3,alpha=0.75)+scale_color_distiller(palette="Spectral")+ theme_light()
g

# Rebrotes
data.with.f2 <- data[as.POSIXct(data$fecha) >= "2020-06-22",]
hosp.t2 <- tibble(date=as.POSIXct(data.with.f2$fecha),value=data.with.f2$Fallecimientos.nuevos)
hosp.t2$date <- as.Date(hosp.t2$date)
hosp.t2 <- hosp.t2 %>% tibbletime::as_tbl_time(index = date)
hosp.t2 %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
hosp.t2 %>% time_decompose(value, frequency="2 weeks", trend = "2 weeks") %>% anomalize(remainder) %>% time_recompose()%>% plot_anomaly_decomposition()
hosp.auto.d2 <- hosp.t2 %>% time_decompose(value) %>% anomalize(remainder) %>% time_recompose()
ggplot(hosp.auto.d2,aes(x=date))+geom_point(aes(y=observed))+geom_point(aes(y=trend),shape=23,color="darkblue")+geom_linerange(aes(ymin=observed-season,ymax=observed, color=season),size=2)+ geom_linerange(aes(ymin=trend,ymax=trend+remainder,color=remainder),size=3,alpha=0.75)+scale_color_distiller(palette="Spectral")+ theme_light()
