library(sf)
library(tidyverse)
library(viridis)
streets <- st_read("/Users/samedelstein/Downloads/Streets_shp/StreetSegment.shp")

streets_filtered <- streets %>%
  select(NYSStreetI, StreetName, PostType, Shape_Leng, geometry, LeftCounty) %>%
  filter(LeftCounty == 'Onondaga',
         !is.na(PostType)) %>%
  mutate(color = case_when(PostType == "Rd" ~ "Rd",
                   PostType == "St" ~ "St",
                   PostType == "Dr" ~ "Dr",
                   PostType == "Ave" ~ "Ave",
                   PostType == "Ln" ~ "Ln",
                   TRUE ~ "Other"))
streets_filtered %>% group_by(PostType) %>% tally(sort = TRUE) 

ggplot(streets_filtered) +
  geom_sf(aes(color = color)) +
  scale_color_viridis(discrete = TRUE) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        panel.background = element_rect(fill = 'black', colour = 'black')) 

