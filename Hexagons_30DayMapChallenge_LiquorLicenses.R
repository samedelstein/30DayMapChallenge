library(tidyverse)
library('hexbin')
library(ggplot2)
library(ggmap)
library(viridis)

register_google(key = "API KEY HERE")

map <- get_googlemap(center = c(lon = -76.14, lat = 43.025),
                         zoom = 12, scale = 2, maptype = "roadmap", color = "bw")

liquor_licenses <- read.csv("Liquor_Authority_Quarterly_List_of_Active_Licenses.csv", stringsAsFactors = FALSE)
liquor_licenses_filtered <- liquor_licenses %>%
  filter((Latitude > 42.95) & (Longitude < -76.05) & (City == "SYRACUSE")) 

name <- data.frame(table(liquor_licenses_filtered$License.Type.Name)) %>%
  arrange(-Freq) %>%
  filter(Freq > 10)

ggmap(map, base_layer = ggplot(filter(liquor_licenses_filtered,License.Type.Name %in% name$Var1), aes(x=Longitude, y=Latitude))) +
  coord_cartesian() +
  geom_hex(alpha = .8, size = 1, bins = 50) +
  scale_fill_gradient(low = "black", high = "red") +
  coord_fixed(1.3) + theme(legend.position = "none",
                           axis.title.x = element_blank(),
                           axis.title.y = element_blank(),
                           axis.ticks = element_blank(),
                           panel.grid.major = element_blank(), 
                           panel.grid.minor = element_blank(),
                           panel.border = element_blank(),
                           axis.text.x=element_blank(),
                           axis.text.y=element_blank())
