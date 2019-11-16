library(sf)
library(tidyverse)
library(data.table)
library(viridis)
streets <- st_read("/Users/samedelstein/Downloads/Streets_shp/StreetSegment.shp")

place_streets <- streets %>%
  select(NYSStreetI, StreetName, PostType, Shape_Leng, geometry, LeftCounty) %>%
  filter(LeftCounty == 'Onondaga',
         PostType == "Pl")

non_place_streets <- streets %>%
  select(NYSStreetI, StreetName, PostType, Shape_Leng, geometry, LeftCounty) %>%
  filter(LeftCounty == 'Onondaga',
         PostType != "Pl")

ggplot() +
  geom_sf(data = place_streets, color = "red") +
  geom_sf(data = non_place_streets, color = "gray20") +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = 'black', colour = 'black')) 
