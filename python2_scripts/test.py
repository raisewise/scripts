#!/usr/bin/env python

### os module, not save variable
#import os

#print os.system("cat /etc/redhat-release")
#print os.system("df -Th")

### subprocess module
#import subprocess

#subprocess.call(["cat","/etc/redhat-release"])
#subprocess.call(["df", "-Th"])

### subprocess module, save variable
import subprocess

os = subprocess.check_output(["cat","/etc/redhat-release"])
disk = subprocess.check_output(["df", "-Th"])

#print os
#print disk
print(os)
print(disk)
