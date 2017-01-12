# coding: utf-8
import numpy as np
import pandas as pd
import networkx as nx

#Read in the adjaceny matrix and convert it to a python list
data1 = np.loadtxt('adj_mat.csv',delimiter=',')
adj = list()
for d in data1:
    adj.append(list(d))

#Read in the node list and store name and dept details
data2 = pd.read_csv('node_list.csv',header=None)
names = data2[0]
depts = data2[1]
deptlist = list(set(depts)) #List of unique departments
deptlabel = list() #Assign a label to each dept,used later to assign colors

#Finding average CC of the graph
    
for i in range(len(deptlist)):
    deptlabel.append(deptlist.index(depts[i]))
    indices = [j for j, x in enumerate(depts) if x == deptlist[i]]
    data_mini = data1[indices,:]
    data_mini = data_mini[:,indices]
    G=nx.from_numpy_matrix(data_mini)
    cc=nx.average_clustering(G)
    print 'CC of {} is: {}'.format(deptlist[i],cc)

#Finding the largest subcomponent of the graph    
for i in range(len(deptlist)):
    deptlabel.append(deptlist.index(depts[i]))
    indices = [j for j, x in enumerate(depts) if x == deptlist[i]]
    data_mini = data1[indices,:]
    data_mini = data_mini[:,indices]
    G=nx.from_numpy_matrix(data_mini)
    giant = max(nx.connected_component_subgraphs(G), key=len)
    length = len(giant)
    print 'Number of Nodes in the largest subcomponent of {} is: {}'.format(deptlist[i],length)
