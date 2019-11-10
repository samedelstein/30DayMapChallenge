library(sf)
library(tidyverse)
parcels <- st_read("4-10-2018.shp")

parks <- parcels %>%
  filter(LUCODE %in% c(960, 961,962,963))
other_parcels <- parcels %>%
  filter(!LUCODE %in% c(960, 961,962,963))

ggplot() +
  geom_sf(data = parks, fill = "green") +
  geom_sf(data = other_parcels, fill = "gray20") + 
  theme(legend.position = "none",
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_rect(fill = "black",
                                        colour = "black",
                                        size = 0.5, linetype = "solid")) 

