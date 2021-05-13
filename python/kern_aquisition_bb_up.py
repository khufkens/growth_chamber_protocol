import os
import csv

file_name = 'home/pi/Documents/mesure_balance.csv'
print(file_name)

comList = ["scale8"]
kerns = comFilter()

    def comFilter(self):
        kernList = []
        for y in self.comList:
            test = serial.Serial(port='/dev/'+y, inter_byte_timeout=3)
            test.flushInput()
            test.write(b'SI\r\n')
            time.sleep(.1)
            incommingBYTES = test.inWaiting()
            test.close()
            if incommingBYTES == 0:
                kernList = kernList
            else:
                kernList.append(KernBalance('/dev/'+y,3))
        return kernList

    def getWeights(self):
        weights = {}
        for r in self.kerns:
            weight = r.get_weight()
            weights.update({r.com:weight})
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        weights.update({"TIMESTAMP":timestamp})
        return weights


while True:
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
