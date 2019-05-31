#INSTRUCTIONAL CODE FOR ETHICAL VISUALIZATIONS - DHSI
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#Gun deaths in Florida - Example

#-----------------------------------------------------------------------------------------------
#VARIABLES for you to CHANGE
plottype = "scatter"          #What type of graph do you want (options: "scatter" or "bar")
inverse_y_scale = T           #SET TO T TO INVERT THE Y-AXIS, SET F TO NOT INVERT
inverse_coords = F            #SET TO T TO INVERT THE X AND Y AXES
label_stand_your_ground = F   #SET TO T TO PLACE A LABEL WHEN STAND YOUR GROUND BEGAN in 2005
draw_scatter_line = F         #setting for scatter plot, set to T to draw line
draw_scatter_points=T         #setting for scater plot, set to T to draw points
draw_scatter_fill = F         #setting for scatter plot, 
fill_color = "AntiqueWhite"   #color to fill the area for both scatter and box, suggest="darkred"
fill_transparency = 0.75      #scale of 0 to 1 (suggest 0.75), for both scatter and box
x_min = 1990                  #minimum year to show on x axis, default = 1990
x_max = 2015                  #maximum year to show on x axis, default = 2015
y_min = 0                     #mimumum number of deaths to show on y axis, default is zero
y_max = 1000                  #maximum number of deaths to show on y axis, default is 1000
plot_title_size = 10          #how big do you want the size of the title font? , default is 10
plot_subtitle_size = 10       #how big do you want the size of the subtitle font?, default is 10
caption_size=10               #how big do you want the size of the caption font?, default is 10
text_size = 10                #how big do you want the size of the text (including axis values)?, default is 10
point_size = 1                #how big do you want the size of the size of the points?, default is 1
line_width = 1                #how big do you want the size of the line width?, default is 1
#VARIABLES FOR GRAPH LABELS
plot_title = "Title"  #title of the Plot
plot_subtitle = "Subtitle"  #subtitle of plot
plot_caption = "Caption"
point_label = "Title"
x_label = "X Label"
y_label = "Y Label"
#-----------------------------------------------------------------------------------------------
#DATA FROM FLORIDA DEPARTMENT OF LAW ENFORCEMENT
df <- read.csv("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/gun-deaths_florida_full_1971-2016.csv",header=T,stringsAsFactors = F)
#-----------------------------------------------------------------------------------------------
#GRAPH CODE
#------------------------------------------------------------------------------------------------
library(ggplot2)
#CREATE GRAPH
g <- ggplot(df,aes(x=Year,y=Total_by_Firearm))

if (plottype=="bar") {
#BAR CHART
g = g + geom_bar(stat="identity", fill=fill_color, alpha=fill_transparency)
} else if (plottype=="scatter") {
#SCATTERPLOT
if (draw_scatter_fill==T) {g = g + geom_ribbon(aes(ymin = y_min,ymax=Total_by_Firearm), fill=fill_color,alpha=fill_transparency)}
if (draw_scatter_line==T) {g = g + geom_line(size=line_width) }
if (draw_scatter_points==T) { g = g + geom_point(size=point_size) } 
} 
#SCALE 
g = g + coord_cartesian(ylim = c(y_min, y_max))
g = g + scale_x_continuous(limits = c(x_min,x_max),expand = c(0, 0))
if(inverse_y_scale==T) { g = g + scale_y_reverse(limits = c(y_max,0),expand = c(0, 0))
} else {g = g + scale_y_continuous(limits = c(0,y_max),expand = c(0, 0))}
#TITLES and LABELS
g = g + labs(title=plot_title,subtitle=plot_subtitle,caption=plot_caption)+xlab(x_label)+ylab(y_label)
deaths_syg = df$Total_by_Firearm[df$Year==2005]
if(label_stand_your_ground==T) {
  g = g + geom_text(data = df, aes(x = 2005, y = deaths_syg - 300, label = point_label),color="white",size=5,hjust=0)
  g = g + geom_segment(aes(x = 2005, y = deaths_syg-150, xend=2005, yend=deaths_syg-20),color="white",size=1)
}
#COLOR AND THEME
g = g + theme_bw() + theme(plot.title = element_text(size=plot_title_size),plot.subtitle = element_text(size=plot_subtitle_size),text = element_text(size=text_size),plot.caption=element_text(size=caption_size),axis.text.x = element_text(angle = 45, hjust = 1))
g = g + theme( panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),panel.grid.major.y = element_line( size=.1, color="black" ))
#COORD FLIP CHECK
if(inverse_coords==T) {g = g + coord_flip()}
g

