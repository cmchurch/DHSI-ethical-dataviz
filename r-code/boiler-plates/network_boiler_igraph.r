#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#IGRAPH

#tutorial: http://www.kateto.net/wp-content/uploads/2015/06/Polnet%202015%20Network%20Viz%20Tutorial%20-%20Ognyanova.pdf

#get libraries
library(igraph)

#GET DATA
edge_list = read.csv(url("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/sample_network_edges.csv"),header = TRUE, stringsAsFactors = F)
node_list = read.csv(url("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/sample_network_nodes.csv"), header = TRUE, stringsAsFactors = F)

#SET UP NETWORK
net <- graph.data.frame(edge_list, node_list, directed=T)

#calculate the network degree
deg <- degree(net, mode="all")

#NODE ATTRIBUTES
V(net)$size <- deg * 3               #set the size of the vertices to degree (scaled by 3)
V(net)$label <- V(net)$vertex.names  #set the label to the vertex.names column

#EDGE ATTRIBUTES
E(net)$arrow.size <- .2              #set the arrow size
E(net)$edge.color <- "gray80"        #set the edge color  
E(net)$width <- E(net)$WEIGHT        #set the edge weight

#PLOT THE GRAPH
plot(net,
     edge.arrow.size=.4,
     layout=layout.fruchterman.reingold)