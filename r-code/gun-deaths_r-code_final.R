#INSTRUCTIONAL CODE FOR ETHICAL VISUALIZATIONS - DHSI
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#Gun deaths in Florida - Example

#-----------------------------------------------------------------------------------------------
#VARIABLES for you to CHANGE
plottype = "scatter"          #What type of graph do you want (options: "scatter" or "bar")
inverse_y_scale = F           #SET TO T TO INVERT THE Y-AXIS, SET F TO NOT INVERT
inverse_coords = F            #SET TO T TO INVERT THE X AND Y AXES
label_stand_your_ground = F   #SET TO T TO PLACE A LABEL WHEN STAND YOUR GROUND BEGAN in 2005
draw_scatter_line = F         #setting for scatter plot, set to T to draw line
draw_scatter_points=T         #setting for scater plot, set to T to draw points
draw_scatter_fill = F         #setting for scatter plot, 
fill_color = "darkred"        #color to fill the area for both scatter and box, suggest="darkred"
fill_transparency = 0.75      #scale of 0 to 1 (suggest 0.75), for both scatter and box
x_min = 1990                  #minimum year to show on x axis, default = 1990
x_max = 2015                  #maximum year to show on x axis, default = 2015
y_min = 0                     #mimumum number of deaths to show on y axis, default is zero
y_max = 1000                  #maximum number of deaths to show on y axis, default is 1000
plot_title_size = 32          #how big do you want the size of the title font? , default is 32
plot_subtitle_size = 22       #how big do you want the size of the subtitle font?, default is 22
caption_size=10               #how big do you want the size of the caption font?, default is 10
#VARIABLES FOR GRAPH LABELS
plot_title = "Gun Deaths in Florida"  #title of the Plot
plot_subtitle = "Number of murders committed using firearms"  #subtitle of plot
plot_caption = "SOURCE: Florida Department of Law Enforcement"
point_label = "2005\nFlorida enacted\nits 'Stand Your\nGround' law"
x_label = ""
y_label = ""
#-----------------------------------------------------------------------------------------------
#DATA FROM FLORIDA DEPARTMENT OF LAW ENFORCEMENT
deaths_by_year = c(873,806,789,800,739,687,668,634,589,460,499,502,552,586,555,521,740,825,780,695,669,691,721,696,690,767)
years = c(1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015)
df = do.call(rbind, Map(data.frame, YEAR=years, DEATHS=deaths_by_year))
#-----------------------------------------------------------------------------------------------
#GRAPH CODE
#------------------------------------------------------------------------------------------------
library(ggplot2)
#CREATE GRAPH
g <- ggplot(df,aes(x=YEAR,y=DEATHS))

if (plottype=="bar") {
#BAR CHART
g = g + geom_bar(stat="identity", fill=fill_color, alpha=fill_transparency)
} else if (plottype=="scatter") {
#SCATTERPLOT
if (draw_scatter_fill==T) {g = g + geom_ribbon(aes(ymin = y_min,ymax=DEATHS), fill=fill_color,alpha=fill_transparency)}
if (draw_scatter_line==T) {g = g + geom_line(size=2) }
if (draw_scatter_points==T) { g = g + geom_point(size=5) } 
} 
#SCALE 
g = g + coord_cartesian(ylim = c(y_min, y_max))
g = g + scale_x_continuous(limits = c(x_min,x_max),expand = c(0, 0))
if(inverse_y_scale==T) { g = g + scale_y_reverse(limits = c(y_max,0),expand = c(0, 0))
} else {g = g + scale_y_continuous(limits = c(0,y_max),expand = c(0, 0))}
#TITLES and LABELS
g = g + labs(title=plot_title,subtitle=plot_subtitle,caption=plot_caption)+xlab(x_label)+ylab(y_label)
deaths_syg = df$DEATHS[df$YEAR==2005]
if(label_stand_your_ground==T) {
  g = g + geom_text(data = df, aes(x = 2005, y = deaths_syg - 300, label = point_label),color="white",size=5,hjust=0)
  g = g + geom_segment(aes(x = 2005, y = deaths_syg-150, xend=2005, yend=deaths_syg-20),color="white",size=1)
}
#COLOR AND THEME
g = g + theme_bw() + theme(plot.title = element_text(size=plot_title_size),plot.subtitle = element_text(size=plot_subtitle_size),text = element_text(size=20),plot.caption=element_text(size=caption_size),axis.text.x = element_text(angle = 45, hjust = 1))
g = g + theme( panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank(),panel.grid.major.y = element_line( size=.1, color="black" ))
#COORD FLIP CHECK
if(inverse_coords==T) {g = g + coord_flip()}
g

