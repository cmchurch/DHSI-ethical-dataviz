#INSTRUCTIONAL CODE FOR MONROE WORK TODAY (auut studio) ETHICAL VISUALIZATIONS - DHSI - OTHER PLOTS
#CHRISTOPHER CHURCH / KATHERINE HEPWORTH

#For these codes to work, please set the password provided by the instructors

password = ""

#variables
#----------------------------------------------------------------------------------------------------------

#chart type
plot_type          = "bar"              #what type of plot do you want to create?
                                        #[bar,scatter,pie,waffle]
#data range and axes
start_year         = 1803               #when to start mapping, default = 1803
end_year           = 2011               #when to end mapping, default = 2011
white_supremacy    = T                  #set to T to only include those that the dataset author concluded were incidents of white supremacy
x_axis             = "mwt_race"         #what do you want to tally?  [mwt_race,race_source,year_source,sex,alleged,mwt_alleged_category]
x_axis_color       = "black"            #what color do you want this to be? [hexidecimal ref or named color]
x_axis_size       = 0.1

#text labels, font weights, sizes, and colors
font
plot_title             = "Plot Title"
plot_title_size        = 10            #how big do you want the size of the title font? , default is 32
plot_title_font_face   = "plain"        #what font weight do you want this to be? [plain, italic, bold]
plot_title_color       = "black"       #what color do you want this to be? [hexidecimal ref or named color]
plot_subtitle          = "Subtitle"
plot_subtitle_size     = 10            #how big do you want the size of the subtitle font?, default is 22
plot_subtitle_font_face = "plain"       #what font weight do you want this to be? [plain, italic, bold]
plot_caption           = "Caption"
caption_size           = 10            #how big do you want the size of the caption font?, default is 10
caption_font_face      = "italic"        #what font weight do you want this to be? [plain, italic, bold]
caption_color         = "black"       #what color do you want this to be? [hexidecimal ref or named color]
x_label                = "Label"
y_label                = "Label"
label_size             = 10            #how big do you want the size of the axis label fonts?, default is 22
label_font_face        = "plain"      #what font weight do you want this to be? [plain, italic, bold]
#----------------------------------------------------------------------------------------------------------
#libraries
library(ggplot2)


#get data
lynchings = read.csv(url(paste("http://aLHuyQ6cqrYLMP2F:",password,"@files.ndadlab.org/MWT/MWT_dataset_compilation_v1_0_ChurchHepworth.csv",sep="")))
lynchings = lynchings [lynchings$year_source >= start_year &
                         lynchings$year_source <= end_year, ]
if (white_supremacy == T) {
  lynchings = lynchings [lynchings$mwt_white_supremacy == 1, ]
}
a = x_axis
b = "count"

agg <-
  aggregate(
    cbind(count = mwt_id) ~ lynchings[, a],
    data = lynchings,
    FUN = function(x) {
      NROW(x)
    }
  )

colnames(agg) <- c(a, b)

g <- ggplot(agg, aes_string(a, b))
if (plot_type == "bar") {
  g = g + geom_bar(stat = "identity")
}
if (plot_type == "scatter") {
  g = g + geom_line()
}
if (plot_type == "pie") {
  agg$percent = (agg[, b] / sum(agg[, b]) * 100)
  g = ggplot(agg, aes_string(x = 1, agg[, "percent"], fill = a)) + geom_bar(width =
                                                                              1, stat = "identity") + coord_polar("y", start = 0)
}
if (plot_type == "waffle") {
  agg$percent = (agg[, b] / sum(agg[, b]) * 100)
  ndeep <- 5 # How many rows do you want the y axis to have?
  agg[, a] <- as.character(agg[, a])
  waffles <-
    expand.grid(y = 1:ndeep, x = seq_len(ceiling(sum(agg$percent) / ndeep)))
  catvec <- rep(agg[, a], agg$percent)
  waffles$cat <- c(catvec, rep(NA, nrow(waffles) - length(catvec)))
  g = ggplot(waffles, aes(x = x, y = y, fill = cat)) +
    geom_tile(color = "white") # The color of the lines between tiles
  
}

#LABELS
g = g + labs(title = plot_title,
             subtitle = plot_subtitle,
             caption = plot_caption) +
  xlab(x_label) +
  ylab(y_label)

#COLOR AND THEME
g = g + theme_bw() + theme(
  plot.title = element_text(
        size = plot_title_size,
        face = plot_title_font_face,
        color = plot_title_color),
  plot.subtitle = element_text(
        size = plot_subtitle_size,
        face = plot_subtitle_font_face,
        color = plot_title_color),
  text = element_text(
        size = label_size,              
        face = label_font_face),
  plot.caption = element_text(
        size = caption_size,
        face = caption_font_face,
        color = caption_color),
  axis.text.x = element_text(angle = 45, hjust = 1),
  panel.grid.major.x = element_blank(),
  panel.grid.minor.x = element_blank(),
  panel.grid.major.y = element_line(size = x_axis_size, color = x_axis_color)
)
if (plot_type == "pie" || plot_type == "waffle") {
  g = g + theme(
    axis.ticks = element_blank(),
    axis.text.y = element_blank(),
    axis.text.x = element_blank()
  )
}
g
