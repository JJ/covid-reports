library(ggplot2)
library(gifski)
library(gganimate)
library(ggrepel)

# Done with help from here https://stackoverflow.com/questions/54855334/gganimate-time-series-and-two-line-plot

load("covid-19-es.Rda")

my_plot <- ggplot(data,aes(x = Fecha,y = Déficit, color=casos ))+
  geom_point(size = 7) +
  scale_fill_gradient(name = "count", trans = "log") +
  shadow_wake(wake_length = 0.1, alpha = FALSE) +
  geom_label_repel(aes(label = sprintf("%5d", total), hjust=0)) +
  transition_states(Fecha, transition_length = 2, state_length = 1) +
  labs(title='Día: {closest_state}')

animate(
  plot = my_plot,
  render = gifski_renderer(),
  height = 600,
  width = 800, 
  duration = 10,
  fps = 20)

anim_save('gifs/déficit-point.gif')
