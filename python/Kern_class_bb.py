# -*- coding: utf-8 -*-
import serial
import time
#import threading
from datetime import datetime

class KernBalance:
    """Repeat `function` every `interval` seconds."""
    def __init__(self, com, timeout):
        self.com = com
        print(com)
        self.timeout = timeout
        self.port = serial.Serial(port=self.com, inter_byte_timeout=self.timeout)
        #self.get_name()
        #self.isOpen = self.port.isOpen()

    def we_talk(self, ascii):
        try:
            with self.port as ser:
                connectedOrNot = ser.isOpen()
                if connectedOrNot:
                    ser.flushInput()
                    ser.write(ascii+b'\r\n')
                    time.sleep(.1)
                    incommingBYTES = ser.inWaiting()
                    if incommingBYTES == 0:
                        value = "NAN"
                        print("balance eteinte")
                    elif incommingBYTES == 5 :
                        value = "NAN"
                        print("out of range")
                    else:
                        reception = ser.read(incommingBYTES-2)
                        value = reception[8:]
                    ser.close()
                else:
                    value = "NAN"
                    print("sernotconnect")
        except serial.serialutil.SerialException:
            print("serialexeption")
            value = "NAN"
        return value

    def get_weight(self):
        cmd = b'SI'
        rec = self.we_talk(cmd)
        if rec != "NAN":
            rec = float(rec.decode()[0:6])
        return rec


class Kerns:
    def __init__(self):
        self.comList = ["scale1","scale2","scale3","scale4","scale5","scale6","scale7","scale8"]
        self.kerns = self.comFilter()

    def comFilter(self):
        kernList = []
        for y in self.comList:
            test = serial.Serial(port='/dev/'+y, inter_byte_timeout=3)
            test.flushInput()
            test.write(b'SI\r\n')
            time.sleep(.1)
            incommingBYTES = test.inWaiting()
            #test.close()
            if incommingBYTES == 0:
                kernList = kernList
            else:
                kernList.append(KernBalance('/dev/'+y,3))
        return kernList

    def getWeights(self):
        weights = {}
        for r in self.kerns:
            weight = r.get_weight()
            weights.update({r.com[5:]:weight})
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        weights.update({"TIMESTAMP":timestamp})
        return weights
