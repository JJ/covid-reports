library(ggplot2)
library(gifski)
library(gganimate)

# With help from https://stackoverflow.com/questions/60827140/error-provided-file-does-not-exist-when-using-gganimate-with-lines/60909854#60909854

load("covid-19-es.Rda")

my_plot <- ggplot(data,aes(x = Fecha,y = Tasa.Hospitalizacion, color=total ))+
  geom_line() +
  transition_reveal(Fecha) +
  labs(title='Day: {frame_along}')

animate(
  plot = my_plot,
  render = gifski_renderer(),
  height = 800,
  width = 1200, 
  duration = 10,
  fps = 20)

anim_save('gifs/hospitalizaciones-animado.gif')
