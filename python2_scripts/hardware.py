#!/usr/bin/env python
import os
import socket
import commands
import string
import sys
import psutil
import time

def getCpuUsage():
  cpu = 0
  for x in range(2):
    cpu += psutil.cpu_percent(interval=1)
  return round(float(cpu)/3,2)

def getMemUsage():
  mem=str(os.popen('free -t -m').readlines())
  T_ind=mem.index('T')
  mem=mem[T_ind+6:]
  mem_T=mem[:13]
  mem_sub=mem[14:]
  mem_U=mem_sub[:13]
  return round(float(mem_U)/float(mem_T)*100,2)

avgCpu = getCpuUsage()
memUsage = getMemUsage()

print avgCpu
print memUsage
