library(ggplot2)
library(viridis)

code_violations <- read.csv("/Users/samedelstein/Downloads/Code_violations.csv")

ggplot(code_violations, aes(long, lat, color = property_neighborhood)) +
  geom_point(alpha = .5, size = 1) +
  coord_fixed(1.3) +
  scale_color_viridis(discrete = TRUE) +
  theme(legend.position = "none",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = 'black', colour = 'black')) 
