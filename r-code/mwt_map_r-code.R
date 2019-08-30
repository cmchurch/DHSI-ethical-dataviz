#INSTRUCTIONAL CODE FOR MONROE WORK TODAY (auut studio) ETHICAL VISUALIZATIONS - DHSI - MAPPING PORTION
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH

#For these codes to work, please set the password provided by the instructors

password = ""

#Variables to set to explore how to visualize these data ethically

#data range
start_year         = 1803         #when to start mapping, default = 1803
end_year           = 2011         #when to end mapping, default = 2011
white_supremacy    = F            #set to T to only include those that the dataset author concluded were incidents of white supremacy

#plot type settings
show_points        =  T           #show the point of lynching by county centroid
include_states     =  F           #set to T to include state boundaries
aggregate_states   =  F           #set to T to aggregate lynchings by state (cloropleth)
include_counties   =  F           #set to T to include county boundaries
aggregate_counties =  F           #set to T to aggregate lynchings by county (cloropleth)
jitter             =  F           #jitter the points to avoid overlap, adds noise to data

#colors
border_color       = "black"      #what color to set the polygon boundaries
fill_color         = "white"      #what color to set the polygon fill
point_color        = "black"      #what color do you want the points to be?
point_size         =  1           #how big do you want the points to be?
point_alpha        =  1           #set the point transparency from 0 to 1
color_ramp_strt    =  "grey"
color_ramp_end     =  "black"
color_breaks       =  7           #number of color breaks
scale_log10        =  F           #set the clorpleth scale to log10
title_color        = "black"
subtitle_color     = "black"
text_color         = "black"
caption_color      = "black"

#Fonts, titles, captions
title_size         = 10
subtitle_size      = 10
caption_size       = 10
map_title          = "Title"
map_subtitle       = "Subtitle"
map_caption        = "Caption"
legend_title       = "Legend Title"
title_face         = "plain"      #options: plain, bold, bold-italic, italic
subtitle_face      = "plain"      #options: plain, bold, bold-italic, italic
caption_face       = "plain"      #options: plain, bold, bold-italic, italic
global_font_face   = "plain"      #set the global font face
font_size          = 10           #set the global font size
x_label            = ""
y_label            = ""

filter_by_alleged  = F
alleged            = c("Arson","Incendiarism")

#----------------------------------------------------------------------------------
#libraries
library(ggplot2)
library(maps)

#get data
lynchings = read.csv(url(paste("http://aLHuyQ6cqrYLMP2F:",password,"@files.ndadlab.org/MWT/MWT_dataset_compilation_v1_0_ChurchHepworth.csv",sep="")))
lynchings = lynchings [lynchings$year_source >= start_year &
                         lynchings$year_source <= end_year,] 
if (filter_by_alleged==T) { lynchings = lynchings[lynchings$alleged==alleged, ] }
if (white_supremacy == T) {
  lynchings = lynchings [lynchings$mwt_white_supremacy == 1, ]
}
county_centroids = read.csv(url(paste("http://aLHuyQ6cqrYLMP2F:",password,"@files.ndadlab.org/MWT/MonroeWorkToday_Counties_centroids.csv",sep="")))
merged_data = merge(lynchings, county_centroids, by = "keyid", all.x =
                      "TRUE")
#merged_data = read.csv(url(paste("http://aLHuyQ6cqrYLMP2F:",password,"@files.ndadlab.org/MWT/MWT_merged_centroids.csv",sep=""))) #uncomment this to speed things up, so you don't have to merge the tables every time


#map data
usa <- map_data("usa")
if (include_states == T ||
    aggregate_states == T) {
  states <- map_data("state")
}
if (include_counties == T ||
    aggregate_counties == T) {
  counties <- map_data("county")
}

#merges

#aggregate points by state
if (aggregate_states == T) {
  names(state.abb) <- tolower(state.name)
  states$state <- state.abb[states$region]
  aggstates <- aggregate(
    cbind(count = mwt_id) ~ state,
    data = merged_data,
    FUN = function(x) {
      NROW(x)
    }
  )
  states <- merge(states, aggstates, by = "state", all.x = T)
  states <- states[order(states$order), ]
  aggregate_data = states
}
#aggregate points by county
if (aggregate_counties == T) {
  names(state.abb) <- tolower(state.name)
  counties$county_id = paste0(tolower(state.abb[counties$region]), "s_", counties$subregion)
  aggcounties <- aggregate(
    cbind(count = mwt_id) ~ county_id,
    data = merged_data,
    FUN = function(x) {
      NROW(x)
    }
  )
  counties <- merge(counties, aggcounties, by = "county_id", all.x = T)
  counties <- counties[order(counties$order), ]
  aggregate_data = counties
}

#make base map
g = ggplot() +
  geom_polygon(
    data = usa,
    aes(x = long, y = lat, group = group),
    fill = fill_color,
    color = "black"
  ) +
  coord_fixed(1.3)
#AGGREGATE CHLOROPLETH
if (aggregate_states == T || aggregate_counties == T) {
  g = g + geom_polygon(data = aggregate_data,
                       aes(
                         x = long,
                         y = lat,
                         group = group,
                         fill = count
                       ),
                       color = border_color) + coord_fixed(1.3)
  colfunc <- colorRampPalette(c(color_ramp_strt, color_ramp_end))
  g = g + scale_fill_gradientn(name = legend_title,
                               colours = rev(colfunc(color_breaks)),
                               na.value = fill_color)
  if (scale_log10 == T) {
    g = g + scale_fill_gradientn(
      name = legend_title,
      colours = rev(colfunc(color_breaks)),
      na.value = fill_color,
      trans = "log10"
    )
  }
} else if (include_states == T) {
  g = g + geom_polygon(
    data = states,
    aes(x = long, y = lat, group = group),
    color = border_color,
    fill = fill_color
  ) +
    coord_fixed(1.3)  +  guides(fill = FALSE)
}

#add points
if (show_points == T) {
  g = g + geom_point(
    data = merged_data,
    aes(x = lng_centroid, y = lat_centroid),
    color = point_color,
    size = point_size,
    alpha = point_alpha
  )
}

#no overlap points
if (jitter == T) {
  g = g + geom_jitter()
}

#theme
g = g + theme_bw() + theme(
  plot.title = element_text(
    size = title_size,
    face=title_face,
    color=title_color),
  plot.subtitle = element_text(
    size = subtitle_size,
    face=subtitle_face,
    color=subtitle_color),
  text = element_text(
    size = font_size,
    face=global_font_face,
    color=text_color),
  plot.caption = element_text(
    size = caption_size,
    face=caption_face,
    color=caption_color),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.text = element_blank(),
  panel.border=element_blank(),
  axis.ticks= element_blank()
)

#labels
g = g + labs(title = map_title,
             subtitle = map_subtitle,
             caption = map_caption)
g = g + xlab(x_label) + ylab(y_label)
#draw map
g