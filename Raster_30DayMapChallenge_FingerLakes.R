library(raster)
library(rgdal)
library(rgeos)
library(RColorBrewer)
library(sp)
library(ggplot2)
library(viridis)
library(rasterVis)


options(stringsAsFactors = FALSE)

finger_lakes <- raster('L1C_T18TUN_A013565_20191011T160358.tif')
b1 <- raster('L1C_T18TUN_A013565_20191011T160358.tif', band=1)
b2 <- raster('L1C_T18TUN_A013565_20191011T160358.tif', band=2)
b3 <- raster('L1C_T18TUN_A013565_20191011T160358.tif', band=3)



t <- stack(b1,b2, b3)
gplot(t) +
  geom_raster(aes(x = x, y = y, fill = value))+
  scale_fill_viridis_c() +
  facet_wrap(~variable) +
  coord_quickmap()+
  theme_classic() +
  theme(text = element_text(size=20),
        axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(legend.position = "none",
        panel.grid = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.background = element_blank(),
        plot.title = element_blank(),
        strip.background = element_blank(),
        strip.text.x = element_blank())
