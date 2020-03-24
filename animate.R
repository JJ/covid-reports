library(ggplot2)
library(transformr)
library(gifski)
library(gganimate)
library(tidyr)

load("covid-19-es.Rda")
data <- gather(data,Tipo,Cuantos,c(casos,salidas))

ggplot(data,aes(x = Fecha, y = Cuantos, group= Tipo, color=Tipo)) + 
  geom_line() +
  labs(title='Day: {closest_state}')

my_plot <- ggplot(data,aes(x = Fecha, y = Cuantos, group= Tipo, color=Tipo)) + 
  geom_line() +
  transition_reveal(Fecha) + ease_aes("linear")+
  labs(title='Day: {closest_state}')

animate(
  plot = my_plot,
  render = gifski_renderer(),
  height = 600,
  width = 800, 
  duration = 10,
  fps = 20)

anim_save('gifs/casos-salidas-linea.gif')
