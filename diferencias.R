library(tibble)
library(dplyr)
library(tidyr)
library(anomalize)
load("covid-19-es.Rda")
old.data <- read.csv("https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/old_series/nacional_covid19_old.csv")
merged.data <- data %>% inner_join(old.data,by="fecha")
merged.data$diff.casos <- merged.data$casos_total - merged.data$casos.x
merged.data$diff.fallecimientos <- merged.data$fallecimientos.y - merged.data$fallecimientos.x
merged.data$fecha <- as.Date("%Y-%m-%d",fecha)
ggplot(merged.data, aes(x=fecha, y=diff.fallecimientos))+geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))
merged.data$diff.casos <- merged.data$casos.y - merged.data$casos_total
ggplot(merged.data, aes(x=fecha, y=diff.casos))+geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))
merged.data$diff.altas <- merged.data$altas.y - merged.data$altas.x
ggplot(merged.data, aes(x=fecha, y=diff.altas))+geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))
fallecimientos <- data.frame(fecha=merged.data$fecha,antiguos=merged.data$fallecimientos.y,nuevos=merged.data$fallecimientos.x)
fallecimientos <- fallecimientos %>% gather(Serie,fallecimientos,nuevos,antiguos)
ggplot(fallecimientos,aes(x=fecha,y=fallecimientos,group=Serie,color=Serie))+geom_line()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))
       
contagiados <- data.frame(fecha=merged.data$fecha,antiguos=merged.data$casos.y,nuevos=merged.data$casos_total)
contagiados <- contagiados %>% gather(Serie,contagiados,nuevos,antiguos)
ggplot(contagiados,aes(x=fecha,y=contagiados,group=Serie,color=Serie))+geom_line()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))

contagiados.diff <- data.frame(fecha=merged.data$fecha,diferencia=merged.data$casos.y-merged.data$casos_total)
