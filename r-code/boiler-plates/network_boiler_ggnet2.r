#CHRISTOPHER CHURCH / KATHERINE HEPWORTH
#SAMPLE CODE / R
#DHSI


#GET NECESSARY LIBRARIES
library(network) #for more, see https://rdrr.io/cran/network/man/network-package.html
library(ggplot2)
library(sna)
library(GGally) #for more, see https://briatte.github.io/ggnet/

#GET DATA
edge_list = read.csv(url("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/sample_network_edges.csv"),header = TRUE, stringsAsFactors = F)
node_list = read.csv(url("https://github.com/cmchurch/DHSI-ethical-dataviz/raw/master/public_data/sample_network_nodes.csv"), header = TRUE, stringsAsFactors = F)

#INITIALIZE NETWORK
net = network(edge_list,node_list,matrix.type="edgelist",directed=FALSE,ignore.eval=FALSE)

#LIST NETWORK ATTRIBUTES
#list.edge.attributes(net)
#list.vertex.attributes(net)

#GRAPH USING GGNET2
ggnet2(net, 
       mode = "fruchtermanreingold",
       size="degree",
       max_size = 20,
       label=TRUE,
       label.color="orange",
       node.color="black",
       edge.color="gray",
       edge.size="WEIGHT"
       )

