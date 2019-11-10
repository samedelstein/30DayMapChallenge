library(tidyverse)
library(ggplot2)
library(lubridate)
fire_incidents <- read.csv("Fire_Incidents.csv", stringsAsFactors = FALSE) %>%
  mutate(year = year(alarmdate)) %>%
  filter((Y < 50) & (X > -76.5) & (year == 2018))


ggplot(fire_incidents) +
  geom_point(aes(X, Y), color = "red", alpha = .2, size = 1) +
  coord_fixed(1.3)+
  theme(legend.position = "none",
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_rect(fill = "black",
                                        colour = "black",
                                        size = 0.5, linetype = "solid")) 
