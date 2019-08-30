#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#BOILER PLATE CODE
#BAR PLOT
#DHSI

#LIBRARY
library(ggplot2)

#GET DATA FROM FLORIDA DEPARTMENT OF LAW ENFORCEMENT
df <- read.csv("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/gun-deaths_florida_full_1971-2016.csv",header=T,stringsAsFactors = F,as.is=T)

#INITIALIZE GRAPH
g <- ggplot(df)

#ADD BARS
g = g + geom_bar(aes(x=df$Year,y=df$Total_by_Firearm),fill="darkblue",color="black",stat="identity")

#ADD TITLES / CAPTIONS / LABELS
g = g + labs(title="Add title here",subtitle="Add subtitle here",caption="Add caption here")
g = g + xlab("X axis label")+ylab("Y Axis label")

#SHOW GRAPH
g