#INSTRUCTIONAL CODE FOR MONROE WORK TODAY (auut studio) ETHICAL VISUALIZATIONS - DHSI - MAPPING PORTION
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH

setwd("D:/Users/Christopher/Dropbox/NDAD/DHSI/course-packet/datasets/monroe-work-today")

#Variables to set to explore how to visualize these data ethically
    border_color       = "black"      #what color to set the polygon boundaries
    fill_color         = "white"      #what color to set the polygon fill
    show_points        =  T           #show the point of lynching by county centroid
    point_color        = "black"      #what color do you want the points to be?
    point_size         =  1           #how big do you want the points to be?
    point_alpha        =  1           #set the point transparency from 0 to 1
    include_states     =  F           #set to T to include state boundaries
    aggregate_states   =  F           #set to T to aggregate lynchings by state (cloropleth)
    include_counties   =  F           #set to T to include county boundaries
    aggregate_counties =  F           #set to T to aggregate lynchings by county (cloropleth)
    color_ramp_strt    =  "red"
    color_ramp_end     =  "darkred"
    color_breaks       =  7           #number of color breaks
    scale_log10        =  F           #set the clorpleth scale to log10
    jitter             =  T           #jitter the points to avoid overlap, adds noise to data
#----------------------------------------------------------------------------------
#libraries
   library(ggplot2)
   library(maps)
#get data
   lynchings = read.csv("MWT_dataset_compilation_v1_0_ChurchHepworth.csv")
   county_centroids = read.csv("MonroeWorkToday_Counties_centroids.csv")
   merged_data = merge(lynchings,county_centroids, by="keyid",all.x="TRUE")
   #merged_data = read.csv("MWT_merged_centroids.csv") #uncomment this to speed things up, so you don't have to merge the tables every time
    
   #map data
   usa <- map_data("usa")
   if (include_states==T || aggregate_states==T) {states <- map_data("state")}
   if (include_counties==T || aggregate_counties==T) {counties <- map_data("county")}
   
   #merges
 
   #aggregate points by state
   if (aggregate_states==T) {
   names(state.abb) <- tolower(state.name) 
   states$state <- state.abb[states$region]
   aggstates <- aggregate(cbind(count = mwt_id) ~ state, 
                  data = merged_data, 
                  FUN = function(x){NROW(x)})
   states <- merge(states,aggstates,by="state",all.x=T)
   states <- states[order(states$order),]
   }
   #aggregate points by county
   if (aggregate_counties==T) {
   counties$county_id = paste0(tolower(state.abb[counties$region]),"s_",counties$subregion)
   aggcounties <- aggregate(cbind(count = mwt_id) ~ county_id, 
                          data = merged_data, 
                          FUN = function(x){NROW(x)})
   counties <- merge(counties,aggcounties,by="county_id",all.x=T)
   counties <- counties[order(counties$order),]
   }
      
#make base map
   g = ggplot() + 
      geom_polygon(data = usa, aes(x=long, y = lat, group = group),fill="white",color="black") +
      coord_fixed(1.3)
   #AGGREGATE STATES
   if (aggregate_states==T) {
     g = g + geom_polygon(data = states, aes(x = long, y = lat, group = group,fill=count), color = border_color) + coord_fixed(1.3)
     colfunc <- colorRampPalette(c(color_ramp_strt, color_ramp_end))
     g = g + scale_fill_gradientn(colours = rev(colfunc(color_breaks)),na.value=fill_color)
     if (scale_log10 == T) { 
       g = g + scale_fill_gradientn(colours = rev(colfunc(color_breaks)),na.value=fill_color,trans="log10")
     }
    } else if (include_states==T) { 
     g = g + geom_polygon(data = states, aes(x = long, y = lat, group = group), color = border_color,fill=fill_color) + 
       coord_fixed(1.3)  +  guides(fill=FALSE) 
    }
   #AGGREGATE COUNTIES
   if (aggregate_counties==T) {
     g = g + geom_polygon(data = counties, aes(x = long, y = lat, group = group,fill=count), color = border_color) + coord_fixed(1.3)
     colfunc <- colorRampPalette(c(color_ramp_strt, color_ramp_end))
     g = g + scale_fill_gradientn(colours = rev(colfunc(color_breaks)),na.value=fill_color)
     if (scale_log10 == T) { 
       g = g + scale_fill_gradientn(colours = rev(colfunc(color_breaks)),na.value=fill_color,trans="log10")
     }
   } else if (include_counties==T) { 
     g = g + geom_polygon(data = counties, aes(x = long, y = lat, group = group), color = border_color,fill=fill_color) + 
       coord_fixed(1.3)  +  guides(fill=FALSE) 
   }   
 
#add points
   if (show_points==T) { g = g + geom_point(data=merged_data,aes(x=lng_centroid,y=lat_centroid),color=point_color,size=point_size,alpha=point_alpha)}

#no overlap points
 if (jitter==T) { g = g + geom_jitter()}
      
#theme
  g = g + theme_bw()
#draw map
  g


