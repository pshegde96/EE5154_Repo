edge = read.csv("~/iit_acads/Sem5/Comlex_network/assgt1/CNA_Assgt1/adj_mat.csv", 
                header = F)

vert = read.csv("~/iit_acads/Sem5/Comlex_network/assgt1/CNA_Assgt1/node_list.csv",
                header = F)

edge = as.matrix(edge)

# Function to plot color bar
color.bar <- function(lut, min, max=-min, nticks=11, ticks=seq(min, max, len=nticks), title='') {
  scale = (length(lut)-1)/(max-min)
  
  dev.new(width=1.75, height=5)
  plot(c(0,10), c(min,max), type='n', bty='n', xaxt='n', xlab='', yaxt='n', ylab='', main=title)
  axis(2, ticks, las=1)
  for (i in 1:(length(lut)-1)) {
    y = (i-1)/scale + min
    rect(0,y,10,y+1/scale, col=lut[i], border=NA)
  }
}

maxN <- function(x, N=2){
  len <- length(x)
  if(N>len){
    warning('N greater than length(x).  Setting N=length(x)')
    N <- length(x)
  }
  sort(x,partial=len-N+1)[len-N+1]
}

maxN(1:10)

vert$V4 = vert$V1
vert$V1 = vert$V3
vert$V3 = vert$V4
vert = vert[ , c(1,2,3)]

library(igraph)
net = graph_from_adjacency_matrix(adjmatrix = edge, mode = c("undirected"),
                                  weighted = T)

E(net)$weight = runif(ecount(net))

#Color scaling function
c_scale <- colorRamp(c('yellow','goldenrod','orange','red', 'firebrick'))
E(net)$color = apply(c_scale(E(net)$weight), 1, function(x) rgb(x[1]/255,x[2]/255,x[3]/255) )


plot(net, edge.arrow.size=0.001, vertex.label=NA, main = "IITM Network",
     vertex.size=3, vertex.color = vert$V2, layout = layout.auto)



layouts <- grep("^layout\\.", ls("package:igraph"), value=TRUE) 
# Remove layouts that do not apply to our graph.
layouts <- layouts[!grepl("bipartite|merge|norm|sugiyama", layouts)]
layouts


#Plot of each dept 
dept = unique(vert$V2)
dept

names = c("Applied Mechanics", "Biotechnology", "Aerospace", "Chemical", "Chemistry", 
          "Civil", "Metallurgy", "Computer Science", "Engineering Design",
          "Electrical", "Engineering Physics", "Maths", "Mechanical", "Ocean Engineering")


count = 0
for(x in dept){
  count = count + 1
  subvert = vert[vert$V2==x,]$V1
  subedge = edge[subvert,subvert]
  
  net = graph_from_adjacency_matrix(subedge, weighted = T)
  
  E(net)$weight = runif(ecount(net))
  
  #Color scaling function
  c_scale <- colorRamp(c('yellow','goldenrod','orange','red', 'firebrick'))
    E(net)$color = apply(c_scale(E(net)$weight), 1, function(x) rgb(x[1]/255,x[2]/255,x[3]/255) )
  
  kN = maxN(degree(net), 1)
  print(kN)
  print(degree(net))
  
 # plot(net, edge.arrow.size=0.001,vertex.label.cex=0.8, vertex.label.color = "black",
  #     vertex.size=5, vertex.color = vert[vert$V2==x,]$V2, 
  #     vertex.label = ifelse(degree(net) >= kN, as.character(vert[vert$V2==x,]$V3), NA), 
  #     layout = layout.auto, main = names[count])
  plot(net, edge.arrow.size=0.001, vertex.size=5, vertex.color = vert[vert$V2==x,]$V2, 
       vertex.label = NA, layout = layout.auto, main = names[count])
}


for(x in dept){
  count = count + 1
  subvert = vert[vert$V2==x,]$V1
  subedge = edge[subvert,subvert]
  
  net = graph_from_adjacency_matrix(subedge, weighted = T)
  
  E(net)$weight = runif(ecount(net))
  
  #Color scaling function
  c_scale <- colorRamp(c('yellow','goldenrod','orange','red', 'firebrick'))
  E(net)$color = apply(c_scale(E(net)$weight), 1, function(x) rgb(x[1]/255,x[2]/255,x[3]/255) )
  
  kN = maxN(degree(net), 1)
  print(kN)
  print(degree(net))
  
  # plot(net, edge.arrow.size=0.001,vertex.label.cex=0.8, vertex.label.color = "black",
  #     vertex.size=5, vertex.color = vert[vert$V2==x,]$V2, 
  #     vertex.label = ifelse(degree(net) >= kN, as.character(vert[vert$V2==x,]$V3), NA), 
  #     layout = layout.auto, main = names[count])
  plot(net, edge.arrow.size=0.001, vertex.size=5, vertex.color = vert[vert$V2==x,]$V2, 
       vertex.label = NA, layout = layout.auto, main = names[count])
}
  

