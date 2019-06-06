#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#BOILER CODE
#GROUPED BAR CHART WITH AGGREGATION

library(ggplot2)
library(reshape2)

password=""
lynchings = read.csv(url(paste("http://aLHuyQ6cqrYLMP2F:",password,"@files.ndadlab.org/MWT/MWT_dataset_compilation_v1_0_ChurchHepworth.csv",sep="")))

agg = dcast(lynchings, mwt_race ~ sex)

agg_reshaped <- melt(agg, id.vars='mwt_race')

g <- ggplot(agg_reshaped,aes(x=mwt_race,y=value))
g = g + geom_bar(aes(fill=variable),
                 stat="identity",
                 width = 0.4, 
                 position = position_dodge(width=0.5))
g
