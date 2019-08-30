-----------------------------------------------------------
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#DHSI - ETHICAL DATA VIZ
#SAMPLE CODE - BBC SNOW/ICE
-----------------------------------------------------------

# geom_bar is designed to make it easy to create bar charts that show
# counts (or sums of weights)
library(ggplot2)
library(grid)
library(gridExtra)

#VARIABLES to CHANGE

color1 = "darkgoldenrod1"
color2 = "darkred"
font_size = 18
ymax = 450
bar_width=0.5


#MPH30 -- TOP CHART
type=c("Normal","Snow and Ice")
distance_thinking=c(9,9)
distance_braking=c(14,140)

stopping.data <- data.frame(type,distance_thinking,distance_braking,stringsAsFactors=TRUE)

g1 <- ggplot(stopping.data, aes(x=type))

g1 = g1 + geom_col(aes(x=type, y=distance_braking,fill="Braking Distance"),width=bar_width)
g1 = g1 + geom_col(aes(x=type, y=distance_thinking,fill="Thinking Distance"),width=bar_width) 

g1 = g1 + coord_flip() + scale_fill_manual(values = c(color1,color2))

g1 = g1 + theme_minimal(base_size = font_size) 

g1 = g1 + theme(axis.title.x=element_blank(),
              axis.ticks.x=element_blank(),
              axis.title.y=element_blank(),
              legend.title = element_blank(),
              legend.position="top",
              legend.key.size = unit(1, 'cm'),
              legend.spacing.x = unit(0.5,'cm'),
              legend.text = element_text(margin = margin(r = 2, unit = 'cm')),
              plot.title = element_text(size = font_size*.7, face = "bold")
              )

g1 = g1 + ggtitle("30MPH") + scale_x_discrete(limits = rev(levels(stopping.data$type)))
g1 = g1 + ylim(0,ymax)

#MPH50 -- BOTTOM CHART
type=c("Normal","Snow and Ice")
distance_thinking=c(15,15)
distance_braking=c(38,380)

stopping.data <- data.frame(type,distance_thinking,distance_braking,stringsAsFactors=TRUE)

g2 <- ggplot(stopping.data, aes(x=type))

g2 = g2 + geom_col(aes(x=type, y=distance_braking,fill="Braking Distance"),width=bar_width)
g2 = g2 + geom_col(aes(x=type, y=distance_thinking,fill="Thinking Distance"),width=bar_width) 

g2 = g2 + coord_flip() + scale_fill_manual(values = c(color1, color2))

g2 = g2 + theme_minimal(base_size = font_size) 

g2 = g2 + theme(axis.title.x=element_blank(),
                axis.ticks.x=element_blank(),
                axis.text.x = element_text(color="white"),
                axis.title.y=element_blank(),
                legend.title = element_blank(),
                legend.position="none",
                plot.title = element_text(size = font_size*.7, face = "bold"))

g2 = g2 +  ggtitle("50MPH") + scale_x_discrete(limits = rev(levels(stopping.data$type)))

g2 = g2 + ylim(0,ymax)


#GET LEGEND
g_legend<-function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)}

mylegend<-g_legend(g1)


# PLOT in GRID
grid.arrange(mylegend,
             arrangeGrob(g1+ theme(legend.position="none"),g2),
             nrow=2,heights=c(1.5, 10),
             top=textGrob("Stopping Distances in Snow and Ice", gp=gpar(fontsize=25,font=8)),
             bottom=textGrob("Source: Gov UK, AA", gp=gpar(fontsize=10,font=8)))
