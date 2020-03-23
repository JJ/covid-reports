library(ggplot2)
library(ggthemes)
library(gifski)
library(gganimate)

load("covid-19-es.Rda")
casos <- ggplot(data,aes(x=Fecha))+geom_point(aes(y=casos,color="Casos"))+geom_point(aes(y=salidas,color="Salidas"))+theme_tufte()+transition_states(Fecha,transition_length=2,state_length=1)+labs(title='Day: {frame_time}')
animate(casos, duration = 5, fps = 20, width =800, height = 600, renderer=gifski_renderer())
anim_save("casos.png")
