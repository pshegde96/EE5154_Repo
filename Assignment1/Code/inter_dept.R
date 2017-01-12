edge = read.csv("~/iit_acads/Sem5/Comlex_network/assgt1/CNA_Assgt1/parsing/inter_dept_adj.csv", 
                header = F)

vert = read.csv("~/iit_acads/Sem5/Comlex_network/assgt1/CNA_Assgt1/parsing/inter_dept_node.csv",
                header = F)

vert$V3 = vert$V1
vert$V1 = vert$V2
vert$V2 = vert$V3
vert = vert[ , c(1,2)]
library(igraph)

edge = as.matrix(edge)
net = graph_from_adjacency_matrix(adjmatrix = edge, mode = c("undirected"),weighted = T)

E(net)$weight = runif(ecount(net))

#Color scaling function
c_scale <- colorRamp(c('yellow','goldenrod','orange','red', 'firebrick'))
E(net)$color = apply(c_scale(E(net)$weight), 1, function(x) rgb(x[1]/255,x[2]/255,x[3]/255) )


names = c("Applied Mechanics", "Biotechnology", "Aerospace", "Chemical", "Chemistry", 
          "Civil", "Computer Science", "Engineering Design",
          "Electrical", "Engineering Physics", "Maths" ,"Mechanical" , "Metallurgy", "Ocean Engineering")


plot(net, edge.arrow.size=0.001, vertex.label=as.character(names), 
     vertex.label.color = 'black', vertex.label.dist = 0.4,
     main = "Inter dept",
     vertex.size=10, vertex.color = vert$V2, layout = layout.auto)
degree(net)
vert
