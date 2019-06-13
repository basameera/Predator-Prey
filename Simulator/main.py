import json
import matplotlib.pyplot as plt
import numpy as np

from os import listdir
from os.path import isfile, join

mypath = 'data'
onlyfiles = [join(mypath, f) for f in listdir(mypath) if isfile(join(mypath, f))]

rabbit_data = []
fox_data = []

for filePath in onlyfiles:
    jfile = open(filePath)
    jdata = json.loads(jfile.read())
    rabbit_data.append(jdata['A'])
    fox_data.append(jdata['B'])

rabbit_data = np.array(rabbit_data)
fox_data = np.array(fox_data)
print(fox_data.shape)
rabbit_data = rabbit_data[:, :rabbit_data.shape[1]-1]
fox_data = fox_data[:, :fox_data.shape[1]-1]

rabbit_mean = np.mean(rabbit_data, axis=0)
rabbit_std = np.std(rabbit_data, axis=0)

t = np.arange(rabbit_mean.shape[0])

fox_mean = np.mean(fox_data, axis=0)
fox_std = np.std(fox_data, axis=0)

plt.plot(t, rabbit_mean, color='blue', label="Preys")
plt.fill_between(t, rabbit_mean - rabbit_std, rabbit_mean + rabbit_std, color='purple', alpha=0.3)

plt.plot(t, fox_mean, color='red', label="Predators")
plt.fill_between(t, fox_mean - fox_std, fox_mean + fox_std, color='orange', alpha=0.5)
plt.legend()

plt.title('Reaction-Difussion with Gillespie at cell (63, 35)')
plt.xlabel('Simulation Time Steps (per 0.25 sec)')
plt.ylabel('Animal Population')

plt.show()