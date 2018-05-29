#INSTRUCTIONAL CODE FOR MONROE WORK TODAY (auut studio) ETHICAL VISUALIZATIONS - DHSI - MAPPING PORTION
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH

setwd("D:/Users/Christopher/Dropbox/NDAD/DHSI/course-packet/datasets/monroe-work-today")

#Variables to set to explore how to visualize these data ethically
    start_year         = 1803         #when to start mapping, default = 1803
    end_year           = 2011         #when to end mapping, default = 2011
    white_supremacy    = F            #set to T to only include those that the dataset author concluded were incidents of white supremacy 
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
    title_size         = 32
    subtitle_size      = 22
    caption_size       = 12
    map_title          = "Title"
    map_subtitle       = "Subtitle"
    map_caption        = "Caption"
    legend_title       = "Lynchings"
#----------------------------------------------------------------------------------
#libraries
   library(ggplot2)
   library(maps)
#get data
   lynchings = read.csv("MWT_dataset_compilation_v1_0_ChurchHepworth.csv")
   lynchings = lynchings [lynchings$year_source>=start_year & lynchings$year_source<=end_year,]
   if (white_supremacy==T) {lynchings = lynchings [lynchings$mwt_white_supremacy==1,]}
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
   aggregate_data=states
   }
   #aggregate points by county
   if (aggregate_counties==T) {
   names(state.abb) <- tolower(state.name) 
   counties$county_id = paste0(tolower(state.abb[counties$region]),"s_",counties$subregion)
   aggcounties <- aggregate(cbind(count = mwt_id) ~ county_id, 
                          data = merged_data, 
                          FUN = function(x){NROW(x)})
   counties <- merge(counties,aggcounties,by="county_id",all.x=T)
   counties <- counties[order(counties$order),]
   aggregate_data=counties
   }
      
#make base map
   g = ggplot() + 
      geom_polygon(data = usa, aes(x=long, y = lat, group = group),fill="white",color="black") +
      coord_fixed(1.3)
   #AGGREGATE CHLOROPLETH
   if (aggregate_states==T || aggregate_counties==T) {
 
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
   if (show_points==T) { g = g + geom_point(data=merged_data,aes(x=lng_centroid,y=lat_centroid),color=point_color,size=point_size,alpha=point_alpha)}

#no overlap points
 if (jitter==T) { g = g + geom_jitter()}
      
#theme
  g = g + theme_bw() + theme(plot.title = element_text(size=title_size),plot.subtitle = element_text(size=subtitle_size),text = element_text(size=20),plot.caption=element_text(size=caption_size))
  
#labels
  g = g + labs(title=map_title,subtitle=map_subtitle,caption=map_caption)
#draw map
  g


