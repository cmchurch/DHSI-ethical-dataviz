#INSTRUCTIONAL CODE FOR CA INCOME INEQUALITY - DHSI - MAPPING PORTION
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH

border_color       = "black"      #what color to set the polygon boundaries
fill_color         = "white"      #what color to set the polygon fill
color_ramp_style   =  "continuous"    #continuous or divergent
color_ramp_strt    =  "blue"
color_ramp_middle  =  "white"
color_ramp_end     =  "green"
color_breaks       =  7           #number of color breaks
title_size         = 32
subtitle_size      = 22
caption_size       = 12
map_title          = "Title"
map_subtitle       = "Subtitle"
map_caption        = "Caption"
legend_title       = "Legend"


library(maps)

income_data = read.csv("http://files.ndadlab.org/income-inequality.csv",header=T,stringsAsFactors = F)
income_data$county_name = tolower(income_data$county_name)
counties = map_data("county")
counties_ca = subset(counties, region == "california")

aggregate_income_by_county<- aggregate(cbind(average = Gini_index) ~ county_name, 
                       data = income_data, 
                       FUN = mean)


counties_ca = merge(counties_ca,aggregate_income_by_county,by.x="subregion",by.y="county_name",all.x=T)


g <- ggplot(data = counties_ca, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")


g = g + geom_polygon(data = counties_ca, aes(x = long, y = lat, group = group,fill=average), color = border_color) + coord_fixed(1.3)

if (color_ramp_style=="continuous") {colfunc <- colorRampPalette(c(color_ramp_strt, color_ramp_end))
} else { colfunc <- colorRampPalette(c(color_ramp_strt, color_ramp_middle, color_ramp_end)) }
g = g + scale_fill_gradientn(name=legend_title,colours = rev(colfunc(color_breaks)),na.value=fill_color)


#theme
g = g + theme_bw() + theme(plot.title = element_text(size=title_size),plot.subtitle = element_text(size=subtitle_size),text = element_text(size=20),plot.caption=element_text(size=caption_size))

#labels
g = g + labs(title=map_title,subtitle=map_subtitle,caption=map_caption)
#draw map
g