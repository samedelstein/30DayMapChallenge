library(censusapi)
library(ggplot2)
library(dplyr)
library(maptools)
library("gpclib")
library('rgdal')
library(scales)
require(sf)
library(tidyverse)
library(rvest)
Sys.setenv(CENSUS_KEY="INSERT API KEY")







theme_map <- function(...) {
  theme_minimal() +
    theme(
      text = element_text(family = "Arial", color = "#22211d"),
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      # panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.minor = element_blank(),
      plot.background = element_rect(fill = "#f5f5f2", color = NA), 
      panel.background = element_rect(fill = "#f5f5f2", color = NA), 
      legend.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.border = element_blank(),
      ...
    )
}

list.files('.', pattern='\\.shp$')
census_tracts <- readOGR(dsn=path.expand("."), "Census_Tracts_in_Syracuse_NY_2010")
census_tracts@data$id <- row.names(census_tracts@data)
map_data_fortified <- fortify(census_tracts) 
fortified_join <- merge(map_data_fortified, census_tracts@data, by="id")




poverty <- getCensus(name="acs/acs5", vintage=2017,
                     vars=c("NAME", "B01001_001E","B17001_001E", 'B17001_002E'), 
                     region="tract:*", regionin="state:36+county:067") %>%
  mutate(poverty_rate = round((B17001_002E/B17001_001E)*100),
         tractid = paste(state, county, tract, sep = ""))

internet <- getCensus(name="acs/acs5", vintage=2017,
                      vars=c("NAME", "B28002_001E","B28002_002E", 'B28002_007E'), 
                      region="tract:*", regionin="state:36+county:067") %>%
  rename("total_pop" = B28002_001E, "Internet" = B28002_002E, "Broadband" = B28002_007E) %>%
  mutate(year = "2017",
         percent_internet = round((Internet/total_pop)*100),
         percent_broadband = round((Broadband/total_pop)*100),
         tractid = paste(state, county, tract, sep = ""))


internetcensusmerge <- merge(fortified_join, internet, by.x = "GEOID10", by.y = "tractid")
internetcensusmerge <- internetcensusmerge[order(internetcensusmerge$order),]
internetcensusmerge$quartile <- with(internetcensusmerge, cut(percent_broadband, 
                                                              breaks=quantile(percent_broadband, probs=seq(0,1, by=0.2), na.rm=TRUE), 
                                                              include.lowest=TRUE))

internet_map <- ggplot() +
  geom_polygon(data = internetcensusmerge, aes(x = long, y = lat, group = group, fill = quartile), 
               color ="black", size = 0.25) +
  #geom_path(data = streets_data_fortified, aes(x = long, y = lat, group = group), alpha = .25, color = "black") + 
  coord_fixed(1.3) +
  scale_fill_manual(values = c("#e66101", "#fdb863", "#f7f7f7", "#b2abd2", "#5e3c99"),
                    name="Broadband Rate",
                    labels=c("20-43%", "44-53%", "54-62%", "63-69%", "70-87%"))+
  theme_map() +
  labs(title = "Broadband Rate by Census Tract (ACS 2017, 5-year survey)")
internet_map
