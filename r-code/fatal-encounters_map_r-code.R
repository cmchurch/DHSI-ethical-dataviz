#INSTRUCTIONAL CODE FOR FATAL ENCOUNTERS ETHICAL VISUALIZATIONS - DHSI - MAPPING PORTION
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#NOTE: Code only works for lower 48 states

setwd("C:/Users/Christopher/Dropbox/NDAD/DHSI/course-packet/datasets/")

#Variables to set to explore how to visualize these data ethically
start_year         = 2000         #when to start mapping, default = 2000
end_year           = 2018         #when to end mapping, default = 2018
border_color       = "black"      #what color to set the polygon boundaries
fill_color         = "white"      #what color to set the polygon fill
show_points        =  T           #show the point of encounter
point_color        = "black"      #what color do you want the points to be?
point_size         =  0.5         #how big do you want the points to be?
point_alpha        =  1           #set the point transparency from 0 to 1
include_states     =  F           #set to T to include state boundaries
aggregate_states   =  T           #set to T to aggregate encounters by state (cloropleth) - only works lower 48
color_ramp_strt    =  "red"
color_ramp_end     =  "darkred"
color_breaks       =  7           #number of color breaks
scale_log10        =  F           #set the clorpleth scale to log10
jitter             =  T           #jitter the points to avoid overlap, adds noise to data
title_size         = 32
subtitle_size      = 22
caption_size       = 12
map_title          = "Title"
map_subtitle       = "Subtitle"
map_caption        = "Caption"
legend_title       = "Legend"
#----------------------------------------------------------------------------------
#libraries
library(ggplot2)
library(maps)
#library(fiftystater)
#get data
encounters = read.csv("fatal-encounters.csv",header=T,stringsAsFactors = F)
encounters = encounters[encounters$year>=start_year & encounters$year<=end_year,]
encounters = encounters[encounters$LOCATION.STATE!="AK",]
encounters = encounters[encounters$LOCATION.STATE!="HI",]
#map data
usa <- map_data("usa")
#usa <- map_data("world", c("USA", "hawaii"), xlim = c(-180, -65), ylim = c(19, 72))

if (include_states==T || aggregate_states==T) {states <- map_data("state")}

#merges

#aggregate points by state
if (aggregate_states==T) {
  names(state.abb) <- tolower(state.name) 
  states$state <- state.abb[states$region]
  aggstates <- aggregate(cbind(count = UID) ~ LOCATION.STATE, 
                         data = encounters, 
                         FUN = function(x){NROW(x)})
  states <- merge(states,aggstates,by.x=c("state"),by.y=c("LOCATION.STATE"),all.x=T)
  states <- states[order(states$order),]
  aggregate_data=states
}

#make base map
g = ggplot() + 
  geom_polygon(data = usa, aes(x=long, y = lat, group = group),fill="white",color="black") +
  coord_fixed(1.3)
#AGGREGATE CHLOROPLETH
if (aggregate_states==T) {
  g = g + geom_polygon(data = aggregate_data, aes(x = long, y = lat, group = group,fill=count), color = border_color) + coord_fixed(1.3)
  colfunc <- colorRampPalette(c(color_ramp_strt, color_ramp_end))
  g = g + scale_fill_gradientn(name=legend_title,colours = rev(colfunc(color_breaks)),na.value=fill_color)
  if (scale_log10 == T) { 
    g = g + scale_fill_gradientn(name=legend_title,colours = rev(colfunc(color_breaks)),na.value=fill_color,trans="log10")
  }
} else if (include_states==T) { 
  g = g + geom_polygon(data = states, aes(x = long, y = lat, group = group), color = border_color,fill=fill_color) + 
    coord_fixed(1.3)  +  guides(fill=FALSE) 
}

#add points
if (show_points==T) { g = g + geom_point(data=encounters,aes(x=Longitude,y=Latitude),color=point_color,size=point_size,alpha=point_alpha)}

#no overlap points
if (jitter==T) { g = g + geom_jitter()}

#theme
g = g + theme_bw() + theme(plot.title = element_text(size=title_size),plot.subtitle = element_text(size=subtitle_size),text = element_text(size=20),plot.caption=element_text(size=caption_size))

#labels
g = g + labs(title=map_title,subtitle=map_subtitle,caption=map_caption)
#draw map
g


