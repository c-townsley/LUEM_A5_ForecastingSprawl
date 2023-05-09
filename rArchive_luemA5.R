#### R ARCHIVE ####
#LUEM Assignment 5 - Sprawl Forecasting
#Charlie and Lindsey


#### FOR RASTERS ####

#find their projection
st_crs(lc_2008)
st_crs(lc_2019)

#original raster projection is
rast_projection <- "+proj=tmerc +lat_0=30 +lon_0=-84.1666666666667 +k=0.9999 +x_0=700000 +y_0=0 +ellps=GRS80 +units=m +no_defs"

#set the original projection to the rasters
projection(lc_2008) <- rast_projection
projection(lc_2019) <- rast_projection

#re-project rasters to match msa shapefiles
lc_2008 <- projectRaster(lc_2008, crs = st_crs(metro_counties))
lc_2019 <- projectRaster(lc_2019, crs = st_crs(metro_counties))

#check new projections
st_crs(lc_2008)
st_crs(lc_2019)


#Half-finished Attempt at cropping new road predictions by county
ggplot() +
  geom_point(data=st_intersection(
    filter(metro_counties, NAME=="Walton"), dev_change_fishnet),
    aes(x=xyC(dev_change_fishnet)$x, y=xyC(dev_change_fishnet)$y, colour=development_change)) +
  scale_colour_manual(values = c(gray, "#ED7953FF"),
                      labels=c("No Change","New Development"),
                      name = "") +
  labs(title = "Land Cover Development Change",
       subtitle = "Atlanta metro area | Fishnet centroids with existing highways\nin dark blue and a new highway in cyan") +
  geom_sf(data=filter(metro_counties, NAME=="Walton"), fill=NA, colour="white", size=.75) +
  geom_sf(data=st_intersection(AtlantaHighways,
                               filter(metro_counties, NAME=="Walton")),
          linewidth=1,
          color = darkGray) +
  geom_sf(data=new_highway, colour="cyan", linewidth=1) +
  mapTheme