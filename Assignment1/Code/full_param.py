from igraph import *
import numpy as np
import pandas as pd

#Read in the adjaceny matrix and convert it to a python list
data1 = np.loadtxt('adj_mat.csv',delimiter=',')
print data1.shape
adj = list()
for d in data1:
	adj.append(list(d))

g = Graph.Adjacency(adj)
apl = g.average_path_length()
print apl
di = g.diameter()
print di

