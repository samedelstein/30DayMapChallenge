library(readr)
library(ggplot2)
library(gganimate)
library(scales)
library(dplyr)
library(lubridate)
library(ggmap)
register_google(key = 'Your Key Here')
snowplow <- read.csv("Snowplow_Data_January_9_2018.csv", stringsAsFactors = FALSE)

snowplow$date_fixed <- ymd_hms(snowplow$date_fixed)
snowplow$hour_minute <- format(strptime(snowplow$date_fixed,'%Y-%m-%d %H:%M:%S'), '%Y-%m-%d %H:%M:00')
snowplow$hour_minute <- as.POSIXct(snowplow$hour_minute)
snowplow <- snowplow %>% group_by(truck_name) %>% mutate(id = row_number())
snowplow$id <- as.integer(snowplow$id)

truck254 <- filter(snowplow, truck_name == '254')
truck254$id <- as.integer(row.names(truck254))
syracuse.map <- get_map("Syracuse, NY", zoom = 12, maptype = "toner")

snowplow_animate <- ggmap(syracuse.map)+
  geom_point(data = snowplow, aes(x = longitude, y = latitude, color = as.factor(truck_name)),  alpha = .5) +
  theme(legend.position = "none",
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank()) +
  # gganimate code
  transition_time(id) +
  ease_aes("linear") +
  enter_fade() +
  exit_fade()

animate(snowplow_animate)
anim_save("Movement_30DayMapChallenge_snowplows.gif")
