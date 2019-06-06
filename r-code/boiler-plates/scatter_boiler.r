#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#BOILER PLATE CODE
#SCATTER PLOT
#DHSI

#LIBRARY
library(ggplot2)

#GET DATA FROM FLORIDA DEPARTMENT OF LAW ENFORCEMENT
df <- read.csv("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/gun-deaths_florida_full_1971-2016.csv",header=T,stringsAsFactors = F,as.is=T)

#INITIALIZE GRAPH
g <- ggplot(df)

#DRAW POINTS
g = g + geom_point(aes(x=df$Year,y=df$Total_by_Firearm),color="black")

#DRAW LINES
g = g + geom_line(aes(x=df$Year,y=df$Total_by_Firearm),color="black")

#DRAW FILL
g = g + geom_ribbon(aes(x=df$Year,ymin=0,ymax=df$Total_by_Firearm),fill="gray",alpha=0.8)

#ADD TITLES / CAPTIONS / LABELS
g = g + labs(title="Add title here",subtitle="Add subtitle here",caption="Add caption here")
g = g + xlab("X axis label")+ylab("Y Axis label")

#SHOW GRAPH
g