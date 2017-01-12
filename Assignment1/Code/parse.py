import os
import re
import glob
import numpy as np
import csv

names = ["AM", "BT", "Chemistry", "CH", "Chemistry", "Civil", "CSE", "ED", "ee", "EP", "math", "Mech_CSV", "Meta", "Ocean Engg"]

all_profs = []
prof_dept = {}
adj_mat = np.zeros((544,544))

prof_id = {}
prof_name_from_id = {}

def get_all_profs():
    """
    Get a list of profs
    """
    for p in names:
        #  path = "data/" + p + "/*.csv"
        path = "CNA_data/" + p + "/*.csv"

        #  print(path)
        for filename in glob.iglob(path):
            f = open(filename, 'r')
            (f.readline())
            (f.readline())
            x = (f.readline())
            x = x[16:]
            x = x[:-2]
            x = (re.sub(' ', '' , x))

            all_profs.append(x)
            prof_dept[x] = p

def make_prof_map():
    """
    Map profs to ID's
    """
    count = 0
    for x in all_profs:
        prof_id[x] = count 
        prof_name_from_id[count] = x
        count = count + 1

def name_exists(x):
    """
    Check if prof is from IITM 
    """
    if x in all_profs:
        return True
    else: 
        return False

def get_adj_matrix():
    """
    Build Adj Matrix
    """
    for p in names:
        path = "CNA_data/" + p + "/*.csv"

        for filename in glob.iglob(path):
            print(filename)
            f = open(filename, 'r')

            (f.readline())
            (f.readline())
            q = (f.readline())
            q = q[16:]
            q = q[:-2]
            q = (re.sub(' ', '' , q))

            for i in range(6):
                (f.readline())
                x = f.readline()
                while(x.strip()):
                    x = f.readline()
                    st = x.split('"')

                    if(len(st)==1):
                        break
                    pr = st[1]
                    num = int(st[3])

                    if(name_exists(pr)):
                        adj_mat[prof_id[q]][prof_id[pr]] = adj_mat[prof_id[q]][prof_id[pr]] + num

def fix_adj_mat():
    sz = (len(adj_mat))
    for i in range(sz):
        for j in range(sz):
            if(i==j):
                adj_mat[i,j] = 0
            else:
                adj_mat[i,j] = max(adj_mat[i,j], adj_mat[j,i])

def create_node_table():
    """
    Create table of nodes
    """
    tab = []
    for x in all_profs:
        tab.append([x, prof_dept[x], prof_id[x]])

    with open("node_list.csv", "w") as f:
        writer = csv.writer(f)
        writer.writerows(tab)

def create_adj_mat():
    with open("adj_mat.csv", "w") as f:
        writer = csv.writer(f)
        writer.writerows(adj_mat)


get_all_profs()
make_prof_map()
get_adj_matrix()
fix_adj_mat()
create_node_table()
create_adj_mat()


