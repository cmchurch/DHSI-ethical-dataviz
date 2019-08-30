#INSTRUCTIONAL CODE FOR FATAL ENCOUNTERS ETHICAL VISUALIZATIONS - DHSI - OTHER PLOTS
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH

#variables
#----------------------------------------------------------------------------------------------------------
start_year         = 2000               #when to start mapping, default = 2000
end_year           = 2018               #when to end mapping, default = 2018
x_axis             = "CAUSE.DEATH"      #what do you want to tally?  [CAUSE.DEATH,RACE,SEX,AGE,year]
plot_type          = "bar"              #what type of plot do you want to create?    [bar,scatter,pie,waffle,histogram]
plot_title_size    = 32                 #how big do you want the size of the title font? , default is 32
plot_subtitle_size = 22                 #how big do you want the size of the subtitle font?, default is 22
caption_size       = 10                 #how big do you want the size of the caption font?, default is 10
bin_width          = 10                 #how big do you want the bins (histogram only)
plot_title         = "Plot Title"
plot_subtitle      = "Subtitle"
plot_caption       = "Caption"
x_label            = ""
y_label            = ""
#----------------------------------------------------------------------------------------------------------
#libraries
library(ggplot2)
#encounters$Su

#get data
encounters = read.csv("http://files.ndadlab.org/fatal-encounters.csv",header=T,stringsAsFactors = F)
encounters = encounters[encounters$year>=start_year & encounters$year<=end_year,]

plot_type = tolower(plot_type)

a = x_axis
b = "count"

agg <- aggregate(cbind(count = UID) ~ encounters[,a], data = encounters, FUN = function(x){NROW(x)})

colnames(agg) <- c(a,b)

g <- ggplot(agg,aes_string(a,b))
if (plot_type=="bar") { g = g + geom_bar(stat="identity")}
if (plot_type=="scatter") {

  g = g + geom_line()}
if (plot_type=="pie") {
  agg$percent = (agg[,b]/sum(agg[,b])*100)
  g = ggplot(agg,aes_string(x=1,agg[,"percent"],fill=a)) + geom_bar(width=1,stat="identity") + coord_polar("y", start=0)
}
if (plot_type=="waffle") {
  agg$percent = (agg[,b]/sum(agg[,b])*100)
  ndeep <- 5 # How many rows do you want the y axis to have?
  agg[,a] <- as.character(agg[,a])
  waffles <- expand.grid(y = 1:ndeep,x = seq_len(ceiling(sum(agg$percent) / ndeep)))
  catvec <- rep(agg[,a], agg$percent)
  waffles$cat <- c(catvec, rep(NA, nrow(waffles) - length(catvec)))
  g = ggplot(waffles, aes(x = x, y = y, fill = cat)) + 
    geom_tile(color = "white") # The color of the lines between tiles
  
}
if (plot_type=="histogram") {
  g=qplot(as.numeric(encounters[,a]), geom="histogram",binwidth=bin_width)
}
#LABELS
g = g + labs(
   title=plot_title,
   subtitle=plot_subtitle,
   caption=plot_caption) +
   xlab(x_label) +
   ylab(y_label)

#COLOR AND THEME
g = g + theme_bw() + theme(
   plot.title = element_text(size=plot_title_size),
   plot.subtitle = element_text(size=plot_subtitle_size),
   text = element_text(size=20),
   plot.caption=element_text(size=caption_size),
   axis.text.x = element_text(angle = 45, hjust = 1),
   panel.grid.major.x = element_blank(),
   panel.grid.minor.x = element_blank(),
   panel.grid.major.y = element_line( size=.1, color="black" ))
if (plot_type=="pie"||plot_type=="waffle") {
    g = g + theme(
        axis.ticks = element_blank(),
        axis.text.y = element_blank(),
        axis.text.x = element_blank())}
g
