library(tibble)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)

load("covid-19-es.Rda")
data$casos.ahora <- data$casos_total
data$casos <- NULL
data$fallecimientos.ahora <- data$fallecimientos
data$fallecimientos <- NULL
data$altas.ahora <- data$altas
data$altas <- NULL
old.data <- read.csv("https://raw.githubusercontent.com/datadista/datasets/master/COVID%2019/old_series/nacional_covid19_old.csv")
merged.data <- data %>% inner_join(old.data,by="fecha")
merged.data$diff.casos <- merged.data$casos.ahora - merged.data$casos
merged.data$fecha <- as.Date("%Y-%m-%d",fecha)
ggplot(merged.data, aes(x=fecha, y=diff.casos))+geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))

merged.data$diff.fallecimientos <- merged.data$fallecimientos.ahora - merged.data$fallecimientos

ggplot(merged.data, aes(x=fecha, y=diff.fallecimientos))+geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))

merged.data$diff.altas <- merged.data$altas.ahora - merged.data$altas
ggplot(merged.data, aes(x=fecha, y=diff.altas))+geom_point()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))

merged.data <- merged.data %>% mutate( nuevos.fallecimientos.ahora = fallecimientos.ahora - lag(fallecimientos.ahora,1,default=0))
merged.data <- merged.data %>% mutate( nuevos.fallecimientos.antes = fallecimientos - lag(fallecimientos,1,default=0))

diarios <- data.frame(fecha=merged.data$fecha,nuevos.fallecimientos.antes=merged.data$nuevos.fallecimientos.antes,nuevos.fallecimientos.ahora=merged.data$nuevos.fallecimientos.ahora)
diarios <- diarios %>% gather(Serie,nuevos.fallecimientos,nuevos.fallecimientos.antes,nuevos.fallecimientos.ahora)
ggplot(diarios, aes(x=fecha,y=nuevos.fallecimientos,group=Serie,color=Serie))+geom_point()+theme_tufte()




fallecimientos <- data.frame(fecha=merged.data$fecha,antiguos=merged.data$fallecimientos,nuevos=merged.data$fallecimientos.ahora)
fallecimientos <- fallecimientos %>% gather(Serie,fallecimientos,nuevos,antiguos)
ggplot(fallecimientos,aes(x=fecha,y=fallecimientos,group=Serie,color=Serie))+geom_line()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))
       

contagiados <- data.frame(fecha=merged.data$fecha,antiguos=merged.data$casos,nuevos=merged.data$casos.ahora)
contagiados <- contagiados %>% gather(Serie,contagiados,nuevos,antiguos)
ggplot(contagiados,aes(x=fecha,y=contagiados,group=Serie,color=Serie))+geom_line()+theme_tufte()+theme(axis.text.x = element_text(angle = 90))

