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