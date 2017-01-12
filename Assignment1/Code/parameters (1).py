from igraph import *
import numpy as np
import pandas as pd

#Read in the adjaceny matrix and convert it to a python list
data1 = np.loadtxt('adj_mat.csv',delimiter=',')
print data1.shape
adj = list()
for d in data1:
	adj.append(list(d))

#Read in the node list and store name and dept details
data2 = pd.read_csv('node_list.csv',header=None)
names = data2[0]
depts = data2[1]
deptlist = list(set(depts)) #List of unique departments
deptlabel = list() #Assign a label to each dept,used later to assign colors


for i in range(len(deptlist)):
	deptlabel.append(deptlist.index(depts[i]))
	indices = [j for j, x in enumerate(depts) if x == deptlist[i]]
	data_mini = data1[indices,:]
	data_mini = data_mini[:,indices]
	adj_mini = list()
	for d in data_mini:
		adj_mini.append(list(d))
	g = Graph.Adjacency(adj_mini)
	apl = g.average_path_length()
	print 'APL of {}:{}'.format(deptlist[i],apl)

for i in range(len(deptlist)):
	deptlabel.append(deptlist.index(depts[i]))
	indices = [j for j, x in enumerate(depts) if x == deptlist[i]]
	data_mini = data1[indices,:]
	data_mini = data_mini[:,indices]
	adj_mini = list()
	for d in data_mini:
		adj_mini.append(list(d))
	g = Graph.Adjacency(adj_mini)
	di = g.diameter()
	print 'Diameter of {}:{}'.format(deptlist[i],di)

for i in range(len(deptlist)):
	deptlabel.append(deptlist.index(depts[i]))
	indices = [j for j, x in enumerate(depts) if x == deptlist[i]]
	data_mini = data1[indices,:]
	data_mini = data_mini[:,indices]
	adj_mini = list()
	for d in data_mini:
		adj_mini.append(list(d))
	g = Graph.Adjacency(adj_mini)
	cc = g.transitivity_avglocal_undirected()
	print 'CC of {}:{}'.format(deptlist[i],cc)
