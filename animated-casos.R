library(ggplot2)
library(gifski)
library(gganimate)

# Done with help from here https://stackoverflow.com/questions/54855334/gganimate-time-series-and-two-line-plot

load("covid-19-es.Rda")
data$total <- data$casos - data$salidas

my_plot <- ggplot(data,aes(x = Fecha,y = total ))+
  geom_point(size = 5, color="blue") +
  geom_segment(aes(xend=max(Fecha), yend = total), linetype=2, colour='pink') +
  geom_text(aes(x = max(Fecha)+.1, label = sprintf("%5d", total), hjust=0)) +
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
