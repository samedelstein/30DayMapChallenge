library(raster)
library(rasterVis)
library(sf)
library(ggplot2)


DEM = raster('/Users/samedelstein/Downloads/p30elu.dem') #import raster file
DEM1 = raster('/Users/samedelstein/Downloads/p29elu.dem')
DEM = rasterToPoints(DEM) #change raster to matrix object with coordinates
DEM = data.frame(DEM) #change matrix to data.frame object
DEM1 = rasterToPoints(DEM1) #change raster to matrix object with coordinates
DEM1 = data.frame(DEM1) 

#assign the DEM elevation values to class intervals
DEM$p30elu = cut(DEM$p30elu,breaks=c(0,25,50,75,100,125,150,175,200,225,250,275,300,325)) #here you'll want to create classes with intervals of 10 meters.
DEM1$p29elu = cut(DEM1$p29elu,breaks=c(0,25,50,75,100,125,150,175,200,225,250,275,300,325)) #here you'll want to create classes with intervals of 10 meters.

#Plot raster

ggplot() +
  geom_tile(data=DEM,aes(x=x,y=y,fill=p30elu)) + 
  geom_tile(data=DEM1,aes(x=x,y=y,fill=p29elu)) + 
  scale_fill_brewer("Elevation (m)", type = "seq", palette = "BuGn") +
  xlab("Meters") + ylab("Meters") +
  theme_bw() + 
  coord_equal() + 
  theme(legend.position = "none",
                        axis.title.x = element_blank(),
                        axis.title.y = element_blank(),
                        axis.ticks = element_blank(),
                        panel.grid.major = element_blank(), 
                        panel.grid.minor = element_blank(),
                        panel.border = element_blank(),
                        axis.text.x=element_blank(),
                        axis.text.y=element_blank())
