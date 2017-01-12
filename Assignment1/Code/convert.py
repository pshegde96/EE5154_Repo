import os
import re
import glob

for filename in glob.iglob('*.csv'):
    x = (filename[7:])
    y = x[:-14]
    y = y + ".csv"
    y = re.sub('[ ]', '\ ', y)
    filename = re.sub('[ ]', '\ ', filename)

    cmd = "mv " + filename + " " + y
    print(cmd)
    os.system(cmd)
