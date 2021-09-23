inst_pack_func <- function(list.of.packages){
  new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  if(length(new.packages)) install.packages(new.packages)
  lapply(list.of.packages,function(x){library(x,character.only=TRUE)})
}

list.of.packages <- c("tidyverse","magrittr",
                      "rvest","xml2","leaflet",
                      "maps","mapdata","RgoogleMaps",
                      "rworldmap","dplyr,ggplot2")

inst_pack_func(list.of.packages)

##Akaryakıt maps
gas_station <- read.csv("Akaryakıt.csv")
kadıköy_gas_station <- gas_station %>% filter(COUNTY_NAME == "KADIKÖY")


leafIcons <- makeIcon(
  iconUrl = 'https://cdn-icons-png.flaticon.com/512/846/846347.png'
  ,
  iconWidth = 14, iconHeight = 17,
  iconAnchorX  =14, iconAnchorY = 20 
)

kadıköy_gas_station%>% 
  leaflet() %>% 
  addProviderTiles("Esri") %>% 
  addMarkers(~LONGTITUDE, ~LATITUDE,
             label = ~FUEL_DISTRIBUTION_COMPANY_DESC,
             popup = paste0(
               "<b>Fuel Name: </b>",
               kadıköy_gas_station$FUEL_DISTRIBUTION_COMPANY_DESC,
               "<br>",
               "<b>Neighborhood Name: </b>",
               kadıköy_gas_station$NEIGHBORHOOD_NAME),
             icon = leafIcons) %>% 
  setView(lng = median(kadıköy_gas_station$LONGTITUDE),
          lat = median(kadıköy_gas_station$LATITUDE),
          zoom = 10)


  

  
  
  
  