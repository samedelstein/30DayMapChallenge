library(sf)
library(tidyverse)
water <- st_read("hydrology.shp")

ggplot() +
  geom_sf(data = water, color = "blue") +
  theme(legend.position = "none",
                                                panel.grid = element_blank(),
                                                axis.title = element_blank(),
                                                axis.text = element_blank(),
                                                axis.ticks = element_blank(),
                                                panel.background = element_rect(fill = "black",
                                                                                colour = "black",
                                                                                size = 0.5, linetype = "solid")) 

