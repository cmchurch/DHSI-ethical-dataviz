#-----------------------------------------------------------------------------------------------

# ABOUT THIS FILE

# INSTRUCTIONAL ACTIVITY CODE 
# ACTIVITY NAME: Gun deaths in Florida
# COPYRIGHT: CC-BY
# PREPARED FOR COURSE: Ethical Data Visualization: Taming Treacherous Data
# HELD AT EVENT: Digital Humanities Summer Institute (DHSI)
# LOCATION OF EVENT: University of Victoria, British Columbia, CANADA
# AUTHORS: 
# Christopher Church (http://christophermchurch.com/) / Katherine Hepworth (https://kathep.com)

#-----------------------------------------------------------------------------------------------

# INSTRUCTIONS

# Any line starting with '#' is a comment. This is code that provides you with information, 
# but does not tell R to do anything. To change the appearance of the plot, read comments,
# and change text below.

#-----------------------------------------------------------------------------------------------

#VARIABLES for you to CHANGE

draw_scatter_line = T         #setting for scatter plot, set to T to draw line
draw_scatter_points=F         #setting for scater plot, set to T to draw points
draw_scatter_fill = F         #setting for scatter plot, 
fill_color = "Yellow"   #color to fill the area for both scatter and box, suggest="darkred"
fill_transparency = 0.75      #scale of 0 to 1 (suggest 0.75), for both scatter and box
point_size = 1                #how big do you want the size of the size of the points?, default is 1
line_width = 1                #how big do you want the size of the line width?, default is 1

#-----------------------------------------------------------------------------------------------

# 1. CALLING THE TABLE

# The below line 'calls' a table, or data frame (df stands for Data Frame) 
# sourced from the FLORIDA DEPARTMENT OF LAW ENFORCEMENT.
df <- read.csv("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/gun-deaths_florida_full_1971-2016.csv",
    header=T,stringsAsFactors = F,as.is=T)

#-----------------------------------------------------------------------------------------------

# 2. CALLING THE GRAPHIC LIBRARY

# The below line calls the graphic library ggplot2. 
# This is the standard charting library for use in R.
library(ggplot2)

#------------------------------------------------------------------------------------------------

# 3. SELECTING SPECIFIC DATA REPRESENTED IN THE TABLE

# The below line specifies which column appears on the x axis.
X=df$Year
# The below line specifies which column appears as a line of data.
Y=df$Total_Murders
# The below line specifies which column appears as a line of data.
#Y2=df$Total_Handgun

#################################################################################
#                                                                               #
#    THINGS TO EXPERIMENT WITH IN THIS SECTION                                  #
#  - Change the font size and weight of the title, subtitle, caption            #
#    and axes text.                                                             #
#    in the environment window.                                                 #
#  - Decide which columns of data would you want to represent.                  #
#  - Change which data appears on your chart by changing the column selected    #
#    after the $ in X or Y above.                                               #
#    NOTE: Column titles are case sensitive!                                    #
#  - Add a new line of data by removing the # infront of Y2 and changing        #
#    the column name after the $. Then remove the # infront of the geom_line    #
#    call further down in the code.                                             #
#                                                                               #
#################################################################################

#------------------------------------------------------------------------------------------------

# 4. DRAWING A CHART (EITHER LINE OR BAR) & PUTTING DATA INTO IT

# giving the future blank chart a name 'g', and calling ggplot
g <- ggplot(
  #referring the plot to data from the data frame 'df' specified above
  df,aes(
    #referring the x axis to 'X' specified above
    x=X,
    #referring the y axis to 'Y' specified above
    y=Y+Y2,
    test
    ))

#------------------------------------------------------------------------------------------------

# 5. SELECT TYPE OF CHART (BAR OR LINE)

#What type of graph do you want (options: "line" or "bar")
plottype = "line"             

if (plottype=="bar") {
  #BAR CHART
  g = g + 
    #drawing a bar chart
    geom_bar(stat="identity", 
             #add a color block between data line and lowest axis
             fill=fill_color, alpha=fill_transparency)
  } 
else if (plottype=="line") {
  #LINE CHART
  if (draw_scatter_fill==T) {
     g = g + 
       #specifying the start and end years of data represented
       geom_ribbon(aes(ymin = y_min,ymax=Y), 
       fill=fill_color,
       alpha=fill_transparency)
     }
  if (draw_scatter_line==T) {
     g = g + 
       geom_line(size=line_width) 
     }
  if (draw_scatter_points==T) { 
     g = g + 
       geom_point(size=point_size) 
     } 
} 

#------------------------------------------------------------------------------------------------

# 6. SETTING THE SCALES OF THE AXES

y_min = 0
y_max = 2500

# specifying y axis scale 
g = g + coord_cartesian(ylim = c(
    #setting the lower limit of the y axis
    #NOTE: 0 is most ethical most of the time
    y_min, 
    #setting the upper limit of the y axis
    y_max))

# specifying year range on the x axis
g = g + scale_x_continuous(limits = c(
    #setting the beginning year of the x axis
    2000,
    #setting the beginning year of the x axis
    2015),
    expand = c(0, 0))

#################################################################################
#                                                                               #
#    THINGS TO EXPERIMENT WITH IN THIS SECTION                                  #
#  - Shorten the year range on the x axis by changing years listed above.       #
#  - Change the height of the y axis by changing the upper limit listed above.  #
#                                                                               #
#################################################################################

#------------------------------------------------------------------------------------------------

# 7. ADDING THE TEXT LABELS

point_label = "Title"

#TITLES and LABELS
g = g + labs(
    #title of the Plot
    title="Title",
    #subtitle of plot
    subtitle="Subtitle",
    caption="Caption")+
    #label of x axis
    xlab("X Label")+
    #label of y axis
    ylab("Y Label")

deaths_syg = df$Total_by_Firearm[df$Year==2005]

label_stand_your_ground = F   #SET TO T TO PLACE A LABEL WHEN STAND YOUR GROUND BEGAN in 2005
if(label_stand_your_ground==T) {
  g = g + geom_text(data = df, aes(x = 2005, y = deaths_syg - 300, label = point_label),color="white",size=5,hjust=0)
  g = g + geom_segment(aes(x = 2005, y = deaths_syg-150, xend=2005, yend=deaths_syg-20),color="white",size=1)
}

#################################################################################
#                                                                               #
#    THINGS TO EXPERIMENT WITH IN THIS SECTION                                  #
#  - Changing the title and subtitle.                                           #
#  - Changing the text labels.                                                  #
#  - Adding a data caption.                                                     #
#                                                                               #
#################################################################################

#------------------------------------------------------------------------------------------------

# 8. SPECIFYING FONT APPEARANCES AND STYLES

g = g + theme_bw() + 
  theme(
    #setting the font for the all text on your chart 
    #[options: Helvetica, Arial, Arial Narrow, Times New Roman]
    base_family = "Helvetica",
    base_size = 15,
    #setting the title visual elements 
    #(font size = size; font weight = face; )
    #[options: "plain", "italic", "bold", "bold.italic"]; leading = lineheight; 
    #vertical spacing before [t] and after [b])
    plot.title = element_text(size=15, lineheight = 80, ),
    plot.subtitle = element_text(size=12, lineheight = 80),
    text = element_text(size=15),
    plot.caption = element_text(size=40),
    axis.text.x = element_text(angle = 45, hjust = 1))
g = g + theme( 
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line( size=.1, color="black" ))

#------------------------------------------------------------------------------------------------

# 9. SPECIFYING DATA APPEARANCES AND STYLES



#------------------------------------------------------------------------------------------------

# 9. DARK ARTS - USE AT YOUR OWN PERIL!

inverse_y_scale = F           #SET TO T TO INVERT THE Y-AXIS, SET F TO NOT INVERT

# Option to flip the Y axis (for evil purposes) by changing F to T below
inverse_coords = F            
if(inverse_coords==T) {g = g + coord_flip()}

if(inverse_y_scale==T) { g = g + scale_y_reverse(limits = c(y_max,0),expand = c(0, 0))
} else {g = g + scale_y_continuous(limits = c(0,y_max),expand = c(0, 0))}

#################################################################################
#                                                                               #
#    THINGS TO EXPERIMENT WITH IN THIS SECTION                                  #
#  - Inverting the y axis coordinates (for no good reason).                     #
#                                                                               #
#################################################################################

#------------------------------------------------------------------------------------------------

# 10. ADDING EXTRA LINES FOR DATA INTO THE CHART

g = g + geom_line(aes(x=X,y=Y,color="Total Murders"))
#g = g + geom_line(aes(x=X,y=Y2,color="Murders with Handgun"))

#################################################################################
#                                                                               #
#    THINGS TO EXPERIMENT WITH IN THIS SECTION                                  #
#  - Change the legend labels to reflect the data you selected at the start.    #
#  - Uncomment the line above containing Y2 (if you want a second line of data. #
#                                                                               #
#################################################################################


#------------------------------------------------------------------------------------------------

# 10. TELLING R TO DRAW EVERYTHING YOU JUST SPECIFIED

# the final 'g' runs the plot
g
