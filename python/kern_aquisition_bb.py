from Kern_class_bb import Kerns
import os
import csv
import time

file_name = '/home/pi/Documents/mesure_balance.csv'
#print(file_name)

while True:
    ks = Kerns()
    dict = ks.getWeights()
    print(dict)
    if os.path.isfile(file_name):
        with open(file_name, 'a', newline='') as outfile:
            writer = csv.writer(outfile, delimiter=',')
            writer.writerow(dict.values())
    else:
        with open(file_name, 'w', newline='') as outfile:
            writer = csv.writer(outfile, delimiter=',')
            writer.writerow(dict.keys())
            writer.writerow(dict.values())
    time.sleep(5)
    


