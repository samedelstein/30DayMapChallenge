library(sf)
library(tidyverse)
streets <- st_read("City_Streets_2011.shp")

no81 <- streets %>%
  filter(!grepl("I 81",BLKSTREET))
with81 <- streets %>%
  filter(grepl("I 81",BLKSTREET)) 

ggplot() +
  geom_sf(data = no81, color = "white") +
  geom_sf(data = with81, color = "gray40") + 
  theme(legend.position = "none",
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_rect(fill = "black",
                                        colour = "black",
                                        size = 0.5, linetype = "solid")) 
