library(tidyverse)
library(ggplot2)

centro <- read.delim("https://openmobilitydata-data.s3-us-west-1.amazonaws.com/public/feeds/central-new-york-rta/524/20190826/original/shapes.txt", sep = ",")
centro %>%
  filter((shape_pt_lon < -76.075235) & (shape_pt_lon > -76.205754) & (shape_pt_lat > 42.989786) & (shape_pt_lat < 43.091508)) %>%
  ggplot(aes(shape_pt_lon, shape_pt_lat)) +
  geom_point(color = "steelblue") +
  coord_fixed(1.3)+
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
  
