library(ggplot2)
library(gifski)
library(gganimate)

load("covid-19-es.Rda")
data$total <- data$casos - data$salidas

my_plot <- ggplot(data,aes(x = Fecha,y = total ))+
  geom_point(size = 5) +
  transition_states(Fecha, transition_length = 2, state_length = 1) +
  labs(title='Day: {closest_state}')

animate(
  plot = my_plot,
  render = gifski_renderer(),
  height = 600,
  width = 800, 
  duration = 5,
  fps = 20)

anim_save('gifs/totales-point.gif')
